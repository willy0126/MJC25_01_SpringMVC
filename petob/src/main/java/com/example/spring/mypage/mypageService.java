package com.example.spring.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class mypageService {

    private final mypageDao mypageDao;

    @Autowired
    public mypageService(mypageDao mypageDao) {
        this.mypageDao = mypageDao;
    }

    /**
     * 특정 사용자의 장례 예약 목록을 가져옵니다.
     * @param userId 사용자 ID
     * @return 장례 예약 정보 DTO 리스트
     */
    public List<mypageDto> getMyFuneralReservations(String userId) {
        // 여기서 userId 유효성 검사 등 추가 로직 가능
        return mypageDao.getFuneralReservationsByUserId(userId);
    }

    // 다른 서비스 메소드 (수정 가능)
    // public List<AnotherReservationDto> getMyOtherReservations(String userId) { ... }
}