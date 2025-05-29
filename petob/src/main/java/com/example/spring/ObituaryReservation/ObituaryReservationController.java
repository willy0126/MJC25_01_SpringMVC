package com.example.spring.ObituaryReservation; // 패키지 경로는 동일하게 유지

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/obituary-reservation")
public class ObituaryReservationController {

    private static final Logger logger = LoggerFactory.getLogger(ObituaryReservationController.class);

    @GetMapping("/form")
    public String showObituaryReservationForm(@RequestParam(required = false) String branch, Model model) {
        logger.debug("장례 예약 폼 페이지 요청입니다.");
        if (branch != null && !branch.isEmpty()) {
            model.addAttribute("selectedBranch", branch);
            logger.debug("요청된 지점: {}", branch);
        }

        return "obituaryreservation/obituaryreservation";
    }

    // ... POST 핸들러 및 기타 메서드 ...
}