package com.example.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PolicyController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(PolicyController.class);

    // 절차 및 비용 페이지
    @GetMapping("/policy/terms")
    public String showTermsPage() {
        logger.debug("PolicyController: 이용 약관 요청이 처리되었습니다.");

        return "terms";
    }

    // 부고장 작성 페이지
    @GetMapping("/policy/privacy")
    public String showPrivacyPage() {
        logger.debug("PolicyController: 개인정보 처리방침 요청이 처리되었습니다.");

        return "privacy";
    }
}
