package com.example.spring.reservation;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 예약 관련 비즈니스 로직을 처리하는 서비스
 */
@Service
public class ReservationService {

    @Autowired
    private ReservationDao reservationDao;

    /**
     * 예약 등록
     * - 시간 중복 체크 후 등록
     */
    public boolean create(ReservationDto reservation) {
        // 시간 중복 체크
        if (isTimeSlotAvailable(reservation.getDate(), reservation.getTime())) {
            int result = reservationDao.create(reservation);
            return result > 0;
        }
        return false; // 이미 예약된 시간
    }

    /**
     * 특정 날짜/시간의 예약 가능 여부 체크
     */
    public boolean isTimeSlotAvailable(String date, String time) {
        int count = reservationDao.checkTimeSlot(date, time);
        return count == 0; // 0이면 예약 가능
    }

    /**
     * 특정 날짜의 예약된 시간들 조회
     */
    public List<String> getBookedTimes(String date) {
        return reservationDao.getBookedTimes(date);
    }

    /**
     * 전화번호로 예약 목록 조회
     */
    public List<ReservationDto> getReservationsByPhone(String phone) {
        return reservationDao.getByPhone(phone);
    }

    /**
     * 예약 단건 조회
     */
    public ReservationDto read(ReservationDto reservation) {
        return reservationDao.read(reservation);
    }
}