package com.example.spring.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDao noticeDao;

    @Override
    public List<NoticeDto> getAllNotices() {
        try {
            System.out.println("=== getAllNotices 호출 ===");
            List<NoticeDto> notices = noticeDao.selectAllNotices();
            System.out.println("조회된 공지사항 개수: " + notices.size());
            return notices;
        } catch (Exception e) {
            System.err.println("getAllNotices 오류: " + e.getMessage());
            e.printStackTrace();
            return List.of(); // 빈 리스트 반환
        }
    }

    @Override
    public NoticeDto getNoticeById(Long id) {
        try {
            System.out.println("=== getNoticeById 호출 - ID: " + id + " ===");
            NoticeDto notice = noticeDao.selectNoticeById(id);
            if (notice != null) {
                System.out.println("공지사항 조회 성공: " + notice.getTitle());
            } else {
                System.out.println("해당 ID의 공지사항을 찾을 수 없습니다.");
            }
            return notice;
        } catch (Exception e) {
            System.err.println("getNoticeById 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean createNotice(NoticeDto noticeDto) {
        try {
            // 유효성 검증
            if (!validateNotice(noticeDto)) {
                System.err.println("공지사항 유효성 검증 실패");
                return false;
            }

            // 작성자가 없으면 기본값 설정
            if (noticeDto.getAuthor() == null || noticeDto.getAuthor().trim().isEmpty()) {
                noticeDto.setAuthor("관리자");
            }

            // 작성일 설정 (DB에서 NOW()로 처리하므로 여기서는 설정하지 않음)
            
            System.out.println("=== 공지사항 생성 디버깅 ===");
            System.out.println("제목: " + noticeDto.getTitle());
            System.out.println("작성자: " + noticeDto.getAuthor());
            System.out.println("내용 길이: " + (noticeDto.getContent() != null ? noticeDto.getContent().length() : 0));
            
            int result = noticeDao.insertNotice(noticeDto);
            boolean success = result > 0;
            
            if (success) {
                System.out.println("공지사항 생성 성공 - 생성된 ID: " + noticeDto.getId());
            } else {
                System.err.println("공지사항 생성 실패");
            }
            
            return success;
        } catch (Exception e) {
            System.err.println("createNotice 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateNotice(NoticeDto noticeDto) {
        try {
            // 유효성 검증
            if (!validateNotice(noticeDto)) {
                System.err.println("공지사항 유효성 검증 실패");
                return false;
            }

            // 기존 공지사항 존재 여부 확인
            NoticeDto existingNotice = noticeDao.selectNoticeById(noticeDto.getId());
            if (existingNotice == null) {
                System.err.println("수정할 공지사항을 찾을 수 없습니다. ID: " + noticeDto.getId());
                return false;
            }

            System.out.println("=== 공지사항 수정 디버깅 ===");
            System.out.println("ID: " + noticeDto.getId());
            System.out.println("제목: " + noticeDto.getTitle());
            System.out.println("작성자: " + noticeDto.getAuthor());
            
            int result = noticeDao.updateNotice(noticeDto);
            boolean success = result > 0;
            
            if (success) {
                System.out.println("공지사항 수정 성공");
            } else {
                System.err.println("공지사항 수정 실패");
            }
            
            return success;
        } catch (Exception e) {
            System.err.println("updateNotice 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteNotice(Long id) {
        try {
            System.out.println("=== 공지사항 삭제 - ID: " + id + " ===");
            
            // 기존 공지사항 존재 여부 확인
            NoticeDto existingNotice = noticeDao.selectNoticeById(id);
            if (existingNotice == null) {
                System.err.println("삭제할 공지사항을 찾을 수 없습니다. ID: " + id);
                return false;
            }

            int result = noticeDao.deleteNotice(id);
            boolean success = result > 0;
            
            if (success) {
                System.out.println("공지사항 삭제 성공");
            } else {
                System.err.println("공지사항 삭제 실패");
            }
            
            return success;
        } catch (Exception e) {
            System.err.println("deleteNotice 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int getTotalNoticeCount() {
        try {
            int count = noticeDao.selectTotalCount();
            System.out.println("전체 공지사항 개수: " + count);
            return count;
        } catch (Exception e) {
            System.err.println("getTotalNoticeCount 오류: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<NoticeDto> searchNoticesByTitle(String title) {
        try {
            System.out.println("=== 공지사항 제목 검색 - 검색어: '" + title + "' ===");
            
            if (title == null || title.trim().isEmpty()) {
                System.out.println("검색어가 비어있어 전체 목록을 반환합니다.");
                return getAllNotices();
            }
            
            List<NoticeDto> notices = noticeDao.selectNoticesByTitle(title.trim());
            System.out.println("검색된 공지사항 개수: " + notices.size());
            return notices;
        } catch (Exception e) {
            System.err.println("searchNoticesByTitle 오류: " + e.getMessage());
            e.printStackTrace();
            return List.of(); // 빈 리스트 반환
        }
    }

    @Override
    public boolean validateNotice(NoticeDto noticeDto) {
        if (noticeDto == null) {
            System.err.println("유효성 검증 실패: noticeDto가 null입니다.");
            return false;
        }
        
        // 제목 검증
        if (noticeDto.getTitle() == null || noticeDto.getTitle().trim().isEmpty()) {
            System.err.println("유효성 검증 실패: 제목이 비어있습니다.");
            return false;
        }
        
        // 내용 검증
        if (noticeDto.getContent() == null || noticeDto.getContent().trim().isEmpty()) {
            System.err.println("유효성 검증 실패: 내용이 비어있습니다.");
            return false;
        }
        
        // 제목 길이 검증 (DB 컬럼 크기에 맞춤: VARCHAR(255))
        if (noticeDto.getTitle().length() > 255) {
            System.err.println("유효성 검증 실패: 제목이 너무 깁니다. (최대 255자)");
            return false;
        }
        
        // 작성자 길이 검증 (DB 컬럼 크기에 맞춤: VARCHAR(100))
        if (noticeDto.getAuthor() != null && noticeDto.getAuthor().length() > 100) {
            System.err.println("유효성 검증 실패: 작성자명이 너무 깁니다. (최대 100자)");
            return false;
        }
        
        return true;
    }

    @Override
    public List<NoticeDto> getRecentNotices(int limit) {
        try {
            System.out.println("=== getRecentNotices 호출 - limit: " + limit + " ===");
            
            if (limit <= 0) {
                System.err.println("잘못된 limit 값: " + limit);
                return List.of();
            }
            
            List<NoticeDto> notices = noticeDao.selectRecentNotices(limit);
            System.out.println("메인페이지용 공지사항 " + notices.size() + "개 조회 완료");
            return notices;
        } catch (Exception e) {
            System.err.println("getRecentNotices 오류: " + e.getMessage());
            e.printStackTrace();
            return List.of(); // 빈 리스트 반환
        }
    }
    
    /**
     * 이전 공지사항 조회 (현재 공지사항보다 작은 ID 중 가장 큰 것)
     * DB에서는 별도 쿼리가 필요하므로 필요시 NoticeDao에 메서드 추가
     */
    public NoticeDto getPrevNotice(Long currentId) {
        try {
            List<NoticeDto> allNotices = noticeDao.selectAllNotices();
            return allNotices.stream()
                    .filter(notice -> notice.getId() < currentId)
                    .max((n1, n2) -> n1.getId().compareTo(n2.getId()))
                    .orElse(null);
        } catch (Exception e) {
            System.err.println("getPrevNotice 오류: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * 다음 공지사항 조회 (현재 공지사항보다 큰 ID 중 가장 작은 것)
     * DB에서는 별도 쿼리가 필요하므로 필요시 NoticeDao에 메서드 추가
     */
    public NoticeDto getNextNotice(Long currentId) {
        try {
            List<NoticeDto> allNotices = noticeDao.selectAllNotices();
            return allNotices.stream()
                    .filter(notice -> notice.getId() > currentId)
                    .min((n1, n2) -> n1.getId().compareTo(n2.getId()))
                    .orElse(null);
        } catch (Exception e) {
            System.err.println("getNextNotice 오류: " + e.getMessage());
            return null;
        }
    }
}