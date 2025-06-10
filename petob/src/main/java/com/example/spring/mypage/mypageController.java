package com.example.spring.mypage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

import com.example.spring.user.UserDto;
import com.example.spring.user.UserService;
import com.example.spring.inquiry.InquiryService; // 문의 서비스 추가

@Controller
@RequestMapping(value = "/mypage")
public class mypageController {

    private static final Logger logger = LoggerFactory.getLogger(mypageController.class);

    @Autowired
    private mypageService mypageService;

    @Autowired
    private UserService userService;
    
    @Autowired
    private InquiryService inquiryService; // 문의 서비스 주입

    // 기본 마이페이지 (예약 내역 등)
    @GetMapping
    public String userMyPage(HttpSession session, Model model) {
        String currentUserId = (String) session.getAttribute("userId");
        if (currentUserId == null) {
            return "redirect:/login";
        }

        logger.info("마이페이지 요청: 사용자 ID '{}'", currentUserId);

        try {
            List<mypageDto> funeralReservationList = mypageService.getMyFuneralReservations(currentUserId);
            model.addAttribute("funeralReservationList", funeralReservationList);
            if (funeralReservationList.isEmpty()) {
                model.addAttribute("funeralMessage", "현재까지 신청하신 장례 예약 내역이 없습니다.");
            }
        } catch (Exception e) {
            logger.error("장례 예약 목록 조회 중 오류: {}", e.getMessage(), e);
            model.addAttribute("funeralMessage", "장례 예약 서비스 준비 중입니다.");
        }

        // 사용자 정보도 함께 전달 (이름 등 표시용)
        UserDto userToRead = new UserDto();
        userToRead.setUserId(currentUserId);
        UserDto currentUser = userService.read(userToRead);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("currentSection", "reservations"); // 현재 섹션 표시

        return "mypage/mypage";
    }

