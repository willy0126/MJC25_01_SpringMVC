package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable; // PathVariable을 위해 추가
import org.springframework.web.bind.annotation.PostMapping; // PostMapping을 위해 추가
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // RedirectAttributes를 위해 추가

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class adminconsoleController {

    private static final Logger logger = LoggerFactory.getLogger(adminconsoleController.class);

    @Autowired
    private adminconsoleService adminConsoleService; // 일관성을 위해 이름 변경

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

        List<ReservationDto> quickCounselingList = adminConsoleService.getAllQuickCounselingReservations();
        List<ObituaryReservationDto> funeralReservationList = adminConsoleService.getAllFuneralReservations();

        model.addAttribute("quickCounselingList", quickCounselingList);
        model.addAttribute("funeralReservationList", funeralReservationList);
        model.addAttribute("currentSection", section);

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
        return "redirect:/admin/console?section=funeral_reservations"; // 장례 예약 섹션으로 다시 리디렉션
    }
}