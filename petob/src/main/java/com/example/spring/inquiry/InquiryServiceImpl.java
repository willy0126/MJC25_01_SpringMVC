package com.example.spring.inquiry;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 문의 게시판 서비스 구현 클래스
 * - 반드시 @Service 어노테이션이 있어야 Spring Bean으로 등록됩니다
 */
@Service("inquiryService") // Bean 이름을 명시적으로 지정
@Transactional // 트랜잭션 처리 추가

public class InquiryServiceImpl implements InquiryService {
    @Autowired
    private InquiryDao inquiryDao;

    private static final Logger logger = LoggerFactory.getLogger(InquiryServiceImpl.class);

    @Override
    public Map<String, Object> list(int page, int size, String search, String category, String status) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 페이징 계산
            int offset = (page - 1) * size;

            // 검색 조건 설정
            Map<String, Object> params = new HashMap<>();
            params.put("search", search);
            params.put("category", category);
            params.put("status", status);
            params.put("limit", size);
            params.put("offset", offset);

            // 목록 조회
            List<InquiryDto> inquiries = inquiryDao.list(params);

            // 전체 개수 조회
            int totalCount = inquiryDao.count(params);
            int totalPages = (int) Math.ceil((double) totalCount / size);

            result.put("inquiries", inquiries);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            result.put("size", size);

