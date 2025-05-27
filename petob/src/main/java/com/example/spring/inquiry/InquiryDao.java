package com.example.spring.inquiry;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

/**
 * 문의게시판 관련 데이터베이스 작업을 처리하는 DAO 클래스
 * - 문의 등록, 조회, 수정, 삭제, 목록 조회 등을 수행
 */
@Repository
public class InquiryDao {

    @Autowired
    private SqlSession sqlSession; // MyBatis SQL 세션

    private static final Logger logger = LoggerFactory.getLogger(InquiryDao.class);

    /**
     * 문의 등록
     * - MyBatis 매퍼(inquiryMapper.create)를 호출하여 INQUIRY 테이블에 문의 정보를 삽입
     * 
     * @param inquiry 등록할 문의 정보(InquiryDto)
     * @return 삽입 성공 시 1, 실패 시 -1
     */
    public int create(InquiryDto inquiry) {
        int result = -1;

        try {
            result = sqlSession.insert("inquiryMapper.create", inquiry);
        } catch (DataAccessException e) {
            logger.error("문의 등록 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 문의 단건 조회
     * - inquiryId를 기준으로 문의 1건 조회
     * - inquiryMapper.xml의 <select id="read"> 쿼리를 실행함
     *
     * @param inquiryId 조회할 문의 ID
     * @return 조회된 문의 정보(InquiryDto), 없을 경우 null 반환
     */
    public InquiryDto read(Long inquiryId) {
        InquiryDto result = null;

        try {
            result = sqlSession.selectOne("inquiryMapper.read", inquiryId);
        } catch (Exception e) {
            logger.error("문의 조회 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 문의 목록 조회 (페이징 포함)
     * - 검색 조건과 페이징 정보를 포함하여 문의 목록 조회
     * - inquiryMapper.xml의 <select id="list"> 쿼리를 호출
     *
     * @param params 검색 조건 및 페이징 정보가 담긴 Map
     * @return 문의 목록(List<InquiryDto>)
     */
    public List<InquiryDto> list(Map<String, Object> params) {
        List<InquiryDto> result = null;

        try {
            result = sqlSession.selectList("inquiryMapper.list", params);
        } catch (Exception e) {
            logger.error("문의 목록 조회 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 전체 문의 개수 조회
     * - 검색 조건에 해당하는 전체 문의 개수 조회 (페이징 처리용)
     *
     * @param params 검색 조건이 담긴 Map
     * @return 전체 문의 개수
     */
    public int count(Map<String, Object> params) {
        int result = 0;

        try {
            result = sqlSession.selectOne("inquiryMapper.count", params);
        } catch (Exception e) {
            logger.error("문의 개수 조회 오료 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 문의 정보 수정
     * - 전달받은 InquiryDto의 필드 중 null이 아닌 값만 DB에 반영
     * - inquiryMapper.xml의 <update id="update"> 쿼리를 호출
     *
     * @param inquiry 수정할 문의 정보가 담긴 InquiryDto 객체
     * @return 수정된 행 수 (성공 시 1, 실패 시 0 또는 -1)
     */
    public int update(InquiryDto inquiry) {
        int result = -1;

        try {
            result = sqlSession.update("inquiryMapper.update", inquiry);
        } catch (DataAccessException e) {
            logger.error("문의 수정 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 관리자 답변 등록/수정
     * - 문의에 대한 관리자 답변 처리
     * - inquiryMapper.xml의 <update id="reply"> 쿼리를 호출
     *
     * @param inquiry 답변 정보가 담긴 InquiryDto 객체
     * @return 수정된 행 수 (성공 시 1, 실패 시 0 또는 -1)
     */
    public int reply(InquiryDto inquiry) {
        int result = -1;

        try {
            result = sqlSession.update("inquiryMapper.reply", inquiry);
        } catch (DataAccessException e) {
            logger.error("문의 답변 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 문의 삭제
     * - inquiryId를 기준으로 문의 삭제
     * - inquiryMapper.xml의 <delete id="delete"> 쿼리를 호출
     *
     * @param inquiryId 삭제할 문의 ID
     * @return 삭제된 행 수 (성공 시 1, 실패 시 0 또는 -1)
     */
    public int delete(Long inquiryId) {
        int result = -1;

        try {
            result = sqlSession.delete("inquiryMapper.delete", inquiryId);
        } catch (DataAccessException e) {
            logger.error("문의 삭제 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * 사용자별 문의 목록 조회
     * - 특정 사용자가 작성한 문의 목록 조회
     *
     * @param params 사용자 ID와 페이징 정보가 담긴 Map
     * @return 사용자별 문의 목록(List<InquiryDto>)
     */
    public List<InquiryDto> listByUser(Map<String, Object> params) {
        List<InquiryDto> result = null;

        try {
            result = sqlSession.selectList("inquiryMapper.listByUser", params);
        } catch (Exception e) {
            logger.error("사용자별 문의 목록 조회 오류 : {}", e.getMessage(), e);
        }

        return result;
    }
}