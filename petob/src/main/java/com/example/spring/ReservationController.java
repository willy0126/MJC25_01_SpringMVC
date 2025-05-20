package com.example.spring;

import java.time.LocalDate;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReservationController {



    private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);




    @GetMapping("/reservation")
    public String showReservationForm(Model model) {
        model.addAttribute("reservation", new ReservationDto());
        logger.info("예약 폼 호출됨");  // 로그 출력
        return "reservation"; // /WEB-INF/views/reservation.jsp
    }

    @PostMapping("/reservation")
   public String handleReservation(@ModelAttribute ReservationDto reservation) {
    ReservationService.saveReservation(reservation); // DB에 저장

        // 실제 저장 로직(DB 연동 등)은 생략
        return "redirect:/"; // 예약 후 메인 화면으로 이동
    }
    @ResponseBody
    public List<String> getReservedTimes(@RequestParam("date") String dateStr) {
    // 예: dateStr = "2025-05-21"
    LocalDate date = LocalDate.parse(dateStr);
    List<String> reservedTimes = ReservationService.getReservedTimesByDate(date);
    return reservedTimes; // JSON 배열로 반환됨
}
}
