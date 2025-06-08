package com.example.spring.FuneralReview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

@Component
public class FuneralReviewDAO {
    // 로그 출력을 위한 Logger 객체 생성
    private static final Logger logger = LoggerFactory.getLogger(FuneralReviewDTO.class);

    @Autowired // Spring이 SqlSessionTemplate 객체를 자동으로 주입
    private SqlSessionTemplate sqlSession;

    /**
     * 리뷰 목록을 조회하는 메서드 (페이징 및 검색 기능 포함)
     * - 검색 조건이 주어지면 해당 조건(reviewTitle, reviewContent, userId, username, location
     * 등)에 따라 필터링된 결과를 조회
     * - 검색 조건이 없으면 전체 리뷰를 조회
     * - 페이징 처리를 위해 offset과 limit(페이지당 리뷰 수)도 함께 전달
     *
     * @param offset           조회 시작 위치 (예: 0부터 시작, LIMIT offset, count 에서 사용)
     * @param listCountPerPage 한 페이지에 표시할 리뷰 수
     * @param searchType       검색 기준 ("reviewTitle", "reviewContent", "userId",
     *                         "username", "location", "all" 중 하나)
     * @param searchKeyword    검색어 (null 또는 빈 문자열이면 전체 조회)
     * @return 리뷰 리스트 (List<ReviewDto>), 실패 시 null 또는 빈 리스트 반환
     */
    public List<FuneralReviewDTO> list(int offset, int listCountPerPage, String searchType, String searchKeyword) {
        // 쿼리에 전달할 파라미터 구성
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("listCountPerPage", listCountPerPage);
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);

        List<FuneralReviewDTO> reviews = null;

        try {
            // MyBatis 매퍼(reviewMapper.xml)의 list 쿼리 실행
            reviews = sqlSession.selectList("reviewMapper.list", params);
        } catch (DataAccessException e) {
            // 예외 발생 시 로그 출력
            logger.error("리뷰 목록 조회 오류 : {}", e.getMessage(), e);
        }

        return reviews;
    }

    /**
     * 리뷰를 데이터베이스에 저장하는 메서드 (MyBatis 기반)
     * 
     * @param review 사용자가 작성한 리뷰 데이터
     * @return 삽입된 리뷰 ID (성공 시 review.getId()에 자동 주입됨, 실패 시 -1)
     */
    public int create(FuneralReviewDTO review) {
        int result = -1;

        try {
            // MyBatis 매퍼의 reviewMapper.create 구문 실행
            // useGeneratedKeys="true"와 keyProperty="id"가 설정되어 있어 review.id에 자동으로 삽입된 ID가
            // 주입됨
            result = sqlSession.insert("reviewMapper.create", review);

            // insert()는 삽입된 행 수를 반환하므로, 성공 시 review.getId()에서 생성된 리뷰 ID를 확인 가능
            return result > 0 ? review.getId() : -1;

        } catch (DataAccessException e) {
            logger.error("리뷰 등록 오류 : {}", e.getMessage(), e);
            return -1;
        }
    }

    /**
     * 리뷰 ID를 기준으로 단건 조회하는 메서드
     * MyBatis 매퍼(reviewMapper.read)를 호출하여 리뷰 1건을 조회함
     *
     * @param id 조회할 리뷰의 ID
     * @return ReviewDto 객체 (조회된 리뷰), 실패 시 null 반환
     */
    public FuneralReviewDTO read(int id) {
        FuneralReviewDTO review = null;

        try {
            // reviewMapper.xml에 정의된 <select id="read"> 구문 실행
            review = sqlSession.selectOne("reviewMapper.read", id);
        } catch (DataAccessException e) {
            // SQL 실행 중 예외 발생 시 로그 출력
            logger.error("리뷰 상세 조회 오류 : {}", e.getMessage(), e);
        }

        return review;
    }

    /**
     * 리뷰를 수정하는 메서드
     * MyBatis 매퍼(reviewMapper.update)를 호출하여 리뷰 정보를 DB에 반영함
     *
     * @param review 수정할 리뷰 정보 (ID 포함)
     * @return 수정된 행 수 (성공 시 1, 실패 또는 오류 시 -1)
     */
    public int update(FuneralReviewDTO review) {
        int result = -1;

        try {
            // reviewMapper.xml의 <update id="update"> 구문 실행
            result = sqlSession.update("reviewMapper.update", review);
        } catch (DataAccessException e) {
            // SQL 실행 중 오류 발생 시 로그 출력
            logger.error("리뷰 수정 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 리뷰를 삭제하는 메서드
     * MyBatis 매퍼(reviewMapper.delete)를 호출하여 ID에 해당하는 리뷰를 삭제함
     *
     * @param id 삭제할 리뷰의 ID
     * @return 삭제된 행 수 (성공 시 1, 실패 또는 예외 시 -1)
     */
    public int delete(int id) {
        int result = -1;

        try {
            // reviewMapper.xml의 <delete id="delete"> 구문 실행
            result = sqlSession.delete("reviewMapper.delete", id);
        } catch (DataAccessException e) {
            // 예외 발생 시 로그 출력
            logger.error("리뷰 삭제 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 파일 정보 업데이트 메서드
     * 리뷰에 첨부된 파일 정보를 업데이트함
     * 
     * @param review 파일 정보를 포함한 리뷰 객체
     * @return 업데이트된 행 수 (성공 시 1, 실패 시 -1)
     */
    public int updateFile(FuneralReviewDTO review) {
        int result = -1;

        try {
            result = sqlSession.update("reviewMapper.updateFile", review);
        } catch (DataAccessException e) {
            logger.error("리뷰 파일 업데이트 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 전체 리뷰 수를 조회하는 메서드 (검색 조건 포함)
     * - 검색 조건이 주어진 경우 해당 조건(reviewTitle, reviewContent, userId, username, location
     * 등)에 맞는 리뷰 수를 반환
     * - 검색 조건이 없을 경우 전체 리뷰 수를 반환
     * - 페이징 처리를 위한 totalCount 계산에 사용됨
     *
     * @param searchType    검색 기준 ("reviewTitle", "reviewContent", "userId",
     *                      "username", "location", "all" 중 하나)
     * @param searchKeyword 검색어 (null 또는 빈 문자열이면 전체 리뷰 수 조회)
     * @return 조건에 해당하는 리뷰 수 (int)
     */
    public int totalCount(String searchType, String searchKeyword) {
        // 검색 조건을 파라미터 맵에 담아 전달
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);

        // MyBatis 매퍼(reviewMapper.totalCount) 실행 후 리뷰 수 반환
        return sqlSession.selectOne("reviewMapper.totalCount", params);
    }
}
