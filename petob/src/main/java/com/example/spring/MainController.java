package com.example.spring;

import com.example.spring.notice.NoticeDto;
import com.example.spring.notice.NoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * MainController: 루트("/") 요청을 처리하는 스프링 MVC 컨트롤러
 */
@Controller
public class MainController {

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);
    
    // NoticeService 의존성 주입
    @Autowired
    private NoticeService noticeService;

    @RequestMapping(value = "/")
    public String index(Model model) {
        return handleMainPage(model);
    }
    
    @GetMapping("/main")
    public String main(Model model) {
        return handleMainPage(model);
    }
    
    private String handleMainPage(Model model) {
        System.out.println("=== MainController.handleMainPage() 호출 ===");
        
        // 로그 메시지 출력
        logger.debug("MainController: 메인 페이지 요청이 처리되었습니다.");

        try {
            // NoticeService 인젝션 확인
            System.out.println("NoticeService 주입 상태: " + (noticeService != null ? "성공" : "실패"));
            
            if (noticeService == null) {
                System.err.println("❌ NoticeService가 null입니다!");
                model.addAttribute("recentNotices", List.of());
                return "main";
            }
            
            // 전체 공지사항 개수 확인
            int totalCount = noticeService.getTotalNoticeCount();
            System.out.println("전체 공지사항 개수: " + totalCount);
            
            // 전체 공지사항 목록 확인
            List<NoticeDto> allNotices = noticeService.getAllNotices();
            System.out.println("전체 공지사항 목록 크기: " + allNotices.size());
            
            if (!allNotices.isEmpty()) {
                System.out.println("=== 전체 공지사항 목록 ===");
                for (NoticeDto notice : allNotices) {
                    System.out.println("- ID: " + notice.getId() + 
                                     ", 제목: " + notice.getTitle() + 
                                     ", 작성자: " + notice.getAuthor() +
                                     ", 작성일: " + notice.getCreatedDate());
                }
            }
            
            // 최신 공지사항 4개 가져오기
            List<NoticeDto> recentNotices = noticeService.getRecentNotices(4);
            System.out.println("최신 공지사항 개수: " + recentNotices.size());
            
            // Model에 데이터 추가 - 강제로 확인
            model.addAttribute("recentNotices", recentNotices);
            System.out.println("✅ Model에 recentNotices 추가 완료: " + recentNotices.size() + "개");
            
            logger.debug("메인페이지용 최신 공지사항 {}개 조회 완료", recentNotices.size());
            
            // 디버깅용 로그
            if (!recentNotices.isEmpty()) {
                System.out.println("=== 메인페이지용 최신 공지사항 ===");
                for (NoticeDto notice : recentNotices) {
                    System.out.println("- ID: " + notice.getId() + 
                                     ", 제목: " + notice.getTitle() + 
                                     ", 작성일: " + notice.getCreatedDate());
                    logger.debug("공지사항: ID={}, 제목={}, 작성일={}", 
                               notice.getId(), notice.getTitle(), notice.getCreatedDate());
                }
            } else {
                System.out.println("❌ 메인페이지용 공지사항이 비어있습니다!");
            }
            
        } catch (Exception e) {
            System.err.println("❌ 메인페이지 공지사항 조회 중 오류 발생!");
            e.printStackTrace();
            logger.error("메인페이지 공지사항 조회 중 오류: {}", e.getMessage());
            // 오류 발생 시 빈 목록 전달
            model.addAttribute("recentNotices", List.of());
        }

        System.out.println("=== MainController.handleMainPage() 완료 ===");
        // "main" 뷰 이름을 반환
        return "main";
    }
}