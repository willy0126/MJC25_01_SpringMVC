package com.example.spring.ObituaryReservation;

import java.util.Collections;
import java.util.List; // List import 추가
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
        }
        return result;
    }

    public List<String> getBookedTimesByDate(String obDate) {
        try {
            return sqlSession.selectList("obituaryReservationMapper.getBookedTimesByDate", obDate);
        } catch (DataAccessException e) {
            logger.error("특정 날짜의 예약된 시간 조회 실패 (날짜: {}): {}", obDate, e.getMessage(), e);
            return Collections.emptyList(); // 오류 발생 시 빈 리스트 반환
        }
    }
}