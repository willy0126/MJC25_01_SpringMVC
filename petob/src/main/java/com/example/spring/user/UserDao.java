package com.example.spring.user;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

/**
 * 사용자 관련 데이터베이스 작업을 처리하는 DAO 클래스
 * - 회원 가입, 사용자 정보 조회 등을 수행
 */
@Repository
public class UserDao {

    @Autowired
    private SqlSession sqlSession; // MyBatis SQL 세션

    private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

    /**
     * 사용자 등록
     * - MyBatis 매퍼(userMapper.create)를 호출하여 USERS 테이블에 사용자 정보를 삽입
     * 
     * @param user 가입할 사용자 정보(UserDto)
     * @return 삽입 성공 시 1, 실패 시 -1
     */
    public int create(UserDto user) {
        int result = -1;

        try {
            result = sqlSession.insert("userMapper.create", user);
        } catch (DataAccessException e) {
            logger.error("사용자 등록 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

      /**
     * 사용자 단건 조회
     * - 주어진 조건(userId, username, phone, email 중 일부 또는 전부)에 해당하는 사용자 1명 조회
     * - userMapper.xml의 <select id="read"> 쿼리를 실행함
     *
     * @param user 조회 조건이 담긴 UserDto 객체
     * @return 조회된 사용자 정보(UserDto), 없을 경우 null 반환
     */
    public UserDto read(UserDto user) {
        UserDto result = null;

        try {
            // MyBatis 매퍼 호출 (조건은 userDto 객체에 포함된 필드 기준으로 동적 적용됨)
            result = sqlSession.selectOne("userMapper.read", user);
        } catch (Exception e) {
            logger.error("사용자 조회 오류 : {}", e.getMessage(), e);
        }

        return result;
    }

     /**
     * 사용자 정보 수정
     * - 전달받은 UserDto의 필드 중 null이 아닌 값만 DB에 반영
     * - userMapper.xml의 <update id="update"> 쿼리를 호출
     *
     * @param user 수정할 사용자 정보가 담긴 UserDto 객체
     * @return 수정된 행 수 (성공 시 1, 실패 시 0 또는 -1)
     */
    public int update(UserDto user) {
        int result = -1;

        try {
            result = sqlSession.update("userMapper.update", user);
        } catch (DataAccessException e) {
            logger.error("사용자 수정 오류 : {}", e.getMessage(), e);
        }

        return result;
    }
}
