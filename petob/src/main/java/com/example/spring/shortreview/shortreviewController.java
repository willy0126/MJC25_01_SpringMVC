package com.example.spring.shortreview;

import java.util.List; // List import 추가
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // Model import 추가
import org.springframework.web.bind.annotation.GetMapping; // GetMapping import 추가
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/short-reviews")
public class shortreviewController {

    @Autowired
    private shortreviewService shortReviewService;

    /**
     * 한 마디 남기기 목록 페이지를 보여줍니다.
     * 
     * @param model 뷰에 데이터를 전달할 모델 객체
     * @return 뷰의 논리적 이름
     */
    @GetMapping("") // "/short-reviews" 경로의 GET 요청을 처리
    public String showReviewPage(Model model) {
        // 1. 서비스에서 모든 리뷰 목록을 가져옵니다.
        List<shortreviewDto> reviews = shortReviewService.getAllReviews();

        // 2. 모델에 리뷰 목록을 담아 JSP로 전달합니다.
        model.addAttribute("shortReviews", reviews);

        // 3. 뷰 파일을 렌더링합니다.
        // InternalResourceViewResolver 설정에 따라
        // /WEB-INF/views/pages/shortreview/shortreview.jsp를 찾게 됩니다.
        return "shortreview/shortreview";
    }

    /**
     * 한 마디 리뷰 작성 요청을 처리합니다.
     * 
     * @param dto                폼에서 전송된 리뷰 데이터
     * @param session            현재 세션
     * @param redirectAttributes 리다이렉트 시 메시지 전달용
     * @return 리뷰 목록이 있는 페이지로 리다이렉트
     */
    @PostMapping("/create")
    public String create(shortreviewDto dto, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        dto.setUserId(userId);
        boolean success = shortReviewService.createReview(dto);

        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "소중한 한 마디가 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "등록에 실패했습니다. 내용을 확인해주세요.");
        }

        // 작업 완료 후, 다시 목록 페이지로 리다이렉트
        return "redirect:/short-reviews";
    }

    /**
     * 한 마디 리뷰 삭제 요청을 처리합니다.
     * 
     * @param id                 삭제할 리뷰의 ID
     * @param session            현재 세션
     * @param redirectAttributes 리다이렉트 시 메시지 전달용
     * @return 이전 페이지로 리다이렉트
     */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = (String) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");

        if (userId == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        boolean success = shortReviewService.deleteReview(id, userId, userRole);

        if (success) {
            redirectAttributes.addFlashAttribute("successMessage", "리뷰가 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "리뷰를 삭제할 수 없습니다.");
        }

        return "redirect:/short-reviews";
    }
}