package com.example.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LocationController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(LocationController.class);

    // 절차 및 비용 페이지
    @GetMapping("/location")
    public String showLocationPage() {
        logger.debug("LocationController: 지점 위치 페이지 요청이 처리되었습니다.");

        return "location";
    }
}