  @GetMapping("/my-inquiry")
public String myInquiry(
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "10") int size,
        Model model, 
        HttpSession session) {
    
    String userId = (String) session.getAttribute("userId");
    logger.info("=== 나의 문의 요청 시작 ===");
    logger.info("사용자 ID: {}", userId);
    logger.info("요청 페이지: {}, 크기: {}", page, size);
    
    if (userId == null) {
        return "redirect:/login?returnUrl=/mypage/my-inquiry";
    }

    try {
        // 사용자별 문의 목록 조회
        Map<String, Object> result = inquiryService.listByUser(userId, page, size);
        
        // 🔍 디버깅 로그 추가
        logger.info("=== 서비스 조회 결과 ===");
        logger.info("전체 결과: {}", result);
        
        List<?> inquiries = (List<?>) result.get("inquiries");
        logger.info("조회된 문의 목록 크기: {}", inquiries != null ? inquiries.size() : 0);
        
        if (inquiries != null) {
            for (int i = 0; i < inquiries.size(); i++) {
                logger.info("문의 [{}]: {}", i, inquiries.get(i));
            }
        }
        
        Integer totalCount = (Integer) result.get("totalCount");
        logger.info("전체 문의 개수: {}", totalCount);
        logger.info("현재 페이지: {}", result.get("currentPage"));
        logger.info("전체 페이지: {}", result.get("totalPages"));

        model.addAttribute("myInquiryList", inquiries);
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", result.get("size"));

        // 페이징 정보
        int totalPages = (Integer) result.get("totalPages");
        int startPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPages, page + 2);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        logger.info("=== 모델에 추가된 데이터 ===");
        logger.info("myInquiryList 크기: {}", inquiries != null ? inquiries.size() : 0);
        logger.info("totalCount: {}", totalCount);

        return "mypage/my-inquiry";

    } catch (Exception e) {
        logger.error("나의 문의 목록 조회 중 오류: {}", e.getMessage(), e);
        model.addAttribute("errorMessage", "문의 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        model.addAttribute("myInquiryList", new java.util.ArrayList<>());
        return "mypage/my-inquiry";
    }
}
    // --- 개인정보 수정 관련 ---
    @GetMapping("/edit")
    public String editProfileForm(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        UserDto userToRead = new UserDto();
        userToRead.setUserId(userId);
        UserDto user = userService.read(userToRead);
        model.addAttribute("user", user);
        model.addAttribute("currentSection", "editProfile");
        return "mypage/editProfile";
    }

    @PostMapping("/edit")
    public String editProfile(UserDto userDto, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        userDto.setUserId(userId); // 현재 로그인한 사용자의 ID로 설정

        boolean success = userService.updateUserProfile(userDto);
        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "회원 정보가 성공적으로 수정되었습니다.");
            // 사용자 이름이 변경되었을 수 있으므로 세션 업데이트
            session.setAttribute("username", userDto.getUsername());
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "회원 정보 수정에 실패했습니다.");
        }
        return "redirect:/mypage/edit";
    }

    // --- 비밀번호 변경 관련 ---
    @GetMapping("/change-password")
    public String changePasswordForm(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        model.addAttribute("currentSection", "changePassword");
        return "mypage/changePassword";
    }

    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmNewPassword") String confirmNewPassword,
            HttpSession session, RedirectAttributes redirectAttributes) {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        if (!newPassword.equals(confirmNewPassword)) {
            redirectAttributes.addFlashAttribute("errorMessage", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
            return "redirect:/mypage/change-password";
        }

        int result = userService.updatePassword(userId, currentPassword, newPassword);
        if (result == 0) {
            redirectAttributes.addFlashAttribute("successMessage", "비밀번호가 성공적으로 변경되었습니다.");
            return "redirect:/mypage";
        } else if (result == 1) {
            redirectAttributes.addFlashAttribute("errorMessage", "현재 비밀번호가 일치하지 않습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "비밀번호 변경에 실패했습니다.");
        }
        return "redirect:/mypage/change-password";
    }

    // --- 비밀번호 확인 (정보 수정, 탈퇴 등 민감한 작업 전) ---
    @GetMapping("/confirm-password")
    public String confirmPasswordForm(@RequestParam String action, HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        model.addAttribute("action", action); // 다음 진행할 작업 (e.g., "withdraw")
        return "mypage/confirmPassword";
    }

    @PostMapping("/confirm-password")
    public String confirmPassword(
            @RequestParam String password,
            @RequestParam String action, // 다음 액션 구분
            HttpSession session, RedirectAttributes redirectAttributes) {

        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        boolean passwordMatch = userService.checkPassword(userId, password);

        if (passwordMatch) {
            session.setAttribute("passwordConfirmed", true); // 비밀번호 확인 완료 세션 플래그
            if ("withdraw".equals(action)) {
                return "redirect:/mypage/withdraw-confirm"; // 실제 탈퇴 확인 페이지로
            }
            // 다른 action에 대한 처리 추가 가능
            redirectAttributes.addFlashAttribute("errorMessage", "잘못된 접근입니다.");
            return "redirect:/mypage";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            return "redirect:/mypage/confirm-password?action=" + action;
        }
    }

    // --- 회원 탈퇴 관련 ---
    @GetMapping("/withdraw") // 비밀번호 확인 페이지를 먼저 거치도록 변경
    public String withdrawPrompt(HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        // 바로 탈퇴 페이지로 보내지 않고, 비밀번호 확인을 먼저 거치도록 유도
        return "redirect:/mypage/confirm-password?action=withdraw";
    }

    @GetMapping("/withdraw-confirm") // 비밀번호 확인 후 실제 탈퇴 의사를 묻는 페이지
    public String withdrawConfirmForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (session.getAttribute("passwordConfirmed") == null || !(Boolean) session.getAttribute("passwordConfirmed")) {
            redirectAttributes.addFlashAttribute("errorMessage", "비밀번호 확인이 필요합니다.");
            return "redirect:/mypage/confirm-password?action=withdraw";
        }
        session.removeAttribute("passwordConfirmed"); // 확인 후 플래그 제거
        model.addAttribute("currentSection", "withdraw");
        return "mypage/withdraw"; // 실제 탈퇴 동의를 받는 JSP
    }

    @PostMapping("/withdraw")
    public String withdrawUser(
            HttpServletRequest request,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            @RequestParam(value = "confirmWithdraw", required = false) String confirmWithdraw) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        String passwordFromForm = request.getParameter("password");

        if (passwordFromForm == null || passwordFromForm.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "회원 탈퇴를 위해 비밀번호를 입력해주세요.");
            return "redirect:/mypage/withdraw-confirm";
        }

        int result = userService.deleteUser(userId, passwordFromForm);

        if (result == 0) {
            session.invalidate();
            redirectAttributes.addFlashAttribute("successMessage", "회원 탈퇴가 완료되었습니다. 이용해주셔서 감사합니다.");
            return "redirect:/";
        } else if (result == 1) {
            redirectAttributes.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않아 탈퇴할 수 없습니다.");
            return "redirect:/mypage/withdraw-confirm";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "회원 탈퇴 처리 중 오류가 발생했습니다.");
            return "redirect:/mypage";
        }
    }
}