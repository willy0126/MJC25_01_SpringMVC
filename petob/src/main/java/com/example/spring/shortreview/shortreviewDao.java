package com.example.spring.shortreview;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface shortreviewDao {
    /**
     * 모든 한 마디 리뷰를 최신순으로 조회합니다.
     * @return 리뷰 목록
     */
    List<shortreviewDto> selectAll();

    /**
     * 새로운 한 마디 리뷰를 등록합니다.
     * @param dto 등록할 리뷰 정보
     * @return 삽입된 행의 수
     */
    int create(shortreviewDto dto);

    /**
     * ID로 특정 리뷰를 조회합니다. (삭제 권한 확인용)
     * @param id 조회할 리뷰 ID
     * @return 조회된 리뷰 정보
     */
    shortreviewDto selectById(Long id);

    /**
     * ID로 리뷰를 삭제합니다.
     * @param id 삭제할 리뷰 ID
     * @return 삭제된 행의 수
     */
    int delete(Long id);
}