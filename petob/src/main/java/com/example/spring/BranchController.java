package com.example.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BranchController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(BranchController.class);

    // 절차 및 비용 페이지
    @GetMapping("/branches/mainbranch")
    public String showMainbranchPage() {
        logger.debug("BranchController: 본점 페이지 요청이 처리되었습니다.");

        return "mainbranch";
    }

    @GetMapping("/branches/subbranch1")
    public String showBranch1Page() {
        logger.debug("BranchController: 홍대 페이지 요청이 처리되었습니다.");

        return "subbranch1";
    }

    @GetMapping("/branches/subbranch2")
    public String showBranch2Page() {
        logger.debug("BranchController: 강남 페이지 요청이 처리되었습니다.");

        return "subbranch2";
    }
}
