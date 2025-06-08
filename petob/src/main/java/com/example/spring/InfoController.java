package com.example.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InfoController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(InfoController.class);

    // 절차 및 비용 페이지
    @GetMapping("/info/procedure")
    public String showProcedurePage() {
        logger.debug("InfoController: 절차 및 비용 안내 요청이 처리되었습니다.");

        return "procedure";
    }

    // 부고장 작성 페이지
    // @GetMapping("/info/obituary")
    // public String showObituaryPage() {
    // logger.debug("InfoController: 부고장 작성 요청이 처리되었습니다.");

    // return "obituary";
}
