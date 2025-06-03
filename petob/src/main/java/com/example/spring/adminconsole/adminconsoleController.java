package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class adminconsoleController { 

    private static final Logger logger = LoggerFactory.getLogger(adminconsoleController.class); // 클래스명 일치 권장

    @Autowired
    private adminconsoleService adminConsoleService;

    @GetMapping("/console")
    public String showAdminConsole(
            @RequestParam(value = "section", required = false) String section,
            Model model,
            HttpSession session) {

        // 관리자 권한 체크: 세션에 저장된 userId가 'admin'인지 확인
        String userId = (String) session.getAttribute("userId"); // AuthController에서 "userId"로 저장한 값을 가져옴
        if (!"admin".equals(userId)) {
            logger.warn("Unauthorized access attempt to admin console by user with ID: {}", userId);
            return "redirect:/login";
        }

        logger.info("Admin console page request. User ID: {}, Section: {}", userId, section);

        // AdminConsoleDto를 사용하여 데이터를 한 번에 가져올 수도 있습니다.
        // AdminConsoleDto consoleData = adminConsoleService.getAdminConsoleData();
        // model.addAttribute("quickCounselingList", consoleData.getQuickCounselingList());
        // model.addAttribute("funeralReservationList", consoleData.getFuneralReservationList());

        // 또는 각 목록을 개별적으로 가져와서 모델에 추가
        List<ReservationDto> quickCounselingList = adminConsoleService.getAllQuickCounselingReservations();
        List<ObituaryReservationDto> funeralReservationList = adminConsoleService.getAllFuneralReservations();

        model.addAttribute("quickCounselingList", quickCounselingList);
        model.addAttribute("funeralReservationList", funeralReservationList);

        // section 파라미터가 없거나 'quick_counseling'일 때 기본으로 간편 상담을 보여줌
        if (section == null || section.isEmpty() || "quick_counseling".equals(section)) {
            model.addAttribute("currentSection", "quick_counseling");
        } else {
            model.addAttribute("currentSection", section);
        }
        
        return "adminconsole/adminconsole"; 
    }
}