package com.example.spring; 

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    // 절차 및 비용 페이지
    @GetMapping("/login")
    public String showLoginPage() {
        logger.debug("AuthController: 로그인 페이지 요청이 처리되었습니다.");
        
        return "login"; 
    }
}
