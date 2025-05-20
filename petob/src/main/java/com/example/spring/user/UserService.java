package com.example.spring.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * 사용자 관련 비즈니스 로직을 처리하는 서비스 클래스
 * - 회원 가입 시 비밀번호 암호화 처리 포함
 */
@Service
public class UserService {

    @Autowired
    private UserDao userDao; // DB 처리 담당

    @Autowired
    private PasswordEncoder passwordEncoder; // 비밀번호 암호화 도구 (BCrypt 등)

    /**
     * 사용자 등록 처리
     * - 사용자의 비밀번호를 암호화한 후 DB에 저장
     *
     * @param user 사용자가 입력한 회원가입 정보 (UserDto)
     * @return 등록 성공 여부 (true: 성공, false: 실패)
     */
    public boolean create(UserDto user) {
        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword); // 암호화된 비밀번호로 설정

        // 사용자 DB 등록
        int result = userDao.create(user);
        return result > 0;
    }

    /**
     * 사용자 단건 조회
     * - userId, username, phone, email 등의 조건을 담은 UserDto를 기준으로 사용자 정보를 조회함
     * - UserDao.read()를 호출하여 DB에서 사용자 1명을 조회
     *
     * @param userVo 조회 조건이 담긴 UserDto 객체
     * @return 사용자 정보(UserDto), 없으면 null 반환
     */
    public UserDto read(UserDto userVo) {
        return userDao.read(userVo);
    }

        /**
     * 사용자 정보 수정
     * - 전달된 정보 중 비밀번호가 비어있지 않으면 암호화하여 반영
     * - 그 외 항목(username, phone, email)은 그대로 수정
     *
     * @param user 수정할 사용자 정보(UserDto)
     * @return 수정 성공 여부 (true: 성공, false: 실패)
     */
    public boolean update(UserDto user) {
        // 비밀번호가 비어 있지 않은 경우에만 암호화 처리
        if (!user.getPassword().isEmpty()) {
            String encodedPassword = passwordEncoder.encode(user.getPassword());
            user.setPassword(encodedPassword);
        }

        // DAO를 통해 DB에 사용자 정보 수정 요청
        int result = userDao.update(user);

        // 수정된 행이 1건 이상이면 성공
        return result > 0;
    }
}
