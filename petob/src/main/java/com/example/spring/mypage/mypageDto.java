package com.example.spring.mypage;

import java.math.BigDecimal; // pet_weight가 DECIMAL 타입이므로 BigDecimal 사용 권장
import java.sql.Timestamp;

public class mypageDto {

    private int reservationId;      // reservation_id
    private String branch;          // branch
    private String petName;         // pet_name
    private BigDecimal petWeight;   // pet_weight (DECIMAL(5,1) -> BigDecimal)
    private String applicantName;   // applicant_name
    private String applicantPhone;  // applicant_phone
    private String obDate;          // ob_date (YYYY-MM-DD 문자열)
    private String obTime;          // ob_time (HH:MM 문자열)
    private String notes;           // notes (기타 요청사항)
    private String userId;          // user_id = 로그인 사용자 ID
    private Timestamp createdAt;    // created_at

    // 기본 생성자
    public mypageDto() {
    }

    // 모든 필드를 포함하는 생성자 (필요에 따라 추가)
    public mypageDto(int reservationId, String branch, String petName, BigDecimal petWeight, String applicantName, String applicantPhone, String obDate, String obTime, String notes, String userId, Timestamp createdAt) {
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
                '}';
    }
}