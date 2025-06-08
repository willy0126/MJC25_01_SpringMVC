package com.example.spring.inquiry;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 문의게시판 관련 요청을 처리하는 컨트롤러
 * - 문의 작성, 조회, 수정, 삭제, 목록 조회 등의 웹 요청 처리
 */
@Controller
@RequestMapping("/inquiry")
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    private static final Logger logger = LoggerFactory.getLogger(InquiryController.class);

    /**
     * 로그인 상태 체크 API (AJAX용)
     */
    @GetMapping("/check-login")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkLogin(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        HttpSession session = request.getSession(false);
        boolean isLoggedIn = false;
        String userId = null;

        if (session != null) {
            // 다양한 세션 속성명 체크
            userId = (String) session.getAttribute("userId");
            if (userId == null) {
                Object user = session.getAttribute("user");
                if (user != null) {
                    isLoggedIn = true;
                    // user 객체에서 ID 추출 시도
                    try {
                        java.lang.reflect.Method getId = user.getClass().getMethod("getId");
                        userId = (String) getId.invoke(user);
                    } catch (Exception e) {
                        // ID 추출 실패해도 로그인은 인정
                        logger.debug("user 객체에서 ID 추출 실패: {}", e.getMessage());
                    }
                }
            } else {
                isLoggedIn = true;
            }

            // 다른 가능한 세션 속성들도 체크
            if (!isLoggedIn) {
                Object loginUser = session.getAttribute("loginUser");
                Object member = session.getAttribute("member");
                isLoggedIn = (loginUser != null) || (member != null);
            }
        }

        response.put("isLoggedIn", isLoggedIn);
        response.put("userId", userId);

        logger.debug("로그인 상태 체크 - isLoggedIn: {}, userId: {}", isLoggedIn, userId);

        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
    }

    /**
     * 문의 목록 페이지 - 루트 경로
     * JSP에서 /inquiry로 요청하므로 추가
     */
    @GetMapping({ "", "/" })
    public String inquiryMain(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String status,
            Model model) {

        return list(page, size, search, category, status, model);
    }

    /**
     * 문의 목록 페이지
     * - 전체 문의 목록을 페이징과 검색 기능과 함께 조회
     */
    @GetMapping("/list")
    public String list(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String status,
            Model model) {

        logger.debug("문의 목록 조회 요청 - page: {}, size: {}, search: {}, category: {}, status: {}",
                page, size, search, category, status);

        try {
            Map<String, Object> result = inquiryService.list(page, size, search, category, status);

            model.addAttribute("inquiryList", result.get("inquiries")); // JSP와 맞춤
            model.addAttribute("currentPage", result.get("currentPage"));
            model.addAttribute("totalPages", result.get("totalPages"));
            model.addAttribute("totalCount", result.get("totalCount"));
            model.addAttribute("pageSize", result.get("size")); // JSP와 맞춤
            model.addAttribute("search", search);
            model.addAttribute("category", category);
            model.addAttribute("status", status);

            // 페이징 정보 추가
            int startPage = Math.max(1, page - 2);
            int endPage = Math.min((Integer) result.get("totalPages"), page + 2);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);

            // 검색 파라미터 문자열 생성
            StringBuilder searchParams = new StringBuilder();
            if (category != null && !category.isEmpty()) {
                searchParams.append("&category=").append(category);
            }
            if (search != null && !search.isEmpty()) {
                searchParams.append("&search=").append(search);
            }
            if (status != null && !status.isEmpty()) {
                searchParams.append("&status=").append(status);
            }
            model.addAttribute("searchParams", searchParams.toString());

            return "inquiry/list"; // 최종: /WEB-INF/views/pages/inquiry/list.jsp

        } catch (Exception e) {
            logger.error("문의 목록 조회 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "문의 목록을 불러오는 중 오류가 발생했습니다.");
            return "inquiry/list";
        }
    }

    /**
     * 내 문의 목록 페이지
     * - 로그인한 사용자가 작성한 문의 목록 조회
     */
    @GetMapping("/my-list")
    public String myList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            return "redirect:/login?returnUrl=/inquiry/my-list";
        }

        String userId = (String) session.getAttribute("userId");
        logger.debug("내 문의 목록 조회 요청 - userId: {}, page: {}, size: {}", userId, page, size);

        try {
            Map<String, Object> result = inquiryService.listByUser(userId, page, size);

            model.addAttribute("inquiryList", result.get("inquiries")); // JSP와 맞춤
            model.addAttribute("currentPage", result.get("currentPage"));
            model.addAttribute("totalPages", result.get("totalPages"));
            model.addAttribute("totalCount", result.get("totalCount"));
            model.addAttribute("pageSize", result.get("size"));

            return "inquiry/myList";

        } catch (Exception e) {
            logger.error("내 문의 목록 조회 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "문의 목록을 불러오는 중 오류가 발생했습니다.");
            return "inquiry/myList";
        }
    }

    /**
     * 문의 상세 조회 페이지
     */
    @GetMapping("/view/{inquiryId}")
    public String view(@PathVariable Long inquiryId, Model model, HttpServletRequest request) {
        logger.debug("문의 상세 조회 요청 - inquiryId: {}", inquiryId);

        try {
            InquiryDto inquiry = inquiryService.read(inquiryId);

            if (inquiry == null) {
                model.addAttribute("errorMessage", "존재하지 않는 문의입니다.");
                return "inquiry/view";
            }

            // 로그인 사용자 정보 확인
            HttpSession session = request.getSession(false);
            String currentUserId = (session != null) ? (String) session.getAttribute("userId") : null;
            String role = (session != null) ? (String) session.getAttribute("role") : null;

            // 작성자 또는 관리자만 조회 가능
            boolean canView = "ADMIN".equals(role) ||
                    (currentUserId != null && currentUserId.equals(inquiry.getUserId()));

            if (!canView) {
                model.addAttribute("errorMessage", "해당 문의를 조회할 권한이 없습니다.");
                return "inquiry/view";
            }

            model.addAttribute("inquiry", inquiry);
            model.addAttribute("canEdit", currentUserId != null && currentUserId.equals(inquiry.getUserId()) &&
                    !"COMPLETED".equals(inquiry.getStatus()));
            model.addAttribute("canReply", "ADMIN".equals(role));

            return "inquiry/view";

        } catch (Exception e) {
            logger.error("문의 상세 조회 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "문의를 불러오는 중 오류가 발생했습니다.");
            return "inquiry/view";
        }
    }

    /**
     * 문의 작성 페이지
     */
    @GetMapping("/write")
    public String writeForm(Model model, HttpServletRequest request) {
        if (request.getSession(false) == null || request.getSession(false).getAttribute("userId") == null) {
            return "redirect:/login";
        }
        model.addAttribute("inquiry", new InquiryDto());
        model.addAttribute("mode", "write");
        return "inquiry/write";
    }

    /**
     * 문의 등록 처리
     */
    @PostMapping("/write")
    public String write(InquiryDto inquiry, HttpServletRequest request, RedirectAttributes redirect) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        inquiry.setUserId((String) session.getAttribute("userId"));
        inquiry.setUsername((String) session.getAttribute("username"));

        try {
            inquiryService.create(inquiry);
            redirect.addFlashAttribute("successMessage", "문의가 등록되었습니다.");
            return "redirect:/inquiry/list";
        } catch (Exception e) {
            logger.error("문의 등록 중 오류 발생: {}", e.getMessage(), e);
            redirect.addFlashAttribute("errorMessage", "문의 등록 중 오류가 발생했습니다.");
            return "redirect:/inquiry/write";
        }
    }

    /**
     * 문의 수정 페이지
     */
    @GetMapping("/edit/{inquiryId}")
    public String editForm(@PathVariable Long inquiryId, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            return "redirect:/login?returnUrl=/inquiry/edit/" + inquiryId;
        }

        String currentUserId = (String) session.getAttribute("userId");

        try {
            InquiryDto inquiry = inquiryService.read(inquiryId);
            if (inquiry == null) {
                model.addAttribute("errorMessage", "존재하지 않는 문의입니다.");
                return "redirect:/inquiry/list";
            }

            if (!inquiry.getUserId().equals(currentUserId)) {
                model.addAttribute("errorMessage", "수정 권한이 없습니다.");
                return "redirect:/inquiry/list";
            }

            if ("COMPLETED".equals(inquiry.getStatus())) {
                model.addAttribute("errorMessage", "답변 완료된 문의는 수정할 수 없습니다.");
                return "redirect:/inquiry/view/" + inquiryId;
            }

            model.addAttribute("inquiry", inquiry);
            model.addAttribute("mode", "edit");
            return "inquiry/write"; // JSP 통합 파일

        } catch (Exception e) {
            logger.error("문의 수정 페이지 로드 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "오류가 발생했습니다.");
            return "redirect:/inquiry/list";
        }
    }

    /**
     * 문의 수정 처리
     */
    @PostMapping("/edit/{inquiryId}")
    public String edit(@PathVariable Long inquiryId, InquiryDto inquiry,
            HttpServletRequest request, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            return "redirect:/login?returnUrl=/inquiry/edit/" + inquiryId;
        }

        String currentUserId = (String) session.getAttribute("userId");
        inquiry.setInquiryId(inquiryId);

        logger.debug("문의 수정 요청 - inquiryId: {}, userId: {}", inquiryId, currentUserId);

        try {
            boolean updated = inquiryService.update(inquiry, currentUserId);
            if (updated) {
                redirectAttributes.addFlashAttribute("successMessage", "문의가 수정되었습니다.");
                return "redirect:/inquiry/view/" + inquiryId;
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "문의 수정에 실패했습니다.");
                return "redirect:/inquiry/edit/" + inquiryId;
            }
        } catch (Exception e) {
            logger.error("문의 수정 중 오류 발생: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "문의 수정 중 오류가 발생했습니다.");
            return "redirect:/inquiry/edit/" + inquiryId;
        }
    }

    /**
     * 문의 삭제 처리
     */
    @PostMapping("/delete/{inquiryId}")
    public String delete(@PathVariable Long inquiryId, HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        String currentUserId = (String) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");
        boolean isAdmin = "ADMIN".equals(role);

        logger.debug("문의 삭제 요청 - inquiryId: {}, userId: {}, isAdmin: {}", inquiryId, currentUserId, isAdmin);

        try {
            boolean result = inquiryService.delete(inquiryId, currentUserId, isAdmin);

            if (result) {
                redirectAttributes.addFlashAttribute("successMessage", "문의가 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "문의 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            logger.error("문의 삭제 중 오류 발생: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "문의 삭제 중 오류가 발생했습니다.");
        }

        return "redirect:/mypage";
    }

    /**
     * 관리자 답변 처리 (일반 POST로 변경)
     */
    @PostMapping("/reply")
    public String reply(@RequestParam Long inquiryId,
            @RequestParam String reply,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            redirectAttributes.addFlashAttribute("errorMessage", "관리자 권한이 필요합니다.");
            return "redirect:/inquiry/view/" + inquiryId;
        }

        String replyBy = (String) session.getAttribute("userId");
        if (replyBy == null) {
            replyBy = "관리자";
        }

        logger.debug("문의 답변 요청 - inquiryId: {}, replyBy: {}", inquiryId, replyBy);

        try {
            boolean result = inquiryService.reply(inquiryId, reply, replyBy);

            if (result) {
                redirectAttributes.addFlashAttribute("successMessage", "답변이 성공적으로 등록되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "답변 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            logger.error("문의 답변 중 오류 발생: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "답변 등록 중 오류가 발생했습니다.");
        }

        return "redirect:/inquiry/view/" + inquiryId;
    }

    /**
     * 관리자 답변 처리 (AJAX용 - 기존 호환성 유지)
     */
    @PostMapping("/reply/{inquiryId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> replyAjax(@PathVariable Long inquiryId,
            @RequestParam String reply,
            HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.put("success", false);
            response.put("message", "관리자 권한이 필요합니다.");
            return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
        }

        String replyBy = (String) session.getAttribute("userId");
        if (replyBy == null) {
            replyBy = "관리자";
        }

        logger.debug("문의 답변 요청 (AJAX) - inquiryId: {}, replyBy: {}", inquiryId, replyBy);

        try {
            boolean result = inquiryService.reply(inquiryId, reply, replyBy);

            if (result) {
                response.put("success", true);
                response.put("message", "답변이 성공적으로 등록되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "답변 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            logger.error("문의 답변 중 오류 발생: {}", e.getMessage(), e);
            response.put("success", false);
            response.put("message", "답변 등록 중 오류가 발생했습니다.");
        }

        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
    }

    /**
     * 문의 상태 변경 처리 (AJAX)
     */
    @PostMapping("/status/{inquiryId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateStatus(@PathVariable Long inquiryId,
            @RequestParam String status,
            HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.put("success", false);
            response.put("message", "관리자 권한이 필요합니다.");
            return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
        }

        logger.debug("문의 상태 변경 요청 - inquiryId: {}, status: {}", inquiryId, status);

        try {
            boolean result = inquiryService.updateStatus(inquiryId, status);

            if (result) {
                response.put("success", true);
                response.put("message", "상태가 성공적으로 변경되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "상태 변경에 실패했습니다.");
            }

        } catch (Exception e) {
            logger.error("문의 상태 변경 중 오류 발생: {}", e.getMessage(), e);
            response.put("success", false);
            response.put("message", "상태 변경 중 오류가 발생했습니다.");
        }

        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
    }

    /**
     * 관리자 전용 - 전체 문의 관리 페이지
     */
    @GetMapping("/admin")
    public String admin(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "15") int size,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String status,
            Model model,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            return "redirect:/login?returnUrl=/inquiry/admin";
        }

        logger.debug("관리자 문의 관리 페이지 요청 - page: {}, size: {}, search: {}, category: {}, status: {}",
                page, size, search, category, status);

        try {
            Map<String, Object> result = inquiryService.list(page, size, search, category, status);

            model.addAttribute("inquiryList", result.get("inquiries")); // JSP와 맞춤
            model.addAttribute("currentPage", result.get("currentPage"));
            model.addAttribute("totalPages", result.get("totalPages"));
            model.addAttribute("totalCount", result.get("totalCount"));
            model.addAttribute("pageSize", result.get("size"));
            model.addAttribute("search", search);
            model.addAttribute("category", category);
            model.addAttribute("status", status);

            return "inquiry/admin";

        } catch (Exception e) {
            logger.error("관리자 문의 관리 페이지 로드 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "문의 목록을 불러오는 중 오류가 발생했습니다.");
            return "inquiry/admin";
        }
    }
}