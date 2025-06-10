package com.example.spring.inquiry;

import java.util.List;
import java.util.Map;

/**
 * 문의 게시판 서비스 인터페이스
 */
public interface InquiryService {

    /**
     * 문의 목록 조회 (페이징, 검색, 필터링)
     */
    Map<String, Object> list(int page, int size, String search, String category, String status);

    /**
     * 사용자별 문의 목록 조회
     */
    Map<String, Object> listByUser(String userId, int page, int size);

    /**
     * 문의 상세 조회
     */
    InquiryDto read(Long inquiryId);

    /**
     * 문의 생성
     */
    boolean create(InquiryDto inquiry);

    /**
     * 문의 수정
     */
    boolean update(InquiryDto inquiry, String userId);

    /**
     * 문의 삭제 (일반 사용자용)
     */
    boolean delete(Long inquiryId, String userId);

    /**
     * 문의 삭제 (관리자 권한 포함)
     */
    boolean delete(Long inquiryId, String userId, boolean isAdmin);

    /**
     * 관리자 답변 등록
     */
    boolean reply(Long inquiryId, String reply, String replyBy);

    /**
     * 문의 상태 변경
     */
    boolean updateStatus(Long inquiryId, String status);

    /**
     * 공지사항 목록 조회
     */
    List<InquiryDto> getNoticeList();

    /**
     * 전체 문의 개수 조회
     */
    int getTotalCount(String category, String search, String status);
}