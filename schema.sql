-- =================================================================
--  데이터베이스 초기화 스크립트 (schema.sql)
-- =================================================================

-- 만약 기존에 'spring' 데이터베이스가 있다면 삭제합니다.
DROP DATABASE IF EXISTS spring;

-- 'spring' 데이터베이스를 생성하고, 기본 문자 세트를 utf8mb4로 지정합니다. (한글, 이모지 지원)
CREATE DATABASE spring CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER 'spring'@'localhost' IDENTIFIED BY '1234';

GRANT ALL PRIVILEGES ON spring.* TO 'spring'@'localhost';

FLUSH PRIVILEGES;

-- 'spring' 데이터베이스를 사용합니다.
USE spring;

-- -----------------------------------------------------
-- Table `users` (회원 DB)
-- -----------------------------------------------------

CREATE TABLE `users` (
	`USER_ID` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`PASSWORD` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`USERNAME` VARCHAR(10) NOT NULL COLLATE 'utf8mb4_general_ci',
	`PHONE` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci',
	`EMAIL` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`ROLE` VARCHAR(5) NULL DEFAULT 'USER' COLLATE 'utf8mb4_general_ci',
	`CREATED_AT` DATETIME NULL DEFAULT current_timestamp(),
	`UPDATED_AT` DATETIME NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`USER_ID`) USING BTREE
)
COMMENT='회원 관리 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

-- -----------------------------------------------------
-- Table `inquiry` (문의 게시판 DB)
-- -----------------------------------------------------

CREATE TABLE `inquiry` (
	`inquiry_id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '문의 고유번호',
	`user_id` VARCHAR(20) NOT NULL COMMENT '작성자 ID' COLLATE 'utf8mb4_general_ci', -- VARCHAR(20)으로 수정
	`username` VARCHAR(100) NOT NULL COMMENT '작성자 이름' COLLATE 'utf8mb4_unicode_ci',
	`category` VARCHAR(20) NOT NULL COMMENT '문의 카테고리' COLLATE 'utf8mb4_unicode_ci',
	`title` VARCHAR(200) NOT NULL COMMENT '문의 제목' COLLATE 'utf8mb4_unicode_ci',
	`content` LONGTEXT NOT NULL COMMENT '문의 내용' COLLATE 'utf8mb4_unicode_ci',
	`email` VARCHAR(100) NULL DEFAULT NULL COMMENT '답변받을 이메일' COLLATE 'utf8mb4_unicode_ci',
	`is_secret` TINYINT(1) NULL DEFAULT '0' COMMENT '비밀글 여부 (0:공개, 1:비밀)',
	`status` VARCHAR(20) NULL DEFAULT 'WAITING' COMMENT '처리상태 (WAITING, PROCESSING, COMPLETED, CLOSED)' COLLATE 'utf8mb4_unicode_ci',
	`reply_content` LONGTEXT NULL DEFAULT NULL COMMENT '관리자 답변' COLLATE 'utf8mb4_unicode_ci',
	`reply_by` VARCHAR(50) NULL DEFAULT NULL COMMENT '답변자 ID' COLLATE 'utf8mb4_unicode_ci',
	`reply_date` DATETIME NULL DEFAULT NULL COMMENT '답변일시',
	`created_date` DATETIME NULL DEFAULT current_timestamp() COMMENT '작성일시',
	`updated_date` DATETIME NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정일시',
	PRIMARY KEY (`inquiry_id`) USING BTREE,
	INDEX `idx_user_id` (`user_id`) USING BTREE,
	INDEX `idx_category` (`category`) USING BTREE,
	INDEX `idx_status` (`status`) USING BTREE,
	INDEX `idx_created_date` (`created_date`) USING BTREE,
    CONSTRAINT `fk_inquiry_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`USER_ID`) ON DELETE CASCADE -- FOREIGN KEY 제약 조건 추가
)
COMMENT='문의 게시판 테이블'
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
AUTO_INCREMENT=5
;

-- -----------------------------------------------------
-- Table `notice` (공지사항 DB)
-- -----------------------------------------------------

CREATE TABLE `notice` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(255) NOT NULL COMMENT '제목' COLLATE 'utf8mb4_unicode_ci',
	`content` TEXT NOT NULL COMMENT '내용' COLLATE 'utf8mb4_unicode_ci',
	`author` VARCHAR(100) NOT NULL DEFAULT '관리자' COMMENT '작성자' COLLATE 'utf8mb4_unicode_ci',
	`created_date` DATETIME NOT NULL DEFAULT current_timestamp() COMMENT '작성일',
	`updated_date` DATETIME NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정일',
	PRIMARY KEY (`id`) USING BTREE
)
COMMENT='공지사항'
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
AUTO_INCREMENT=7
;

