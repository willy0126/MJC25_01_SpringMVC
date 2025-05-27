package com.example.spring.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 간단한 예약 시스템 컨트롤러
 */
@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);

    /**
     * 예약 페이지 표시
     */
    @GetMapping("/reservation")
    public String showReservationPage() {
        logger.debug("예약 페이지 요청");
        return "reservation/reservation";
    }

    /**
     * 예약 등록 처리
     */
    @PostMapping("/reservation")
    public String createReservation(ReservationDto reservation, HttpServletRequest request, 
                                  RedirectAttributes redirectAttributes) {
        
        logger.debug("예약 시도: name={}, phone={}, email={}, date={}, time={}",
                reservation.getUsername(), reservation.getPhone(), reservation.getEmail(), 
                reservation.getDate(), reservation.getTime());

        // 예약 등록 처리
        boolean result = reservationService.create(reservation);

        if (result) {
            redirectAttributes.addFlashAttribute("successMessage", "예약이 완료되었습니다.");
            return "redirect:/reservation";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "해당 시간은 이미 예약되어 있습니다.");
            return "redirect:/reservation";
        }
    }

    /**
     * 예약 조회 페이지
     */
    @GetMapping("/reservation/check")
    public String showCheckPage() {
        return "reservation/check";
    }

    /**
     * 전화번호로 예약 조회
     */
    @PostMapping("/reservation/check")
    public String checkReservation(@RequestParam("phone") String phone, 
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes) {
        
        List<ReservationDto> reservations = reservationService.getReservationsByPhone(phone);

        if (reservations != null && !reservations.isEmpty()) {
            request.setAttribute("reservations", reservations);
            request.setAttribute("phone", phone);
            return "reservation/check";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "해당 전화번호로 등록된 예약이 없습니다.");
            return "redirect:/reservation/check";
        }
    }

    /**
     * 특정 날짜의 예약된 시간 조회 (Ajax)
     */
    @PostMapping("/reservation/check-booked-times")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkBookedTimes(@RequestParam("date") String date) {
        
        List<String> bookedTimes = reservationService.getBookedTimes(date);
        
        Map<String, Object> response = new HashMap<>();
        response.put("bookedTimes", bookedTimes != null ? bookedTimes : new java.util.ArrayList<>());

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(response);
    }

    /**
     * 시간 중복 체크 (Ajax)
     */
    @PostMapping("/reservation/check-time-available")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkTimeAvailable(@RequestParam("date") String date,
                                                                 @RequestParam("time") String time) {
        
        boolean available = reservationService.isTimeSlotAvailable(date, time);
        
        Map<String, Object> response = new HashMap<>();
        response.put("available", available);

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(response);
    }
}