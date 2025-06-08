package com.example.spring.user;

import java.util.Date;

import lombok.Data;

/**
 * 사용자 정보를 담는 Data Transfer Object (DTO)
 * - 회원가입, 로그인, 사용자 조회 등에서 사용됨
 */
@Data
public class UserDto {
    private String userId; // 사용자 ID (로그인용 아이디, PK로 사용)
    private String password; // 비밀번호 (암호화된 값 저장)
    private String username; // 사용자 이름
    private String phone; // 전화번호
    private String email; // 이메일 주소
    private String role; // 사용자 구분(USER, ADMIN)
    private Date createdAt; // 가입 일시 (포맷 예: yyyy-MM-dd HH:mm:ss)
    private Date updatedAt;

    // lombok 에러 대비 getter setter 만들어둠
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
