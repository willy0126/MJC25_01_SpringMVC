package com.example.spring.mypage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
// com.example.spring.user.UserDto는 세션에서 userId만 가져오므로 직접적인 import는 불필요할 수 있음

@Controller
@RequestMapping(value = "/mypage")
public class mypageController {

    private static final Logger logger = LoggerFactory.getLogger(mypageController.class);
    private final mypageService mypageService;

    @Autowired
    public mypageController(mypageService mypageService) {
        this.mypageService = mypageService;
    }

    @GetMapping // "/mypage" 경로의 GET 요청 처리
    public String userMyPage(HttpSession session, Model model) {
        logger.debug("마이페이지 요청 처리 시작");

        // 1. 세션에서 현재 로그인한 사용자 ID 가져오기
        String currentUserId = (String) session.getAttribute("userId"); // AuthController에서 "userId"로 저장한 값을 가져옴

        if (currentUserId == null || currentUserId.isEmpty()) {
            logger.warn("세션에 사용자 ID가 없거나 비어있습니다. 로그인 페이지로 리다이렉트합니다.");
        }
        // AuthInterceptor에서 이미 로그인 여부를 체크하고, 로그인 안된 사용자는 /login으로 보냈을 것이므로,
        // 이 컨트롤러에 도달했다면 currentUserId는 null이 아닐 것으로 예상됩니다.
        // 만약 null이라면 인터셉터 설정을 다시 확인해야 합니다.
        if (currentUserId == null) {
             logger.error("mypageController: 세션에서 userId를 찾을 수 없습니다. AuthInterceptor 설정을 확인하세요.");
             model.addAttribute("errorMessage", "사용자 정보를 가져올 수 없습니다. 다시 로그인해주세요.");
             return "mypage/mypage"; // 또는 에러 페이지
        }


        logger.info("로그인된 사용자 ID '{}'의 장례 예약 내역 조회 시도", currentUserId);

        // 2. 서비스 호출하여 해당 사용자의 장례 예약 목록 가져오기
        List<mypageDto> funeralReservationList = mypageService.getMyFuneralReservations(currentUserId);

        // 3. 모델에 장례 예약 목록 추가
        model.addAttribute("funeralReservationList", funeralReservationList);
        model.addAttribute("loggedInUserId", currentUserId); // JSP에서 확인용으로 사용자 ID 전달 (선택사항)

        if (funeralReservationList.isEmpty()) {
            logger.info("사용자 ID '{}'의 장례 예약 내역이 없습니다.", currentUserId);
            model.addAttribute("funeralMessage", "현재까지 신청하신 장례 예약 내역이 없습니다."); // 화면 메시지와 일치시킴
        } else {
            logger.info("사용자 ID '{}'의 장례 예약 {}건 조회 완료", currentUserId, funeralReservationList.size());
        }

        // 4. 뷰 이름 반환
        return "mypage/mypage"; // -> /WEB-INF/views/pages/mypage/mypage.jsp
    }
}