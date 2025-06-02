package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto; // 또는 mypage.mypageDto
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.dao.DataAccessException;


import java.util.Collections;
import java.util.List;

@Repository
public class adminconsoleDao {

    private static final Logger logger = LoggerFactory.getLogger(adminconsoleDao.class);

    @Autowired
    private SqlSessionTemplate sqlSession;

    /**
     * 모든 간편 상담 예약 목록을 조회합니다.
     * @return 간편 상담 예약 DTO 리스트
     */
    public List<ReservationDto> selectAllQuickCounselingReservations() {
        List<ReservationDto> list = null;
        try {
            list = sqlSession.selectList("adminConsoleMapper.selectAllQuickCounselingReservations");
            logger.debug("Fetched {} quick counseling reservations.", list != null ? list.size() : 0);
        } catch (DataAccessException e) {
            logger.error("Error fetching all quick counseling reservations: {}", e.getMessage(), e);
            return Collections.emptyList(); // 오류 발생 시 빈 리스트 반환
        }
        return list;
    }

    /**
     * 모든 장례 예약 목록을 조회합니다.
     * @return 장례 예약 DTO 리스트
     */
    public List<ObituaryReservationDto> selectAllFuneralReservations() {
        List<ObituaryReservationDto> list = null;
        try {
            list = sqlSession.selectList("adminConsoleMapper.selectAllFuneralReservations");
            logger.debug("Fetched {} funeral reservations.", list != null ? list.size() : 0);
        } catch (DataAccessException e) {
            logger.error("Error fetching all funeral reservations: {}", e.getMessage(), e);
            return Collections.emptyList(); // 오류 발생 시 빈 리스트 반환
        }
        return list;
    }
}