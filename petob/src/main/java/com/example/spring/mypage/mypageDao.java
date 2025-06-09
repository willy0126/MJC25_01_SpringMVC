package com.example.spring.mypage;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface mypageDao {

    /**
     * 특정 사용자의 장례 예약 목록을 조회합니다.
     * 
     * @param userId 사용자 ID
     * @return 장례 예약 정보 DTO 리스트
     */
    List<mypageDto> getFuneralReservationsByUserId(String userId);

}