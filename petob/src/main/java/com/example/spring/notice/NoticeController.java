package com.example.spring.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    
    @Autowired
    private NoticeService noticeService;
    
    /**
     * 공지사항 목록 페이지
     */
    @GetMapping("/list")
    public String noticeList(Model model, HttpSession session) {
        List<NoticeDto> notices = noticeService.getAllNotices();
        model.addAttribute("notices", notices);
        
        // 관리자 권한 확인
        String userId = (String) session.getAttribute("userId");
        String password = (String) session.getAttribute("password");
        boolean isAdmin = isAdminUser(userId, password);
        model.addAttribute("isAdmin", isAdmin);
        
        return "notice/list";
    }
    
    /**
     * 공지사항 상세 보기 페이지
     */
    @GetMapping("/detail/{id}")
    public String noticeDetail(@PathVariable Long id, Model model, HttpSession session) {
        NoticeDto notice = noticeService.getNoticeById(id);
        if (notice == null) {
            return "redirect:/notice/list?error=not_found";
        }
        
        model.addAttribute("notice", notice);
        
        // 관리자 권한 확인
        String userId = (String) session.getAttribute("userId");
        String password = (String) session.getAttribute("password");
        boolean isAdmin = isAdminUser(userId, password);
        model.addAttribute("isAdmin", isAdmin);
        
        return "notice/detail";
    }
    
    /**
     * 공지사항 작성 폼 페이지 (관리자 전용)
     */
    @GetMapping("/write")
    public String noticeWriteForm(HttpSession session, Model model) {
        if (!isAdminAuthenticated(session)) {
            return "redirect:/notice/list?error=unauthorized";
        }
        
        model.addAttribute("notice", new NoticeDto());
        return "notice/write";
    }
    
    /**
     * 공지사항 저장 (관리자 전용)
     */
    @PostMapping("/save")
    public String saveNotice(@ModelAttribute NoticeDto noticeDto, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        if (!isAdminAuthenticated(session)) {
            redirectAttributes.addFlashAttribute("error", "관리자만 접근 가능합니다.");
            return "redirect:/notice/list";
        }
        
        // 유효성 검증
        if (!noticeService.validateNotice(noticeDto)) {
            redirectAttributes.addFlashAttribute("error", "입력 정보를 확인해주세요.");
            return "redirect:/notice/write";
        }
        
        boolean result = noticeService.createNotice(noticeDto);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "공지사항이 성공적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "공지사항 등록에 실패했습니다.");
        }
        
        return "redirect:/notice/list";
    }
    
    /**
     * 공지사항 수정 폼 페이지 (관리자 전용)
     */
    @GetMapping("/edit/{id}")
    public String noticeEditForm(@PathVariable Long id, 
                                HttpSession session, 
                                Model model) {
        if (!isAdminAuthenticated(session)) {
            return "redirect:/notice/list?error=unauthorized";
        }
        
        NoticeDto notice = noticeService.getNoticeById(id);
        if (notice == null) {
            return "redirect:/notice/list?error=not_found";
        }
        
        model.addAttribute("notice", notice);
        return "notice/edit";
    }
    
    /**
     * 공지사항 수정 (관리자 전용)
     */
    @PostMapping("/update/{id}")
    public String updateNotice(@PathVariable Long id, 
                              @ModelAttribute NoticeDto noticeDto, 
                              HttpSession session, 
                              RedirectAttributes redirectAttributes) {
        if (!isAdminAuthenticated(session)) {
            redirectAttributes.addFlashAttribute("error", "관리자만 접근 가능합니다.");
            return "redirect:/notice/list";
        }
        
        // 유효성 검증
        if (!noticeService.validateNotice(noticeDto)) {
            redirectAttributes.addFlashAttribute("error", "입력 정보를 확인해주세요.");
            return "redirect:/notice/edit/" + id;
        }
        
        noticeDto.setId(id);
        boolean result = noticeService.updateNotice(noticeDto);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "공지사항이 성공적으로 수정되었습니다.");
            return "redirect:/notice/detail/" + id;
        } else {
            redirectAttributes.addFlashAttribute("error", "공지사항 수정에 실패했습니다.");
            return "redirect:/notice/edit/" + id;
        }
    }
    
    /**
     * 공지사항 삭제 (관리자 전용)
     */
    @PostMapping("/delete/{id}")
    public String deleteNotice(@PathVariable Long id, 
                              HttpSession session, 
                              RedirectAttributes redirectAttributes) {
        if (!isAdminAuthenticated(session)) {
            redirectAttributes.addFlashAttribute("error", "관리자만 접근 가능합니다.");
            return "redirect:/notice/list";
        }
        
        boolean result = noticeService.deleteNotice(id);
        if (result) {
            redirectAttributes.addFlashAttribute("success", "공지사항이 성공적으로 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "공지사항 삭제에 실패했습니다.");
        }
        
        return "redirect:/notice/list";
    }
    
    /**
     * 공지사항 검색
     */
    @GetMapping("/search")
    public String searchNotices(@RequestParam(required = false) String title, 
                               Model model, 
                               HttpSession session) {
        List<NoticeDto> notices;
        
        if (title != null && !title.trim().isEmpty()) {
            notices = noticeService.searchNoticesByTitle(title.trim());
            model.addAttribute("searchKeyword", title);
        } else {
            notices = noticeService.getAllNotices();
        }
        
        model.addAttribute("notices", notices);
        
        // 관리자 권한 확인
        String userId = (String) session.getAttribute("userId");
        String password = (String) session.getAttribute("password");
        boolean isAdmin = isAdminUser(userId, password);
        model.addAttribute("isAdmin", isAdmin);
        
        return "notice/list";
    }
    
    /**
     * 관리자 인증 확인
     */
    private boolean isAdminAuthenticated(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        String password = (String) session.getAttribute("password");
        return isAdminUser(userId, password);
    }
    
    /**
     * 관리자 사용자 확인
     */
    private boolean isAdminUser(String userId, String password) {
        return "admin12".equals(userId) && "admin1234".equals(password);
    }
}