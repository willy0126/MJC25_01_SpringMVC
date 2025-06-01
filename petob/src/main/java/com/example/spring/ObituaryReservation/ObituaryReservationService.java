package com.example.spring.ObituaryReservation;

import java.util.HashMap;
import java.util.List; // List import 추가
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
            // 전화번호에서 하이픈 제거 (클라이언트에서 이미 처리했다면 생략 가능)
            if (dto.getApplicantPhone() != null) {
                dto.setApplicantPhone(dto.getApplicantPhone().replaceAll("-", ""));
            }

            int result = obituaryReservationDao.create(dto);
            if (result > 0) {
                logger.info("장례 예약 정보 저장 성공: ID - {}, 사용자 ID - {}, 지점 - {}", dto.getReservationId(), dto.getUserId(), dto.getBranch());
                return true;
            } else {
                logger.warn("장례 예약 정보 저장 실패 (영향 받은 행 없음): 사용자 ID - {}, 지점 - {}", dto.getUserId(), dto.getBranch());
                return false;
            }
        } catch (Exception e) {
            logger.error("장례 예약 서비스 처리 중 예외 발생: 사용자 ID - {}, 지점 - {}", dto.getUserId(), dto.getBranch(), e);
            throw new RuntimeException("예약 처리 중 오류가 발생했습니다.", e);
        }
    }

    
public List<String> getBookedTimesByDateAndBranch(String obDate, String branch) {
    Map<String, Object> params = new HashMap<>();
    params.put("obDate", obDate);
    params.put("branch", branch);
    return obituaryReservationDao.getBookedTimesByDateAndBranch(params);
}
    
}