package com.example.spring.adminconsole;

import com.example.spring.reservation.ReservationDto;
import com.example.spring.ObituaryReservation.ObituaryReservationDto; // 또는 mypage.mypageDto

import java.util.List;

public class adminconsoleDto {

    private List<ReservationDto> quickCounselingList;
    private List<ObituaryReservationDto> funeralReservationList;

    public adminconsoleDto() {
    }

    public adminconsoleDto(List<ReservationDto> quickCounselingList, List<ObituaryReservationDto> funeralReservationList) {
        this.quickCounselingList = quickCounselingList;
        this.funeralReservationList = funeralReservationList;
    }

    public List<ReservationDto> getQuickCounselingList() {
        return quickCounselingList;
    }

    public void setQuickCounselingList(List<ReservationDto> quickCounselingList) {
        this.quickCounselingList = quickCounselingList;
    }

    public List<ObituaryReservationDto> getFuneralReservationList() {
        return funeralReservationList;
    }

    public void setFuneralReservationList(List<ObituaryReservationDto> funeralReservationList) {
        this.funeralReservationList = funeralReservationList;
    }

    @Override
    public String toString() {
        return "AdminConsoleDto{" +
                "quickCounselingListCount=" + (quickCounselingList != null ? quickCounselingList.size() : 0) +
                ", funeralReservationListCount=" + (funeralReservationList != null ? funeralReservationList.size() : 0) +
                '}';
    }
}