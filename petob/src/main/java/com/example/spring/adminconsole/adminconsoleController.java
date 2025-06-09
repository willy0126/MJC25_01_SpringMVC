package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto;
import com.example.spring.inquiry.InquiryService;
import com.example.spring.inquiry.InquiryDto;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class adminconsoleController {
    
    private static final Logger logger = LoggerFactory.getLogger(adminconsoleController.class);

    @Autowired
    private adminconsoleService adminConsoleService;
    
    @Autowired
    private InquiryService inquiryService;  // 문의 서비스 추가

    @GetMapping("/console")
    public String showAdminConsole(
            @RequestParam(value = "section", required = false, defaultValue = "quick_counseling") String section,
            Model model,
            HttpSession session) {

        String userId = (String) session.getAttribute("userId");
        if (!"admin".equals(userId)) {
            logger.warn("관리자 콘솔에 대한 무단 접근 시도: 사용자 ID {}", userId);
            return "redirect:/login";
        }

        logger.info("관리자 콘솔 페이지 요청. 사용자 ID: {}, 섹션: {}", userId, section);

        try {
            // 기본 데이터 조회
            List<ReservationDto> quickCounselingList = adminConsoleService.getAllQuickCounselingReservations();
            List<ObituaryReservationDto> funeralReservationList = adminConsoleService.getAllFuneralReservations();

            model.addAttribute("quickCounselingList", quickCounselingList);
            model.addAttribute("funeralReservationList", funeralReservationList);
            model.addAttribute("currentSection", section);

            // 임시로 모든 섹션에서 문의 데이터 조회 (디버깅용)
            logger.info("=== 문의 데이터 조회 시작 ===");
            logger.info("현재 섹션: {}", section);
            
            try {
                // 기존 InquiryController의 작동하는 URL로 리다이렉트해서 데이터 가져오기
                logger.info("=== 문의 데이터 조회 시작 (기존 컨트롤러 활용) ===");
                
                // 직접 InquiryService 대신 기존에 작동하는 방식 사용
                if (inquiryService != null) {
                    Map<String, Object> inquiryResult = inquiryService.list(1, 100, null, null, null);
                    logger.info("inquiryService.list() 결과: {}", inquiryResult);
                    
                    if (inquiryResult != null && inquiryResult.get("inquiries") != null) {
                        @SuppressWarnings("unchecked")
                        List<InquiryDto> inquiryList = (List<InquiryDto>) inquiryResult.get("inquiries");
                        model.addAttribute("inquiryList", inquiryList);
                        logger.info("문의 데이터 조회 성공. 총 {}건", inquiryList.size());
                    } else {
                        logger.warn("inquiryResult가 null이거나 inquiries가 없습니다.");
                        model.addAttribute("inquiryList", new java.util.ArrayList<>());
                    }
                } else {
                    logger.error("InquiryService가 null입니다.");
                    model.addAttribute("inquiryList", new java.util.ArrayList<>());
                }
                
            } catch (Exception e) {
                logger.error("문의 데이터 조회 중 오류: {}", e.getMessage(), e);
                model.addAttribute("inquiryList", new java.util.ArrayList<>());
                model.addAttribute("errorMessage", "문의 데이터 조회 중 오류: " + e.getMessage());
            }
            
            logger.info("=== 문의 데이터 조회 완료 ===");

        } catch (Exception e) {
            logger.error("관리자 콘솔 데이터 조회 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "데이터를 불러오는 중 오류가 발생했습니다.");
        }

        return "adminconsole/adminconsole";
    }

    @PostMapping("/obituary/{reservationId}/accept")
    public String acceptObituaryReservation(
            @PathVariable("reservationId") int reservationId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        return updateObituaryStatus(reservationId, "수락", session, redirectAttributes);
    }

    @PostMapping("/obituary/{reservationId}/reject")
    public String rejectObituaryReservation(
            @PathVariable("reservationId") int reservationId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        return updateObituaryStatus(reservationId, "거절", session, redirectAttributes);
    }

    private String updateObituaryStatus(int reservationId, String status, HttpSession session,
            RedirectAttributes redirectAttributes) {
        String adminId = (String) session.getAttribute("userId");
        if (!"admin".equals(adminId)) {
            redirectAttributes.addFlashAttribute("errorMessage", "권한이 없습니다.");
            return "redirect:/login";
        }

        boolean success = adminConsoleService.updateObituaryReservationStatus(reservationId, status);

        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "예약 상태가 '" + status + "'(으)로 변경되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "예약 상태 변경에 실패했습니다.");
        }
        return "redirect:/admin/console?section=funeral_reservations";
    }
    
    /**
     * 관리자 전용 문의 상세 조회
     */
    @GetMapping("/inquiry/view/{inquiryId}")
    public String viewInquiry(@PathVariable Long inquiryId, Model model, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (!"admin".equals(userId)) {
            logger.warn("관리자 문의 조회에 대한 무단 접근 시도: 사용자 ID {}", userId);
            return "redirect:/login";
        }

        try {
            InquiryDto inquiry = inquiryService.read(inquiryId);
            if (inquiry == null) {
                model.addAttribute("errorMessage", "존재하지 않는 문의입니다.");
                return "redirect:/admin/console?section=inquiry_board";
            }

            model.addAttribute("inquiry", inquiry);
            model.addAttribute("canReply", true); // 관리자는 항상 답변 가능
            
            return "inquiry/view"; // 기존 문의 상세 페이지 재사용

        } catch (Exception e) {
            logger.error("관리자 문의 상세 조회 중 오류 발생: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "문의를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/admin/console?section=inquiry_board";
        }
    }
}