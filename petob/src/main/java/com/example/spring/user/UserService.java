package com.example.spring.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);

    public boolean create(UserDto user) {
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        int result = userDao.create(user);
        return result > 0;
    }

    public UserDto read(UserDto userVo) {
        return userDao.read(userVo);
    }

    @Transactional
    public boolean updateUserProfile(UserDto user) {
        UserDto userToUpdate = new UserDto();
        userToUpdate.setUserId(user.getUserId());
        userToUpdate.setUsername(user.getUsername());
        userToUpdate.setPhone(user.getPhone());
        userToUpdate.setEmail(user.getEmail());

        int result = userDao.update(userToUpdate);
        if (result > 0) {
            logger.info("사용자 프로필 업데이트 성공: userId={}", user.getUserId());
            return true;
        }
        logger.warn("사용자 프로필 업데이트 실패: userId={}", user.getUserId());
        return false;
    }

    @Transactional
    public int updatePassword(String userId, String currentPassword, String newPassword) {
        String hashedPasswordFromDb = userDao.selectPasswordByUserId(userId);

        if (hashedPasswordFromDb == null) {
            logger.warn("비밀번호 변경 실패: 사용자 정보를 찾을 수 없음. userId={}", userId);
            return 2;
        }

        if (!passwordEncoder.matches(currentPassword, hashedPasswordFromDb)) {
            logger.warn("비밀번호 변경 실패: 현재 비밀번호 불일치. userId={}", userId);
            return 1;
        }

        UserDto userToUpdate = new UserDto();
        userToUpdate.setUserId(userId);
        userToUpdate.setPassword(passwordEncoder.encode(newPassword));

        int result = userDao.update(userToUpdate);
        if (result > 0) {
            logger.info("비밀번호 변경 성공: userId={}", userId);
            return 0;
        }
        logger.error("비밀번호 변경 DB 업데이트 실패: userId={}", userId);
        return 2;
    }

    public boolean checkPassword(String userId, String password) {
        String hashedPassword = userDao.selectPasswordByUserId(userId);
        if (hashedPassword != null && passwordEncoder.matches(password, hashedPassword)) {
            return true;
        }
        logger.debug("비밀번호 확인 실패: userId={}", userId);
        return false;
    }

    @Transactional
    public int deleteUser(String userId, String password) {
        if (!checkPassword(userId, password)) {
            logger.warn("회원 탈퇴 실패: 비밀번호 불일치. userId={}", userId);
            return 1;
        }

        int result = userDao.delete(userId);
        if (result > 0) {
            logger.info("회원 탈퇴 성공: userId={}", userId);
            return 0;
        }
        logger.error("회원 탈퇴 DB 삭제 실패: userId={}", userId);
        return 2;
    }

    // --- 아래 메서드를 추가하거나, 주석 처리된 기존 update 메서드를 활용하세요 ---
    /**
     * 사용자 비밀번호를 초기화하는 메서드입니다.
     * (AuthController의 resetPasswordPost에서 사용)
     * 
     * @param userId               사용자 ID
     * @param newPlainTextPassword 암호화되지 않은 새 비밀번호
     * @return 성공 여부
     */
    @Transactional
    public boolean resetUserPassword(String userId, String newPlainTextPassword) {
        if (newPlainTextPassword == null || newPlainTextPassword.isEmpty()) {
            logger.warn("비밀번호 초기화 시도 중 새 비밀번호가 비어있습니다. userId={}", userId);
            return false;
        }
        UserDto userToUpdate = new UserDto();
        userToUpdate.setUserId(userId);
        userToUpdate.setPassword(passwordEncoder.encode(newPlainTextPassword)); // 새 비밀번호 암호화

        // userDao.update는 UserDto를 받아 적절한 필드(여기서는 password)를 업데이트해야 합니다.
        // userMapper.xml의 update 구문이 password 필드가 존재할 경우 업데이트하도록 되어 있는지 확인 필요합니다.
        // (제공해주신 userMapper.xml에는 해당 로직이 이미 있습니다.)
        int result = userDao.update(userToUpdate);
        if (result > 0) {
            logger.info("사용자 비밀번호 초기화 성공: userId={}", userId);
            return true;
        }
        logger.error("사용자 비밀번호 초기화 DB 업데이트 실패: userId={}", userId);
        return false;
    }

    /*
     * // 또는, 기존에 주석 처리되었던 일반 update 메서드를 사용하고 싶다면 주석을 해제하고 사용합니다.
     * // 이 경우 AuthController에서는 resetUserPassword 대신 이 update 메서드를 호출해야 합니다.
     * // (newPlainTextPassword를 UserDto에 설정한 후 이 메서드 호출)
     * 
     * @Transactional
     * public boolean update(UserDto user) {
     * // 비밀번호가 비어 있지 않은 경우에만 암호화 처리
     * if (user.getPassword() != null && !user.getPassword().isEmpty()) {
     * String encodedPassword = passwordEncoder.encode(user.getPassword());
     * user.setPassword(encodedPassword);
     * } else {
     * // 비밀번호 변경 의도가 없다면, 이 필드는 null로 두어 mapper에서 업데이트하지 않도록 합니다.
     * user.setPassword(null);
     * }
     * int result = userDao.update(user);
     * return result > 0;
     * }
     */
}