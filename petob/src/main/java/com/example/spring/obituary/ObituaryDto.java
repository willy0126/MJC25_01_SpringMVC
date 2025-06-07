package com.example.spring.obituary;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ObituaryDto {

    private int id;
    private String petName;

    @DateTimeFormat(pattern = "yyyy-MM-dd") // ✅ 날짜 바인딩 처리
    private Date passedDate;

    private String message;
    private String photoPath;
    private Date createdAt;

    // getter/setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPetName() { return petName; }
    public void setPetName(String petName) { this.petName = petName; }

    public Date getPassedDate() { return passedDate; }
    public void setPassedDate(Date passedDate) { this.passedDate = passedDate; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getPhotoPath() { return photoPath; }
    public void setPhotoPath(String photoPath) { this.photoPath = photoPath; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
