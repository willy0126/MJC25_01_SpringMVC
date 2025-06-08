package com.example.spring.shortreview;

import java.util.Date;
import lombok.Data;

@Data
public class shortreviewDto {

    private Long id;
    private String userId;
    private String content;
    private Date createdAt;
    private Date updatedAt; // 최종 작성 일자를 위해 추가

    /**
     * JSP에서 'user**' 형식으로 마스킹된 아이디를 반환하는 헬퍼 메서드
     * 
     * @return 마스킹 처리된 사용자 ID
     */
    public String getMaskedUserId() {
        if (userId == null || userId.length() <= 2) {
            return userId;
        }
        return userId.substring(0, userId.length() - 2) + "**";
    }
}