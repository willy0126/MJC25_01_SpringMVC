package com.example.spring.ObituaryReservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// UserService 및 UserDto import 추가
import com.example.spring.user.UserDto;
import com.example.spring.user.UserService;

@Controller
@RequestMapping("/obituary-reservation")
public class ObituaryReservationController {

    private static final Logger logger = LoggerFactory.getLogger(ObituaryReservationController.class);

    @Autowired
    private ObituaryReservationService obituaryReservationService;

    @Autowired // UserService 주입
    private UserService userService;

    @GetMapping("/form")
    public String showObituaryReservationForm(
            @RequestParam(required = false) String branch,
            Model model,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        logger.debug("장례 예약 폼 페이지 요청입니다. 요청된 지점: {}", branch);

        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            // UTF-8 인코딩 추가
            String returnUrl = "/obituary-reservation/form" + (branch != null ? "?branch=" + java.net.URLEncoder.encode(branch, java.nio.charset.StandardCharsets.UTF_8) : "");
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요한 서비스입니다.");
            return "redirect:/login?returnUrl=" + returnUrl;
        }

        // 로그인한 사용자 정보 조회
        UserDto userToSearch = new UserDto();
        userToSearch.setUserId(userId);
        UserDto loginUser = userService.read(userToSearch); //

        if (loginUser != null) {
            model.addAttribute("loginUserName", loginUser.getUsername());
            // 모델에 전화번호 추가
            model.addAttribute("loginUserPhone", loginUser.getPhone()); //
            logger.debug("로그인 사용자 정보: 이름={}, 전화번호={}", loginUser.getUsername(), loginUser.getPhone());
        } else {
            logger.warn("세션에 userId는 있으나 DB에서 사용자 정보를 찾을 수 없음: {}", userId);
            model.addAttribute("loginUserName", "");
            model.addAttribute("loginUserPhone", ""); // 전화번호도 빈 값으로 설정
        }

        if (branch != null && !branch.isEmpty()) {
            model.addAttribute("selectedBranch", branch);
        } else {
            model.addAttribute("selectedBranch", "");
        }

        return "obituaryreservation/obituaryreservation";
    }

    @PostMapping("/create")
    public String createObituaryReservation(
            ObituaryReservationDto reservationDto,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다. 다시 로그인 후 시도해주세요.");
            String branchParam = reservationDto.getBranch();
            String returnUrl = "/obituary-reservation/form" + (branchParam != null && !branchParam.isEmpty() ? "?branch=" + java.net.URLEncoder.encode(branchParam, java.nio.charset.StandardCharsets.UTF_8) : "");
            return "redirect:/login?returnUrl=" + returnUrl;
        }

        String userId = (String) session.getAttribute("userId");
        reservationDto.setUserId(userId);

        logger.info("장례 예약 신청 정보 수신: {}", reservationDto.toString());

        try {
            boolean success = obituaryReservationService.createReservation(reservationDto); //
            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "장례 예약이 성공적으로 신청되었습니다. 곧 연락드리겠습니다.");
                return "redirect:/";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "장례 예약 신청에 실패했습니다. 입력 정보를 확인 후 다시 시도해주세요. (예: 이미 예약된 시간)");
                return "redirect:/obituary-reservation/form?branch=" + java.net.URLEncoder.encode(reservationDto.getBranch(), java.nio.charset.StandardCharsets.UTF_8);
            }
        } catch (Exception e) {
            logger.error("장례 예약 처리 중 심각한 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", "예약 처리 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주시고, 문제가 지속되면 관리자에게 문의해주세요.");
            return "redirect:/obituary-reservation/form?branch=" + java.net.URLEncoder.encode(reservationDto.getBranch(), java.nio.charset.StandardCharsets.UTF_8);
        }
    }

    @PostMapping("/check-booked-times")
@ResponseBody
public ResponseEntity<Map<String, Object>> checkBookedTimes(
        @RequestParam("date") String date,
        @RequestParam("branch") String branch) { // 지점 파라미터 추가
    Map<String, Object> response = new HashMap<>();
    try {
        // 서비스 호출 시 지점 정보 전달
        List<String> bookedTimes = obituaryReservationService.getBookedTimesByDateAndBranch(date, branch);
        response.put("bookedTimes", bookedTimes);
        response.put("success", true);
        logger.debug("날짜 [{}] 및 지점 [{}]의 예약된 시간 조회: {}", date, branch, bookedTimes);
        return ResponseEntity.ok(response);
    } catch (Exception e) {
        logger.error("예약된 시간 조회 중 오류 발생 (날짜: {}, 지점: {}): {}", date, branch, e.getMessage(), e);
        response.put("success", false);
        response.put("message", "예약된 시간을 가져오는 중 오류가 발생했습니다.");
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
    }
}
}