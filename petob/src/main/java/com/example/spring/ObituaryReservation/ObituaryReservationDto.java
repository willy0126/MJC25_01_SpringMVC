package com.example.spring.ObituaryReservation;

import java.util.Date;

public class ObituaryReservationDto {
    private int reservationId;
    private String branch;
    private String petName;
    private Double petWeight;
    private String applicantName;
    private String applicantPhone;
    private String obDate;
    private String obTime;
    private String notes;
    private String userId;
    private Date createdAt;
    private String status; // 새로운 필드

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

    public String getStatus() { // status 필드 Getter
        return status;
    }

    public void setStatus(String status) { // status 필드 Setter
        this.status = status;
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
                ", status='" + status + '\'' + // toString에 status 포함
                '}';
    }
}