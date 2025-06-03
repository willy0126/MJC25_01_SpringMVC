package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto; // 또는 mypage.mypageDto
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class adminconsoleService {

    private static final Logger logger = LoggerFactory.getLogger(adminconsoleService.class);

    @Autowired
    private adminconsoleDao adminConsoleDao;

    /**
     * 모든 간편 상담 예약 목록을 가져옵니다.
     * @return 간편 상담 예약 DTO 리스트
     */
    public List<ReservationDto> getAllQuickCounselingReservations() {
        logger.info("Fetching all quick counseling reservations.");
        return adminConsoleDao.selectAllQuickCounselingReservations();
    }

    /**
     * 모든 장례 예약 목록을 가져옵니다.
     * @return 장례 예약 DTO 리스트
     */
    public List<ObituaryReservationDto> getAllFuneralReservations() {
        logger.info("Fetching all funeral reservations.");
        return adminConsoleDao.selectAllFuneralReservations();
    }

    /**
     * 관리자 콘솔에 필요한 모든 데이터를 가져옵니다.
     * @return AdminConsoleDto 객체 (두 예약 목록 포함)
     */
    public adminconsoleDto getAdminConsoleData() {
        logger.info("Fetching all data for admin console.");
        List<ReservationDto> quickList = getAllQuickCounselingReservations();
        List<ObituaryReservationDto> funeralList = getAllFuneralReservations();
        return new adminconsoleDto(quickList, funeralList);
    }
}