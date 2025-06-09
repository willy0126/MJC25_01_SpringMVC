package com.example.spring.shortreview;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class shortreviewService {

    @Autowired
    private shortreviewDao shortReviewDao;

    /**
     * 모든 한 마디 리뷰 목록을 가져옵니다.
     * 
     * @return 리뷰 목록
     */
    public List<shortreviewDto> getAllReviews() {
        return shortReviewDao.selectAll();
    }

    /**
     * 새로운 한 마디 리뷰를 생성합니다.
     * 
     * @param dto 생성할 리뷰 정보
     * @return 성공 여부
     */
    @Transactional
    public boolean createReview(shortreviewDto dto) {
        if (dto.getUserId() == null || dto.getContent() == null || dto.getContent().trim().isEmpty()) {
            return false; // 필수 정보 누락
        }
        return shortReviewDao.create(dto) > 0;
    }

    /**
     * 한 마디 리뷰를 삭제합니다. 작성자 본인 또는 관리자만 삭제 가능합니다.
     * 
     * @param reviewId        삭제할 리뷰 ID
     * @param currentUserId   현재 로그인한 사용자 ID
     * @param currentUserRole 현재 로그인한 사용자의 역할
     * @return 성공 여부
     */
    @Transactional
    public boolean deleteReview(Long reviewId, String currentUserId, String currentUserRole) {
        shortreviewDto review = shortReviewDao.selectById(reviewId);

        if (review == null) {
            return false; // 삭제할 리뷰가 없음
        }

        // 관리자이거나, 리뷰 작성자인 경우에만 삭제 허용
        boolean isAdmin = "ADMIN".equals(currentUserRole);
        boolean isOwner = review.getUserId().equals(currentUserId);

        if (isAdmin || isOwner) {
            return shortReviewDao.delete(reviewId) > 0;
        }

        return false; // 권한 없음
    }
}