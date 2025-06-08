package com.example.spring.reservation;

import java.util.Date;
import lombok.Data;

/**
 * 간단한 상담 예약 정보를 담는 DTO
 */
@Data
public class ReservationDto {
    private Long reservationId; // 예약 ID (자동 증가)
    private String username; // 예약자 이름
    private String phone; // 전화번호
    private String email; // 이메일
    private String date; // 예약 날짜 (YYYY-MM-DD)
    private String time; // 예약 시간 (HH:MM)
    private Date createdAt; // 등록 일시

    // Lombok 에러 대비 getter/setter
    public Long getReservationId() {
        return reservationId;
    }

    public void setReservationId(Long reservationId) {
        this.reservationId = reservationId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}