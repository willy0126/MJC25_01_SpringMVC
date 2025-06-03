package com.example.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 추가

import org.slf4j.Logger; // Logger 추가
import org.slf4j.LoggerFactory; // LoggerFactory 추가
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class); // 로거 추가

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        String requestUri = request.getRequestURI();
        HttpSession session = request.getSession(false); // 세션이 없으면 null 반환
        String userId = null;

        if (session != null) {
            userId = (String) session.getAttribute("userId");
        }

        logger.debug("AuthInterceptor URI: {}, UserId: {}", requestUri, userId); // 요청 URI 및 UserId 로깅

        // 예: /funeral-reviews 경로 및 하위 경로에 대한 처리
        if (requestUri.startsWith(request.getContextPath() + "/funeral-reviews")) {
            // 글 목록보기(/funeral-reviews)는 누구나 가능하도록 허용 (필요에 따라 변경)
            if (requestUri.equals(request.getContextPath() + "/funeral-reviews")
                    && request.getMethod().equalsIgnoreCase("GET")) {
                return true;
            }
            // 글 상세보기(/funeral-reviews/{id})는 누구나 가능하도록 허용 (필요에 따라 변경)
            // 정규 표현식을 사용하여 /funeral-reviews/숫자 형태의 경로를 체크
            if (requestUri.matches(request.getContextPath() + "/funeral-reviews/\\d+$")
                    && request.getMethod().equalsIgnoreCase("GET")) {
                return true;
            }
            // 파일 다운로드(/funeral-reviews/{id}/download)는 누구나 가능하도록 허용 (필요에 따라 변경)
            if (requestUri.matches(request.getContextPath() + "/funeral-reviews/\\d+/download$")
                    && request.getMethod().equalsIgnoreCase("GET")) {
                return true;
            }

            // 그 외 /funeral-reviews/** 경로는 로그인 필요
            // (예: /create, /{id}/update, /{id}/delete 등 POST 요청 포함)
            if (userId == null) {
                logger.info("로그인되지 않은 사용자의 접근 시도: {}", requestUri);
                response.sendRedirect(request.getContextPath() + "/login");
                return false;
            }
            return true; // 로그인된 사용자는 접근 가능
        }

        // 다른 경로에 대한 규칙 (기존 로직 유지 또는 수정)
        // 예: /auth/logout 요청은 로그인된 사용자만
        if (requestUri.equals(request.getContextPath() + "/logout")) { // /auth/logout 에서 /logout 으로 변경 (AuthController
                                                                       // 확인 필요)
            if (userId == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return false;
            }
        }

        // 로그인/회원가입/ID찾기/PW재설정 페이지는 로그인하지 않은 사용자만 접근 허용
        if (requestUri.startsWith(request.getContextPath() + "/login") ||
                requestUri.startsWith(request.getContextPath() + "/register") ||
                requestUri.startsWith(request.getContextPath() + "/find-user-id") ||
                requestUri.startsWith(request.getContextPath() + "/reset-password")) {
            if (userId != null) { // 이미 로그인된 경우
                response.sendRedirect(request.getContextPath() + "/"); // 메인 페이지로 이동
                return false;
            }
        }

        // 마이페이지 접근은 로그인된 사용자만 가능
        if (requestUri.startsWith(request.getContextPath() + "/mypage")) {
            if (userId == null) {
                logger.info("로그인되지 않은 사용자의 마이페이지 접근 시도: {}", requestUri);
                // 로그인 후 돌아올 URL을 파라미터로 전달할 수 있습니다.
                response.sendRedirect(request.getContextPath() + "/login?returnUrl=" + request.getRequestURI());
                return false;
            }
        }

        // 그 외 모든 요청은 일단 허용 (필요에 따라 이 부분을 더 강화하거나 수정)
        return true;
    }
}