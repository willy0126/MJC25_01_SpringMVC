package com.example.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * MainController: 루트(“/”) 요청을 처리하는 스프링 MVC 컨트롤러
 */
@Controller
public class MainController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    @RequestMapping(value = "/")
    public String index() {
        // 로그 메시지 출력
        logger.debug("MainController: 메인 페이지 요청이 처리되었습니다.");

        // "main" 뷰 이름을 반환
        return "main";
    }
}
