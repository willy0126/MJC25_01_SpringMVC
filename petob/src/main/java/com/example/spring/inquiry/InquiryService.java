package com.example.spring.inquiry;

import java.util.List;
import java.util.Map;

/**
 * 문의 게시판 서비스 인터페이스
 */
public interface InquiryService {
    
    /**
     * 문의 목록 조회 (페이징, 검색, 필터링)
     * @param page 페이지 번호
     * @param size 페이지 크기
     * @param search 검색어
     * @param category 카테고리 필터
     * @param status 상태 필터
     * @return 조회 결과 (목록, 페이징 정보 포함)
     */
    Map<String, Object> list(int page, int size, String search, String category, String status);
    
    /**
     * 사용자별 문의 목록 조회
     * @param userId 사용자 ID
     * @param page 페이지 번호
     * @param size 페이지 크기
     * @return 조회 결과
     */
    Map<String, Object> listByUser(String userId, int page, int size);
    
    /**
     * 문의 상세 조회
     * @param inquiryId 문의 ID
     * @return 문의 정보
     */
    InquiryDto read(Long inquiryId);
    
    /**
     * 문의 생성
     * @param inquiry 문의 정보
     * @return 성공 여부
     */
    boolean create(InquiryDto inquiry);
    
    /**
     * 문의 수정
     * @param inquiry 수정할 문의 정보
     * @param userId 수정하는 사용자 ID
     * @return 성공 여부
     */
    boolean update(InquiryDto inquiry, String userId);
    
    /**
     * 문의 삭제
     * @param inquiryId 삭제할 문의 ID
     * @param userId 삭제하는 사용자 ID
     * @param isAdmin 관리자 여부
     * @return 성공 여부
     */
    boolean delete(Long inquiryId, String userId, boolean isAdmin);
    
    /**
     * 관리자 답변 등록
     * @param inquiryId 문의 ID
     * @param reply 답변 내용
     * @param replyBy 답변자 ID
     * @return 성공 여부
     */
    boolean reply(Long inquiryId, String reply, String replyBy);
    
    /**
     * 문의 상태 변경
     * @param inquiryId 문의 ID
     * @param status 변경할 상태
     * @return 성공 여부
     */
    boolean updateStatus(Long inquiryId, String status);
    
    /**
     * 조회수 증가
     * @param inquiryId 문의 ID
     * @return 성공 여부
     */

    List<InquiryDto> getNoticeList();
    
    /**
     * 전체 문의 개수 조회
     * @param category 카테고리 필터
     * @param search 검색어
     * @param status 상태 필터
     * @return 전체 개수
     */
    int getTotalCount(String category, String search, String status);
}