-- -----------------------------------------------------
-- Table `obituary` (부고장 DB)
-- -----------------------------------------------------

CREATE TABLE `obituary` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`pet_name` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`passed_date` DATE NULL DEFAULT NULL,
	`message` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`photo_path` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` DATETIME NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=3
;

-- -----------------------------------------------------
-- Table `obreserve` (장례 예약 DB)
-- -----------------------------------------------------

CREATE TABLE `obreserve` (
	`reservation_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '예약 고유 ID',
	`branch` VARCHAR(50) NOT NULL COMMENT '지점명 (main, hongdae, seodaemun 등)' COLLATE 'utf8mb4_general_ci',
	`pet_name` VARCHAR(100) NOT NULL COMMENT '반려동물 이름' COLLATE 'utf8mb4_general_ci',
	`pet_weight` DECIMAL(5,1) NULL DEFAULT NULL COMMENT '반려동물 체중 (kg, 예: 5.3)',
	`applicant_name` VARCHAR(100) NOT NULL COMMENT '보호자(신청자) 성함' COLLATE 'utf8mb4_general_ci',
	`applicant_phone` VARCHAR(20) NOT NULL COMMENT '신청자 전화번호' COLLATE 'utf8mb4_general_ci',
	`ob_date` VARCHAR(20) NOT NULL COMMENT '장례 희망 날짜 (YYYY-MM-DD)' COLLATE 'utf8mb4_general_ci',
	`ob_time` VARCHAR(20) NOT NULL COMMENT '장례 희망 시간 (HH:MM)' COLLATE 'utf8mb4_general_ci',
	`notes` TEXT NULL DEFAULT NULL COMMENT '기타 요청사항' COLLATE 'utf8mb4_general_ci',
	`user_id` VARCHAR(20) NOT NULL COMMENT '로그인 사용자 ID (FK)' COLLATE 'utf8mb4_general_ci', -- VARCHAR(20)으로 수정
	`created_at` TIMESTAMP NULL DEFAULT current_timestamp() COMMENT '예약 생성 시간',
	`status` VARCHAR(20) NOT NULL DEFAULT '신청대기중' COMMENT '예약 상태 (신청대기중, 수락, 거절)' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`reservation_id`) USING BTREE,
	INDEX `fk_obreserve_login_user_id` (`user_id`) USING BTREE,
	CONSTRAINT `fk_obreserve_login_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`USER_ID`) ON UPDATE RESTRICT ON DELETE CASCADE
)
COMMENT='장례 예약 정보 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=5
;

-- -----------------------------------------------------
-- Table `reservation` (간편 상담 예약 DB)
-- -----------------------------------------------------

CREATE TABLE `reservations` (
	`reservation_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(100) NOT NULL COMMENT '예약자 이름' COLLATE 'utf8mb4_general_ci',
	`phone` VARCHAR(20) NOT NULL COMMENT '전화번호' COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(100) NOT NULL COMMENT '이메일' COLLATE 'utf8mb4_general_ci',
	`date` DATE NOT NULL COMMENT '예약 날짜',
	`time` VARCHAR(10) NOT NULL COMMENT '예약 시간' COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NULL DEFAULT current_timestamp() COMMENT '등록일시',
	PRIMARY KEY (`reservation_id`) USING BTREE
)
COMMENT='상담 예약 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=2
;

-- -----------------------------------------------------
-- Table `reviews` (커뮤니티 - 장례 후기 게시판 DB)
-- -----------------------------------------------------

CREATE TABLE `reviews` (
	`ID` INT(11) NOT NULL AUTO_INCREMENT,
	`REVIEW_TITLE` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`REVIEW_CONTENT` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`USER_ID` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci', -- VARCHAR(20)으로 수정
	`FUNERAL_DATE` DATE NULL DEFAULT NULL,
	`LOCATION` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`FILE_NAME` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`ORIGINAL_FILE_NAME` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`CREATED_AT` DATETIME NULL DEFAULT current_timestamp(),
	`UPDATED_AT` DATETIME NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`ID`) USING BTREE,
	INDEX `USER_ID` (`USER_ID`) USING BTREE,
	CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`) ON UPDATE CASCADE ON DELETE SET NULL
)
COMMENT='장례 후기 테이블'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=4
;

-- -----------------------------------------------------
-- Table `short_reviews` (커뮤니티 - 한 마디 남기기 댓글창 DB)
-- -----------------------------------------------------

CREATE TABLE `short_reviews` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`user_id` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_general_ci', -- VARCHAR(20)으로 수정
	`content` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`created_at` TIMESTAMP NULL DEFAULT current_timestamp(),
	`updated_at` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `idx_short_reviews_user_id` (`user_id`) USING BTREE,
	CONSTRAINT `fk_short_review_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`USER_ID`) ON UPDATE RESTRICT ON DELETE CASCADE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=6
;
