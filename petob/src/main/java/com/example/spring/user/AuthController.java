package com.example.spring.user; 

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder; // 비밀번호 암호화 도구 (BCrypt 등)

    // SLF4J Logger 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
    
    // 절차 및 비용 페이지
    @GetMapping("/login")
    public String showLoginPage() {
        logger.debug("AuthController: 로그인 페이지 요청이 처리되었습니다.");
        
        return "auth/login"; 
    }

       @GetMapping("/register")
    public String register(HttpServletRequest request) {
        // 회원가입 화면으로 이동
        return "auth/register";
    }
    
    @PostMapping("/register")
    public String registerPost(UserDto user, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 회원 가입 처리 (비밀번호 암호화 포함)
        boolean result = userService.create(user);

        if (result) {
            // 가입 성공 시 성공 메시지와 함께 로그인 페이지로 이동
            redirectAttributes.addFlashAttribute("successMessage", "회원 가입이 완료되었습니다.");
            return "redirect:/login";
        }

        // 가입 실패 시 에러 메시지와 함께 회원가입 폼으로 리다이렉트
        redirectAttributes.addFlashAttribute("errorMessage", "회원 가입에 실패했습니다.");
        return "redirect:/register";
    }

      
    @GetMapping("/find-user-id")
    public String findUserIdGet(HttpServletRequest request) {
        // 아이디 찾기 화면으로 이동
        return "auth/findUserId";
    }

    
    @PostMapping("/find-user-id")
    public String findUserIdPost(UserDto user, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 입력된 정보를 기반으로 사용자 조회
        UserDto existsUser = userService.read(user);

        if (existsUser != null) {
            // 사용자 존재: 아이디를 성공 메시지로 전달
            redirectAttributes.addFlashAttribute("successMessage", "사용자 아이디는 " + existsUser.getUserId() + " 입니다.");
        } else {
            // 사용자 없음: 실패 메시지 전달
            redirectAttributes.addFlashAttribute("errorMessage", "사용자를 찾을 수 없습니다.");
        }

        // 결과 메시지를 전달하고 다시 아이디 찾기 화면으로 리다이렉트
        return "redirect:/find-user-id";
    }

    @GetMapping("/reset-password")
    public String resetPasswordGet(HttpServletRequest request) {
        // 비밀번호 초기화 화면 제공
        return "auth/resetPassword";
    }

     
    @PostMapping("/reset-password")
    public String resetPasswordPost(UserDto user, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 세션에 userId가 존재하면 로그인 상태로 판단
        if (request.getSession().getAttribute("userId") != null) {
            // 이미 로그인된 사용자는 메인 페이지로 이동
            return "redirect:/";
        }

        // 사용자 정보 조회
        UserDto existsUser = userService.read(user);

        if (existsUser != null) {
            // 6자리 임시 비밀번호 생성
            int iValue = (int)(Math.random() * 1000000);
            String newPassword = String.format("%06d", iValue); // 앞자리 0 포함되도록

            // 비밀번호 초기화 및 업데이트
            existsUser.setPassword(newPassword);
            boolean result = userService.update(existsUser);

            if (result) {
                redirectAttributes.addFlashAttribute("successMessage", "임시 비밀번호는 " + newPassword + " 입니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "비밀번호 초기화에 실패했습니다.");
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "사용자를 찾을 수 없습니다.");
        }

        return "redirect:/reset-password";
    }

      
    @PostMapping("/login")
    public String login(UserDto user, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // 사용자 정보 조회 (userId 기준)
        UserDto existsUser = userService.read(user);

        // 사용자 존재 여부 및 비밀번호 검증
        if (existsUser != null && passwordEncoder.matches(user.getPassword(), existsUser.getPassword())) {
            // 세션에 로그인 정보 저장
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", existsUser.getUserId());
            session.setAttribute("username", existsUser.getUsername());
            session.setAttribute("role", existsUser.getRole());

            return "redirect:/"; // /profile 로 이동
        }

        // 로그인 실패: 에러 메시지와 함께 로그인 페이지로 리다이렉트
        redirectAttributes.addFlashAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
        return "redirect:/login";
    }
 
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        // 현재 세션이 존재하면 삭제 (false 옵션: 세션이 없으면 null 반환)
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate(); // 세션 무효화
        }

        return "redirect:/";
    }

    @PostMapping("/check-user-id")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkUserIdPost(UserDto user) {
        // 입력된 아이디 기준으로 사용자 조회
        UserDto existsUser = userService.read(user);

        // 응답용 데이터 생성
        Map<String, Object> response = new HashMap<>();
        response.put("exists", existsUser != null);

        // JSON 형식으로 결과 반환
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(response);
    }


    @PostMapping("/check-phone")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkPhonePost(UserDto user) {
        // 입력된 전화번호 기준으로 사용자 조회
        UserDto existsUser = userService.read(user);

        // 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("exists", existsUser != null);

        // JSON 형식으로 응답 반환
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(response);
    }
      
    @PostMapping("/check-email")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkEmailPost(UserDto user) {
        // 입력된 이메일 기준으로 사용자 정보 조회
        UserDto existsUser = userService.read(user);

        // 응답 데이터 생성
        Map<String, Object> response = new HashMap<>();
        response.put("exists", existsUser != null);

        // JSON 응답 반환
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(response);
    }
}
