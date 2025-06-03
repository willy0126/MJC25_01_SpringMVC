package com.example.spring.notice;

import java.time.LocalDateTime;

public class NoticeDto {
    private Long id;
    private String title;
    private String content;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    
    // 기본 생성자
    public NoticeDto() {}
    
    // 전체 생성자
    public NoticeDto(Long id, String title, String content, LocalDateTime createdDate, LocalDateTime updatedDate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
    }
    
    // 제목, 내용만 있는 생성자 (새로 작성할 때)
    public NoticeDto(String title, String content) {
        this.title = title;
        this.content = content;
        this.createdDate = LocalDateTime.now();
        this.updatedDate = LocalDateTime.now();
    }
    
    // Getter 메소드들
    public Long getId() {
        return id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public String getContent() {
        return content;
    }
    
    public LocalDateTime getCreatedDate() {
        return createdDate;
    }
    
    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }
    
    // Setter 메소드들
    public void setId(Long id) {
        this.id = id;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    // toString 메소드
    @Override
    public String toString() {
        return "NoticeDto{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                '}';
    }
}