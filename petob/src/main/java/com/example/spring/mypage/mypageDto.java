package com.example.spring.mypage;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class mypageDto {

    private int reservationId;
    private String branch;
    private String petName;
    private BigDecimal petWeight;
    private String applicantName;
    private String applicantPhone;
    private String obDate;
    private String obTime;
    private String notes;
    private String userId;
    private Timestamp createdAt;
    private String status; // 새로운 필드

    // 기본 생성자
    public mypageDto() {
    }

    // 모든 필드를 포함하는 생성자 (status 포함)
    public mypageDto(int reservationId, String branch, String petName, BigDecimal petWeight, String applicantName, String applicantPhone, String obDate, String obTime, String notes, String userId, Timestamp createdAt, String status) {
        this.reservationId = reservationId;
        this.branch = branch;
        this.petName = petName;
        this.petWeight = petWeight;
        this.applicantName = applicantName;
        this.applicantPhone = applicantPhone;
        this.obDate = obDate;
        this.obTime = obTime;
        this.notes = notes;
        this.userId = userId;
        this.createdAt = createdAt;
        this.status = status; // status 초기화
    }

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

    public BigDecimal getPetWeight() {
        return petWeight;
    }

    public void setPetWeight(BigDecimal petWeight) {
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() { // status 필드 Getter
        return status;
    }

    public void setStatus(String status) { // status 필드 Setter
        this.status = status;
    }

    @Override
    public String toString() {
        return "mypageDto{" +
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
                ", status='" + status + '\'' + // toString에 status 포함
                '}';
    }
}