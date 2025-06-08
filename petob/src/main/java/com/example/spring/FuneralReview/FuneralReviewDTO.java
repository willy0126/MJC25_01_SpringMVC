package com.example.spring.FuneralReview;

import java.util.Date;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.format.annotation.DateTimeFormat; // DateTimeFormat 임포트 추가

public class FuneralReviewDTO {
    private int id; // 리뷰 ID (Primary Key)
    private String reviewTitle; // 리뷰 제목
    private String reviewContent; // 리뷰 내용
    private String userId; // 작성자 ID

    @DateTimeFormat(pattern = "yyyy-MM-dd") // 어노테이션 추가
    private Date funeralDate; // 장례 날짜

    private String location; // 장소

    private Date createdAt; // 작성일
    private Date updatedAt; // 수정일

    // 첨부파일 관련 필드
    private MultipartFile uploadFile; // 업로드된 파일
    private String fileName; // 서버에 저장된 파일 이름
    private String originalFileName; // 사용자가 업로드한 원본 파일명
    private boolean deleteFile; // 기존 파일 삭제 여부

    // 사용자 추가 정보 (옵션)
    private String username; // 사용자 이름
    private String phone; // 전화번호
    private String email; // 이메일
    private String role; // 역할 (USER, ADMIN)

    // --- lombok 안먹힐때 대비해서 만들어둠 ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getReviewTitle() {
        return reviewTitle;
    }

    public void setReviewTitle(String reviewTitle) {
        this.reviewTitle = reviewTitle;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getFuneralDate() {
        return funeralDate;
    }

    public void setFuneralDate(Date funeralDate) {
        this.funeralDate = funeralDate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public MultipartFile getUploadFile() {
        return uploadFile;
    }

    public void setUploadFile(MultipartFile uploadFile) {
        this.uploadFile = uploadFile;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public boolean isDeleteFile() {
        return deleteFile;
    }

    public void setDeleteFile(boolean deleteFile) {
        this.deleteFile = deleteFile;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}