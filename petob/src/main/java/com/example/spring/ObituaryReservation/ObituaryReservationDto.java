package com.example.spring.ObituaryReservation;

import java.util.Date;
// import org.springframework.format.annotation.DateTimeFormat; // 날짜/시간을 String으로 받으므로 불필요

public class ObituaryReservationDto {
    private int reservationId;
    private String branch;
    private String petName;
    private Double petWeight; // Double 또는 BigDecimal로 변경
    private String applicantName; // 보호자(신청자) 성함
    private String applicantPhone; // 신청자 전화번호
    private String obDate;
    private String obTime;
    private String notes; // 기타 요청사항
    private String userId; // 로그인 사용자 ID
    private Date createdAt;

    // Getters and Setters
    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public Double getPetWeight() {
        return petWeight;
    }

    public void setPetWeight(Double petWeight) {
        this.petWeight = petWeight;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getApplicantPhone() {
        return applicantPhone;
    }

    public void setApplicantPhone(String applicantPhone) {
        this.applicantPhone = applicantPhone;
    }

    public String getObDate() {
        return obDate;
    }

    public void setObDate(String obDate) {
        this.obDate = obDate;
    }

    public String getObTime() {
        return obTime;
    }

    public void setObTime(String obTime) {
        this.obTime = obTime;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ObituaryReservationDto{" +
                "reservationId=" + reservationId +
                ", branch='" + branch + '\'' +
                ", petName='" + petName + '\'' +
                ", petWeight=" + petWeight +
                ", applicantName='" + applicantName + '\'' +
                ", applicantPhone='" + applicantPhone + '\'' +
                ", obDate='" + obDate + '\'' +
                ", obTime='" + obTime + '\'' +
                ", notes='" + notes + '\'' +
                ", userId='" + userId + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}