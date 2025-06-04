package com.example.spring.notice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    
    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
    
    @Autowired
    private NoticeService noticeService;
    
    /**
     * 공지사항 목록 페이지
     */
    @GetMapping("/list")
    public String noticeList(Model model, HttpSession session) {
        try {
            logger.debug("공지사항 목록 조회 요청");
            
            List<NoticeDto> notices = noticeService.getAllNotices();
            model.addAttribute("notices", notices);
            
            // 관리자 권한 확인
            boolean isAdmin = isAdminAuthenticated(session);
            model.addAttribute("isAdmin", isAdmin);
            
            logger.debug("공지사항 목록 조회 완료 - 총 {}개", notices.size());
            return "notice/list";
            
        } catch (Exception e) {
            logger.error("공지사항 목록 조회 중 오류: {}", e.getMessage(), e);
            model.addAttribute("error", "공지사항 목록을 불러오는 중 오류가 발생했습니다.");
            return "error/500";
        }
    }
    
    /**
     * 공지사항 상세 보기 페이지
     */
    @GetMapping("/detail/{id}")
    public String noticeDetail(@PathVariable Long id, Model model, HttpSession session) {
        try {
            logger.debug("공지사항 상세 조회 요청 - id: {}", id);
            
            NoticeDto notice = noticeService.getNoticeById(id);
            if (notice == null) {
                logger.debug("공지사항을 찾을 수 없음 - id: {}", id);
                return "redirect:/notice/list?error=not_found";
            }
            
            model.addAttribute("notice", notice);
            
            // 이전/다음 공지사항 조회 - 안전한 방식으로 수정
            try {
                NoticeDto prevNotice = noticeService.getPrevNotice(id);
                NoticeDto nextNotice = noticeService.getNextNotice(id);
                
                model.addAttribute("prevNotice", prevNotice);
                model.addAttribute("nextNotice", nextNotice);
                
            } catch (Exception e) {
                logger.debug("이전/다음 공지사항 조회 중 오류 (무시): {}", e.getMessage());
                // 이전/다음 공지사항 조회 실패는 무시하고 계속 진행
            }
            
            // 관리자 권한 확인
            boolean isAdmin = isAdminAuthenticated(session);
            model.addAttribute("isAdmin", isAdmin);
            
            return "notice/detail";
            
        } catch (Exception e) {
            logger.error("공지사항 상세 조회 중 오류: {}", e.getMessage(), e);
            return "redirect:/notice/list?error=server_error";
        }
    }
    
    /**
     * 공지사항 작성 폼 페이지 (관리자 전용)
     */
    @GetMapping("/write")
    public String noticeWriteForm(HttpSession session, Model model) {
        try {
            logger.debug("공지사항 작성 폼 요청");
            
            if (!isAdminAuthenticated(session)) {
                logger.debug("관리자 권한 없음 - 공지사항 작성 폼 접근 거부");
                return "redirect:/notice/list?error=unauthorized";
            }
            
            model.addAttribute("notice", new NoticeDto());
            return "notice/write";
            
        } catch (Exception e) {
            logger.error("공지사항 작성 폼 처리 중 오류: {}", e.getMessage(), e);
            return "redirect:/notice/list?error=server_error";
        }
    }
    
    /**
     * 공지사항 저장 (관리자 전용)
     */
    @PostMapping("/save")
    public String saveNotice(@ModelAttribute NoticeDto noticeDto, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        try {
            logger.debug("공지사항 저장 요청 - 제목: {}", noticeDto.getTitle());
            
            if (!isAdminAuthenticated(session)) {
                logger.debug("관리자 권한 없음 - 공지사항 저장 거부");
                redirectAttributes.addFlashAttribute("error", "관리자만 접근 가능합니다.");
                return "redirect:/notice/list";
            }
            
            // 유효성 검증
            if (!noticeService.validateNotice(noticeDto)) {
                logger.debug("공지사항 유효성 검증 실패");
                redirectAttributes.addFlashAttribute("error", "입력 정보를 확인해주세요.");
                return "redirect:/notice/write";
            }
            
            // 작성자 정보 설정
            String userId = (String) session.getAttribute("userId");
            noticeDto.setAuthor(userId != null ? userId : "관리자");
            
            boolean result = noticeService.createNotice(noticeDto);
            if (result) {
                logger.debug("공지사항 저장 성공");
                redirectAttributes.addFlashAttribute("success", "공지사항이 성공적으로 등록되었습니다.");
            } else {
                logger.debug("공지사항 저장 실패");
                redirectAttributes.addFlashAttribute("error", "공지사항 등록에 실패했습니다.");
            }
            
            return "redirect:/notice/list";
            
        } catch (Exception e) {
            logger.error("공지사항 저장 중 오류 발생: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "공지사항 등록 중 오류가 발생했습니다.");
            return "redirect:/notice/write";
        }
    }
    
    /**
     * 공지사항 수정 폼 페이지 (관리자 전용)
     */
    @GetMapping("/edit/{id}")
    public String noticeEditForm(@PathVariable Long id, 
                                HttpSession session, 
                                Model model) {
        try {
            logger.debug("공지사항 수정 폼 요청 - id: {}", id);
            
            if (!isAdminAuthenticated(session)) {
                logger.debug("관리자 권한 없음 - 공지사항 수정 폼 접근 거부");
                return "redirect:/notice/list?error=unauthorized";
            }
            
            NoticeDto notice = noticeService.getNoticeById(id);
            if (notice == null) {
                logger.debug("수정할 공지사항을 찾을 수 없음 - id: {}", id);
                return "redirect:/notice/list?error=not_found";
            }
            
            model.addAttribute("notice", notice);
            return "notice/write";
            
        } catch (Exception e) {
            logger.error("공지사항 수정 폼 처리 중 오류: {}", e.getMessage(), e);
            return "redirect:/notice/list?error=server_error";
        }
    }
    
    /**
     * 공지사항 수정 (관리자 전용)
     */
    @PostMapping("/update/{id}")
    public String updateNotice(@PathVariable Long id, 
                              @ModelAttribute NoticeDto noticeDto, 
                              HttpSession session, 
                              RedirectAttributes redirectAttributes) {
        try {
            logger.debug("공지사항 수정 요청 - id: {}", id);
            
            if (!isAdminAuthenticated(session)) {
                logger.debug("관리자 권한 없음 - 공지사항 수정 거부");
                redirectAttributes.addFlashAttribute("error", "관리자만 접근 가능합니다.");
                return "redirect:/notice/list";
            }
            
            // 유효성 검증
            if (!noticeService.validateNotice(noticeDto)) {
                logger.debug("공지사항 수정 유효성 검증 실패");
                redirectAttributes.addFlashAttribute("error", "입력 정보를 확인해주세요.");
                return "redirect:/notice/edit/" + id;
            }
            
            noticeDto.setId(id);
            boolean result = noticeService.updateNotice(noticeDto);
            
            if (result) {
                logger.debug("공지사항 수정 성공 - id: {}", id);
                redirectAttributes.addFlashAttribute("success", "공지사항이 성공적으로 수정되었습니다.");
                return "redirect:/notice/detail/" + id;
            } else {
                logger.debug("공지사항 수정 실패 - id: {}", id);
                redirectAttributes.addFlashAttribute("error", "공지사항 수정에 실패했습니다.");
                return "redirect:/notice/edit/" + id;
            }
            
        } catch (Exception e) {
            logger.error("공지사항 수정 중 오류 발생: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "공지사항 수정 중 오류가 발생했습니다.");
            return "redirect:/notice/edit/" + id;
        }
    }
    
    /**
     * 공지사항 삭제 (관리자 전용)
     */
    @PostMapping("/delete/{id}")
    public String deleteNotice(@PathVariable Long id, 
                              HttpSession session, 
                              RedirectAttributes redirectAttributes) {
        try {
            logger.debug("공지사항 삭제 요청 - id: {}", id);
            
            if (!isAdminAuthenticated(session)) {
                logger.debug("관리자 권한 없음 - 공지사항 삭제 거부");
                redirectAttributes.addFlashAttribute("error", "관리자만 접근 가능합니다.");
                return "redirect:/notice/list";
            }
            
            boolean result = noticeService.deleteNotice(id);
            if (result) {
                logger.debug("공지사항 삭제 성공 - id: {}", id);
                redirectAttributes.addFlashAttribute("success", "공지사항이 성공적으로 삭제되었습니다.");
            } else {
                logger.debug("공지사항 삭제 실패 - id: {}", id);
                redirectAttributes.addFlashAttribute("error", "공지사항 삭제에 실패했습니다.");
            }
            
            return "redirect:/notice/list";
            
        } catch (Exception e) {
            logger.error("공지사항 삭제 중 오류 발생: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "공지사항 삭제 중 오류가 발생했습니다.");
            return "redirect:/notice/list";
        }
    }
    
    /**
     * 공지사항 검색
     */
    @GetMapping("/search")
    public String searchNotices(@RequestParam(required = false) String title, 
                               Model model, 
                               HttpSession session) {
        try {
            logger.debug("공지사항 검색 요청 - 검색어: {}", title);
            
            List<NoticeDto> notices;
            
            if (title != null && !title.trim().isEmpty()) {
                notices = noticeService.searchNoticesByTitle(title.trim());
                model.addAttribute("searchKeyword", title);
            } else {
                notices = noticeService.getAllNotices();
            }
            
            model.addAttribute("notices", notices);
            
            // 관리자 권한 확인
            boolean isAdmin = isAdminAuthenticated(session);
            model.addAttribute("isAdmin", isAdmin);
            
            return "notice/list";
            
        } catch (Exception e) {
            logger.error("공지사항 검색 중 오류: {}", e.getMessage(), e);
            model.addAttribute("error", "검색 중 오류가 발생했습니다.");
            return "notice/list";
        }
    }
    
    /**
     * 관리자 인증 확인
     */
    private boolean isAdminAuthenticated(HttpSession session) {
        if (session == null) {
            return false;
        }
        
        try {
            // 1. userId로 확인
            String userId = (String) session.getAttribute("userId");
            if ("admin".equals(userId)) {
                return true;
            }
            
            // 2. role 속성으로 확인
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equals(role)) {
                return true;
            }
            
            // 3. 기존 방식으로 확인
            String password = (String) session.getAttribute("password");
            if (isAdminUser(userId, password)) {
                return true;
            }
            
            // 4. 다른 가능한 속성명들 확인
            Object userType = session.getAttribute("userType");
            Object authority = session.getAttribute("authority");
            
            if ("ADMIN".equals(userType) || "ADMIN".equals(authority)) {
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            logger.error("관리자 권한 확인 중 오류: {}", e.getMessage());
            return false;
        }
    }
    
    /**
     * 관리자 사용자 확인
     */
    private boolean isAdminUser(String userId, String password) {
        return "admin".equals(userId) && "admin1234".equals(password);
    }
}