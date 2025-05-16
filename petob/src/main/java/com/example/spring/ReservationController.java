package com.example.spring; 

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReservationController {


    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);


    // 절차 및 비용 페이지
    @GetMapping("/reservation")
    public String showlocationPage() {
        logger.debug("ReservationController:페이지 요청이 처리되었습니다.");
        
        return "reservation"; 
    }
}
