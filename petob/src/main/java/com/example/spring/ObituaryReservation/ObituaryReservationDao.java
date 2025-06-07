package com.example.spring.ObituaryReservation;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.HashMap; // Map 사용을 위해 필요

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class ObituaryReservationDao {

    private static final Logger logger = LoggerFactory.getLogger(ObituaryReservationDao.class);

    @Autowired
    private SqlSessionTemplate sqlSession;

    public int create(ObituaryReservationDto dto) {
        int result = 0;
        try {
            result = sqlSession.insert("obituaryReservationMapper.create", dto);
        } catch (DataAccessException e) {
            logger.error("장례 예약 정보 저장 실패: {}", e.getMessage(), e);
            // 사용자 정의 예외를 발생시키거나 특정 오류 코드를 반환하는 것을 고려
        }
        return result;
    }

    public List<String> getBookedTimesByDateAndBranch(Map<String, Object> params) {
        try {
            return sqlSession.selectList("obituaryReservationMapper.getBookedTimesByDateAndBranch", params);
        } catch (DataAccessException e) {
            logger.error("특정 날짜와 지점의 예약된 시간 조회 실패 (날짜: {}, 지점: {}): {}", params.get("obDate"), params.get("branch"), e.getMessage(), e);
            return Collections.emptyList();
        }
    }

    /**
     * 예약 상태를 업데이트합니다.
     * @param reservationId 업데이트할 예약의 ID.
     * @param status 새로운 상태 값.
     * @return 영향을 받은 행의 수.
     */
    public int updateStatus(int reservationId, String status) {
        int result = 0;
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("reservationId", reservationId);
            params.put("status", status);
            result = sqlSession.update("obituaryReservationMapper.updateStatus", params);
        } catch (DataAccessException e) {
            logger.error("장례 예약 상태 업데이트 실패 (ID: {}, Status: {}): {}", reservationId, status, e.getMessage(), e);
            // 사용자 정의 예외 발생 또는 특정 오류 코드 반환 고려
        }
        return result;
    }
}