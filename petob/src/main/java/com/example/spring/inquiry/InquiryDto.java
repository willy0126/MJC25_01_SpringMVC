package com.example.spring.inquiry;

import java.time.LocalDateTime;

/**
 * 문의 게시판 데이터 전송 객체 (DTO)
 */
public class InquiryDto {
    
    private Long inquiryId;          // 문의 고유번호
    private String userId;           // 작성자 ID
    private String username;         // 작성자 이름
    private String category;         // 문의 카테고리 (SERVICE, RESERVATION, PRICE, etc.)
    private String priority;         // 우선순위 (NORMAL, HIGH, URGENT)
    private String title;            // 문의 제목
    private String content;          // 문의 내용
    private String email;            // 답변받을 이메일
    private Boolean isSecret;        // 비밀글 여부
    private String status;           // 처리상태 (WAITING, PROCESSING, COMPLETED, CLOSED)
    private Integer viewCount;       // 조회수
    private String replyContent;     // 관리자 답변
    private String replyBy;          // 답변자 ID
    private LocalDateTime replyDate; // 답변일시
    private LocalDateTime createdDate; // 작성일시
    private LocalDateTime updatedDate; // 수정일시
    
    // 추가 필드 (화면 표시용)
    private Boolean isPrivate;       // 비밀글 여부 (isSecret과 동일)
    private String writerId;         // 작성자 ID (userId와 동일)
    private String writer;           // 작성자명 (username과 동일)
    private Boolean isHot;           // 인기글 여부
    private Integer replyCount;      // 댓글 수
    private Boolean isToday;         // 오늘 작성 여부
    private Boolean isThisYear;      // 올해 작성 여부
    
    // 기본 생성자
    public InquiryDto() {}
    
    // 전체 생성자
    public InquiryDto(Long inquiryId, String userId, String username, String category, 
                     String priority, String title, String content, String email, 
                     Boolean isSecret, String status, Integer viewCount, 
                     String replyContent, String replyBy, LocalDateTime replyDate,
                     LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.inquiryId = inquiryId;
        this.userId = userId;
        this.username = username;
        this.category = category;
        this.priority = priority;
        this.title = title;
        this.content = content;
        this.email = email;
        this.isSecret = isSecret;
        this.status = status;
        this.viewCount = viewCount != null ? viewCount : 0;
        this.replyContent = replyContent;
        this.replyBy = replyBy;
        this.replyDate = replyDate;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;

        this.isPrivate = isSecret;
        this.writerId = userId;
        this.writer = username;
    }

    // 추가: JSP에서 ${inquiry.id}로 접근할 수 있도록 alias getter
    public Long getId() {
        return this.inquiryId;
    }

    public Long getInquiryId() {
        return inquiryId;
    }

    public void setInquiryId(Long inquiryId) {
        this.inquiryId = inquiryId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
        this.writerId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
        this.writer = username;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getIsSecret() {
        return isSecret;
    }

    public void setIsSecret(Boolean isSecret) {
        this.isSecret = isSecret;
        this.isPrivate = isSecret;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getViewCount() {
        return viewCount != null ? viewCount : 0;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getReplyBy() {
        return replyBy;
    }

    public void setReplyBy(String replyBy) {
        this.replyBy = replyBy;
    }

    public LocalDateTime getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(LocalDateTime replyDate) {
        this.replyDate = replyDate;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;

        if (createdDate != null) {
            LocalDateTime now = LocalDateTime.now();
            this.isToday = createdDate.toLocalDate().equals(now.toLocalDate());
            this.isThisYear = createdDate.getYear() == now.getYear();
        }
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public Boolean getIsPrivate() {
        return isPrivate != null ? isPrivate : false;
    }

    public void setIsPrivate(Boolean isPrivate) {
        this.isPrivate = isPrivate;
        this.isSecret = isPrivate;
    }

    public String getWriterId() {
        return writerId != null ? writerId : userId;
    }

    public void setWriterId(String writerId) {
        this.writerId = writerId;
    }

    public String getWriter() {
        return writer != null ? writer : username;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Boolean getIsHot() {
        return viewCount != null && viewCount >= 50;
    }

    public void setIsHot(Boolean isHot) {
        this.isHot = isHot;
    }

    public Integer getReplyCount() {
        return replyCount != null ? replyCount : 0;
    }

    public void setReplyCount(Integer replyCount) {
        this.replyCount = replyCount;
    }

    public Boolean getIsToday() {
        return isToday != null ? isToday : false;
    }

    public void setIsToday(Boolean isToday) {
        this.isToday = isToday;
    }

    public Boolean getIsThisYear() {
        return isThisYear != null ? isThisYear : false;
    }

    public void setIsThisYear(Boolean isThisYear) {
        this.isThisYear = isThisYear;
    }

    public String getCategoryName() {
        if (category == null) return "";
        switch (category) {
            case "SERVICE": return "서비스";
            case "RESERVATION": return "예약";
            case "PRICE": return "가격";
            case "LOCATION": return "지점";
            case "COMPLAINT": return "불만";
            case "SUGGESTION": return "제안";
            case "ETC": return "기타";
            default: return category;
        }
    }

    public String getStatusName() {
        if (status == null) return "대기";
        switch (status) {
            case "WAITING": return "답변대기";
            case "PROCESSING": return "처리중";
            case "COMPLETED": return "답변완료";
            case "CLOSED": return "종료";
            default: return status;
        }
    }

    public String getPriorityName() {
        if (priority == null) return "일반";
        switch (priority) {
            case "NORMAL": return "일반";
            case "HIGH": return "높음";
            case "URGENT": return "긴급";
            default: return priority;
        }
    }

    @Override
    public String toString() {
        return "InquiryDto{" +
                "inquiryId=" + inquiryId +
                ", userId='" + userId + '\'' +
                ", username='" + username + '\'' +
                ", category='" + category + '\'' +
                ", priority='" + priority + '\'' +
                ", title='" + title + '\'' +
                ", isSecret=" + isSecret +
                ", status='" + status + '\'' +
                ", viewCount=" + viewCount +
                ", createdDate=" + createdDate +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        InquiryDto that = (InquiryDto) obj;
        return inquiryId != null ? inquiryId.equals(that.inquiryId) : that.inquiryId == null;
    }

    @Override
    public int hashCode() {
        return inquiryId != null ? inquiryId.hashCode() : 0;
    }
}
