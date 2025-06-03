package com.example.spring.notice;
import java.util.List;

public interface NoticeDao {
    
    /**
     * 모든 공지사항을 조회합니다. (최신순 정렬)
     * @return 공지사항 리스트
     */
    List<NoticeDto> selectAllNotices();
    
    /**
     * ID로 특정 공지사항을 조회합니다.
     * @param id 공지사항 ID
     * @return 공지사항 정보
     */
    NoticeDto selectNoticeById(Long id);
    
    /**
     * 새로운 공지사항을 등록합니다.
     * @param noticeDto 등록할 공지사항 정보
     * @return 등록된 행의 수 (성공시 1, 실패시 0)
     */
    int insertNotice(NoticeDto noticeDto);
    
    /**
     * 공지사항을 수정합니다.
     * @param noticeDto 수정할 공지사항 정보
     * @return 수정된 행의 수 (성공시 1, 실패시 0)
     */
    int updateNotice(NoticeDto noticeDto);
    
    /**
     * 공지사항을 삭제합니다.
     * @param id 삭제할 공지사항 ID
     * @return 삭제된 행의 수 (성공시 1, 실패시 0)
     */
    int deleteNotice(Long id);
    
    /**
     * 공지사항 총 개수를 조회합니다.
     * @return 전체 공지사항 개수
     */
    int countNotices();
    
    /**
     * 제목으로 공지사항을 검색합니다.
     * @param title 검색할 제목
     * @return 검색된 공지사항 리스트
     */
    List<NoticeDto> selectNoticesByTitle(String title);
}

