package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationService; // Import 추가
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // Import 추가

import java.util.List;

@Service
public class adminconsoleService {

    private static final Logger logger = LoggerFactory.getLogger(adminconsoleService.class);

    @Autowired
    private adminconsoleDao adminConsoleDao;

    @Autowired // ObituaryReservationService 주입
    private ObituaryReservationService obituaryReservationService;

    public List<ReservationDto> getAllQuickCounselingReservations() {
        logger.info("Fetching all quick counseling reservations.");
        return adminConsoleDao.selectAllQuickCounselingReservations();
    }

    public List<ObituaryReservationDto> getAllFuneralReservations() {
        logger.info("Fetching all funeral reservations.");
        return adminConsoleDao.selectAllFuneralReservations();
    }

    public adminconsoleDto getAdminConsoleData() {
        logger.info("Fetching all data for admin console.");
        List<ReservationDto> quickList = getAllQuickCounselingReservations();
        List<ObituaryReservationDto> funeralList = getAllFuneralReservations();
        return new adminconsoleDto(quickList, funeralList);
    }

    /**
     * 장례 예약 상태를 업데이트합니다.
     * 이 메소드는 adminconsoleController에 의해 호출됩니다.
     * 
     * @param reservationId 장례 예약 ID.
     * @param status        새로운 상태 ("수락" 또는 "거절").
     * @return 성공 시 true, 그렇지 않으면 false.
     */
    @Transactional // 클래스 레벨이 아닌 경우 트랜잭션 어노테이션 추가
    public boolean updateObituaryReservationStatus(int reservationId, String status) {
        logger.info("관리자에 의한 장례 예약 상태 업데이트 요청: ID - {}, Status - {}", reservationId, status);
        // 장례 예약을 담당하는 특정 서비스로 위임
        return obituaryReservationService.updateReservationStatus(reservationId, status);
    }
}