            logger.debug("문의 목록 조회 완료 - 총 {}건, {}페이지", totalCount, totalPages);

        } catch (Exception e) {
            logger.error("문의 목록 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("문의 목록 조회 중 오류가 발생했습니다.", e);
        }

        return result;
    }

    @Override
    public Map<String, Object> listByUser(String userId, int page, int size) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 페이징 계산
            int offset = (page - 1) * size;

            // 검색 조건 설정
            Map<String, Object> params = new HashMap<>();
            params.put("userId", userId);
            params.put("limit", size);
            params.put("offset", offset);

            // 목록 조회
            List<InquiryDto> inquiries = inquiryDao.listByUser(params);

            // 전체 개수 조회
            int totalCount = inquiryDao.count(params);
            int totalPages = (int) Math.ceil((double) totalCount / size);

            result.put("inquiries", inquiries);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            result.put("size", size);

            logger.debug("사용자별 문의 목록 조회 완료 - userId: {}, 총 {}건", userId, totalCount);

        } catch (Exception e) {
            logger.error("사용자별 문의 목록 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("사용자별 문의 목록 조회 중 오류가 발생했습니다.", e);
        }

        return result;
    }

    @Override
    public InquiryDto read(Long inquiryId) {
        try {
            InquiryDto inquiry = inquiryDao.read(inquiryId);
            return inquiry;

        } catch (Exception e) {
            logger.error("문의 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("문의 조회 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public boolean create(InquiryDto inquiry) {
        try {
            // 기본값 설정
            if (inquiry.getStatus() == null || inquiry.getStatus().isEmpty()) {
                inquiry.setStatus("WAITING");
            }
            if (inquiry.getIsSecret() == null) {
                inquiry.setIsSecret(false);
            }
            // 작성일시 설정
            inquiry.setCreatedDate(LocalDateTime.now());

            logger.debug("문의 등록 시도 - userId: {}, title: {}", inquiry.getUserId(), inquiry.getTitle());

            int result = inquiryDao.create(inquiry);

            if (result > 0) {
                logger.info("문의 등록 완료 - inquiryId: {}", inquiry.getInquiryId());
                return true;
            } else {
                logger.warn("문의 등록 실패 - 결과값: {}", result);
                return false;
            }

        } catch (Exception e) {
            logger.error("문의 등록 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("문의 등록 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public boolean update(InquiryDto inquiry, String userId) {
        try {
            // 기존 문의 조회
            InquiryDto existingInquiry = inquiryDao.read(inquiry.getInquiryId());

            if (existingInquiry == null) {
                logger.warn("수정할 문의가 존재하지 않음 - inquiryId: {}", inquiry.getInquiryId());
                return false;
            }

            // 권한 확인
            if (!existingInquiry.getUserId().equals(userId)) {
                logger.warn("문의 수정 권한 없음 - inquiryId: {}, requestUserId: {}, ownerUserId: {}",
                        inquiry.getInquiryId(), userId, existingInquiry.getUserId());
                return false;
            }

            // 답변 완료된 문의는 수정 불가
            if ("COMPLETED".equals(existingInquiry.getStatus())) {
                logger.warn("답변 완료된 문의는 수정 불가 - inquiryId: {}", inquiry.getInquiryId());
                return false;
            }

            // 수정일시 설정
            inquiry.setUpdatedDate(LocalDateTime.now());

            int result = inquiryDao.update(inquiry);

            if (result > 0) {
                logger.info("문의 수정 완료 - inquiryId: {}", inquiry.getInquiryId());
                return true;
            } else {
                logger.warn("문의 수정 실패 - 결과값: {}", result);
                return false;
            }

        } catch (Exception e) {
            logger.error("문의 수정 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("문의 수정 중 오류가 발생했습니다.", e);
        }
    }

@Override
public boolean reply(Long inquiryId, String reply, String replyBy) {
    try {
        // 기존 문의 조회
        InquiryDto existingInquiry = inquiryDao.read(inquiryId);
        if (existingInquiry == null) {
            logger.warn("답변할 문의가 존재하지 않음 - inquiryId: {}", inquiryId);
            return false;
        }

        // 답변 데이터 세팅
        InquiryDto dto = new InquiryDto();
        dto.setInquiryId(inquiryId);
        dto.setReplyContent(reply);
        dto.setReplyBy(replyBy);
        dto.setReplyDate(LocalDateTime.now());
        dto.setStatus("COMPLETED");

        // MyBatis mapper 호출
        int result = inquiryDao.reply(dto);
        if (result > 0) {
            logger.info("답변 등록 완료 - inquiryId: {}", inquiryId);
            return true;
        } else {
            logger.warn("답변 등록 실패 - inquiryId: {}", inquiryId);
            return false;
        }
    } catch (Exception e) {
        logger.error("답변 등록 중 오류: {}", e.getMessage(), e);
        throw new RuntimeException("답변 등록 중 오류가 발생했습니다.", e);
    }
}



    @Override
public boolean delete(Long inquiryId, String userId, boolean isAdmin) {
    try {
        // 기존 문의 조회 (inquiryMapper → inquiryDao로 수정)
        InquiryDto inquiry = inquiryDao.read(inquiryId);
        
        if (inquiry == null) {
            logger.warn("삭제할 문의가 존재하지 않음 - inquiryId: {}", inquiryId);
            return false;
        }

        // 권한 확인 (관리자이거나 본인의 문의인 경우만)
        if (!isAdmin && !userId.equals(inquiry.getUserId())) {
            logger.warn("문의 삭제 권한 없음 - inquiryId: {}, requestUserId: {}, ownerUserId: {}", 
                       inquiryId, userId, inquiry.getUserId());
            return false;
        }

        // 삭제 실행 (inquiryMapper → inquiryDao로 수정)
        int result = inquiryDao.delete(inquiryId);
        
        if (result > 0) {
            logger.info("문의 삭제 완료 - inquiryId: {}, userId: {}", inquiryId, userId);
            return true;
        } else {
            logger.warn("문의 삭제 실패 - 결과값: {}", result);
            return false;
        }

    } catch (Exception e) {
        logger.error("문의 삭제 중 오류: {}", e.getMessage(), e);
        throw new RuntimeException("문의 삭제 중 오류가 발생했습니다.", e);
    }
}

@Override
public boolean delete(Long inquiryId, String userId) {
    // 일반 사용자 삭제 (관리자 권한 없음)
    return delete(inquiryId, userId, false);
}

    @Override
    public boolean updateStatus(Long inquiryId, String status) {
        try {
            // 기존 문의 조회
            InquiryDto existingInquiry = inquiryDao.read(inquiryId);

            if (existingInquiry == null) {
                logger.warn("상태 변경할 문의가 존재하지 않음 - inquiryId: {}", inquiryId);
                return false;
            }

            // 상태 변경
            InquiryDto inquiryForUpdate = new InquiryDto();
            inquiryForUpdate.setInquiryId(inquiryId);
            inquiryForUpdate.setStatus(status);
            inquiryForUpdate.setUpdatedDate(LocalDateTime.now());

            int result = inquiryDao.update(inquiryForUpdate);

            if (result > 0) {
                logger.info("문의 상태 변경 완료 - inquiryId: {}, status: {}", inquiryId, status);
                return true;
            } else {
                logger.warn("문의 상태 변경 실패 - 결과값: {}", result);
                return false;
            }

        } catch (Exception e) {
            logger.error("문의 상태 변경 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("문의 상태 변경 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public List<InquiryDto> getNoticeList() {
        try {
            // 공지사항은 별도 테이블이나 특별한 카테고리로 관리
            Map<String, Object> params = new HashMap<>();
            params.put("category", "NOTICE");
            params.put("limit", 10);
            params.put("offset", 0);

            return inquiryDao.list(params);

        } catch (Exception e) {
            logger.error("공지사항 목록 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("공지사항 목록 조회 중 오류가 발생했습니다.", e);
        }
    }

    @Override
    public int getTotalCount(String category, String search, String status) {
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("search", search);
            params.put("category", category);
            params.put("status", status);

            return inquiryDao.count(params);

        } catch (Exception e) {
            logger.error("전체 문의 개수 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("전체 문의 개수 조회 중 오류가 발생했습니다.", e);
        }
    }

}