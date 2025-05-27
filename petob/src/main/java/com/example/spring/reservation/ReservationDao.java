package com.example.spring.reservation;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

/**
 * 예약 관련 데이터베이스 작업을 처리하는 DAO
 */
@Repository
public class ReservationDao {

    @Autowired
    private SqlSession sqlSession;

    private static final Logger logger = LoggerFactory.getLogger(ReservationDao.class);

    /**
     * 예약 등록
     */
    public int create(ReservationDto reservation) {
        int result = -1;
        try {
            result = sqlSession.insert("reservationMapper.create", reservation);
        } catch (DataAccessException e) {
            logger.error("예약 등록 오류: {}", e.getMessage(), e);
        }
        return result;
    }

    /**
     * 특정 날짜/시간 중복 체크
     */
    public int checkTimeSlot(String date, String time) {
        int result = 0;
        try {
            ReservationDto param = new ReservationDto();
            param.setDate(date);
            param.setTime(time);
            result = sqlSession.selectOne("reservationMapper.checkTimeSlot", param);
        } catch (Exception e) {
            logger.error("시간 중복 체크 오류: {}", e.getMessage(), e);
        }
        return result;
    }

    /**
     * 특정 날짜의 예약된 시간 목록 조회
     */
    public List<String> getBookedTimes(String date) {
        List<String> result = null;
        try {
            result = sqlSession.selectList("reservationMapper.getBookedTimes", date);
        } catch (Exception e) {
            logger.error("예약된 시간 조회 오류: {}", e.getMessage(), e);
        }
        return result;
    }

    /**
     * 전화번호로 예약 목록 조회
     */
    public List<ReservationDto> getByPhone(String phone) {
        List<ReservationDto> result = null;
        try {
            result = sqlSession.selectList("reservationMapper.getByPhone", phone);
        } catch (Exception e) {
            logger.error("전화번호별 예약 조회 오류: {}", e.getMessage(), e);
        }
        return result;
    }

    /**
     * 예약 단건 조회
     */
    public ReservationDto read(ReservationDto reservation) {
        ReservationDto result = null;
        try {
            result = sqlSession.selectOne("reservationMapper.read", reservation);
        } catch (Exception e) {
            logger.error("예약 조회 오류: {}", e.getMessage(), e);
        }
        return result;
    }
}