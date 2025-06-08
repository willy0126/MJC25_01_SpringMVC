package com.example.spring.ObituaryReservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ObituaryReservationService {

    private static final Logger logger = LoggerFactory.getLogger(ObituaryReservationService.class);

    @Autowired
    private ObituaryReservationDao obituaryReservationDao;

    @Transactional
    public boolean createReservation(ObituaryReservationDto dto) {
        try {
            if (dto.getApplicantPhone() != null) {
                dto.setApplicantPhone(dto.getApplicantPhone().replaceAll("-", ""));
            }
            // 기본 상태 설정
            dto.setStatus("신청대기중");

            int result = obituaryReservationDao.create(dto);
            if (result > 0) {
                logger.info("장례 예약 정보 저장 성공: ID - {}, 사용자 ID - {}, 지점 - {}, 상태 - {}", dto.getReservationId(),
                        dto.getUserId(), dto.getBranch(), dto.getStatus());
                return true;
            } else {
                logger.warn("장례 예약 정보 저장 실패 (영향 받은 행 없음): 사용자 ID - {}, 지점 - {}", dto.getUserId(), dto.getBranch());
                return false;
            }
        } catch (Exception e) {
            logger.error("장례 예약 서비스 처리 중 예외 발생: 사용자 ID - {}, 지점 - {}", dto.getUserId(), dto.getBranch(), e);
            // 여기서는 서비스 레이어에 맞는 사용자 정의 예외를 던지는 것이 더 좋습니다.
            throw new RuntimeException("예약 처리 중 오류가 발생했습니다.", e);
        }
    }

    public List<String> getBookedTimesByDateAndBranch(String obDate, String branch) {
        Map<String, Object> params = new HashMap<>();
        params.put("obDate", obDate);
        params.put("branch", branch);
        // 매퍼가 업데이트되었으므로 이제 '수락' 상태의 예약만 올바르게 고려합니다.
        return obituaryReservationDao.getBookedTimesByDateAndBranch(params);
    }

    /**
     * 장례 예약의 상태를 업데이트합니다.
     * 
     * @param reservationId 예약 ID.
     * @param status        새로운 상태 ("수락" 또는 "거절").
     * @return 성공 시 true, 그렇지 않으면 false.
     */
    @Transactional
    public boolean updateReservationStatus(int reservationId, String status) {
        try {
            // 상태 값 유효성 검사
            if (!"수락".equals(status) && !"거절".equals(status) && !"신청대기중".equals(status)) {
                logger.warn("유효하지 않은 상태 값으로 업데이트 시도: ID - {}, Status - {}", reservationId, status);
                return false;
            }
            int result = obituaryReservationDao.updateStatus(reservationId, status);
            if (result > 0) {
                logger.info("장례 예약 상태 업데이트 성공: ID - {}, 새로운 상태 - {}", reservationId, status);
                return true;
            } else {
                logger.warn("장례 예약 상태 업데이트 실패 (영향 받은 행 없음): ID - {}, 상태 - {}", reservationId, status);
                return false;
            }
        } catch (Exception e) {
            logger.error("장례 예약 상태 업데이트 서비스 처리 중 예외 발생: ID - {}, Status - {}", reservationId, status, e);
            throw new RuntimeException("예약 상태 업데이트 처리 중 오류가 발생했습니다.", e);
        }
    }
}