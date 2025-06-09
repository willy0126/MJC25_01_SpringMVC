package com.example.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CSController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(InfoController.class);

    // FAQ 페이지 요청 처리
    @GetMapping("/faq")
    public String showFAQPage() {
        logger.debug("CSController: FAQ 페이지 요청이 처리되었습니다.");

        return "faq";
    }
}