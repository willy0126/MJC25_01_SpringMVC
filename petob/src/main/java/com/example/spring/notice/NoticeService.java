package com.example.spring.notice;

import java.util.List;

public interface NoticeService {

    /**
     * 모든 공지사항을 조회합니다.
     * 
     * @return 공지사항 리스트
     */
    List<NoticeDto> getAllNotices();

    /**
     * ID로 특정 공지사항을 조회합니다.
     * 
     * @param id 공지사항 ID
     * @return 공지사항 정보
     */
    NoticeDto getNoticeById(Long id);

    /**
     * 새로운 공지사항을 등록합니다.
     * 
     * @param noticeDto 등록할 공지사항 정보
     * @return 등록 성공 여부
     */
    boolean createNotice(NoticeDto noticeDto);

    /**
     * 공지사항을 수정합니다.
     * 
     * @param noticeDto 수정할 공지사항 정보
     * @return 수정 성공 여부
     */
    boolean updateNotice(NoticeDto noticeDto);

    /**
     * 공지사항을 삭제합니다.
     * 
     * @param id 삭제할 공지사항 ID
     * @return 삭제 성공 여부
     */
    boolean deleteNotice(Long id);

    /**
     * 전체 공지사항 개수를 조회합니다.
     * 
     * @return 전체 공지사항 개수
     */
    int getTotalNoticeCount();

    /**
     * 제목으로 공지사항을 검색합니다.
     * 
     * @param title 검색할 제목
     * @return 검색된 공지사항 리스트
     */
    List<NoticeDto> searchNoticesByTitle(String title);

    /**
     * 공지사항 유효성을 검증합니다.
     * 
     * @param noticeDto 검증할 공지사항 정보
     * @return 유효성 검증 결과
     */
    boolean validateNotice(NoticeDto noticeDto);

    /**
     * 최근 공지사항을 조회합니다.
     * 
     * @param limit 조회할 개수
     * @return 최근 공지사항 리스트
     */
    List<NoticeDto> getRecentNotices(int limit);

    /**
     * 이전 공지사항을 조회합니다.
     * 
     * @param currentId 현재 공지사항 ID
     * @return 이전 공지사항
     */
    NoticeDto getPrevNotice(Long currentId);

    /**
     * 다음 공지사항을 조회합니다.
     * 
     * @param currentId 현재 공지사항 ID
     * @return 다음 공지사항
     */
    NoticeDto getNextNotice(Long currentId);
}