<div align=center>
<img src = "https://github.com/user-attachments/assets/9843c825-c481-4a17-a202-50b233532d76" width="35%" height="35%">


![Star's Haven Header](https://capsule-render.vercel.app/api?type=waving&color=2F3B4C&height=220&section=header&text=Star's%20Haven&desc=반려동물%20장례식장%20웹사이트&descAlignY=60&fontSize=50&fontColor=ffffff&fontAlignY=35&animation=fadeIn)
### 2025 MJC 웹프로그래밍실습 팀프로젝트

</div>

  
<br>

## 📜 0. 목차
1. [프로젝트 소개](#1)
2. [팀원 소개](#2)
3. [개발 일정](#3)
4. [기술 스택](#4)
5. [브랜치 및 디렉토리 구조](#5)
6. [주요 기능 소개](#6)
7. [상세 담당 업무](#7)
8. [주요 기술 구현 및 도전 과제](#8)
9. [트러블 슈팅](#9)
10. [개선 목표](#10)
11. [프로젝트 후기](#11)

<br>

## ❗필독해야 할 사전 구성 내용 
<br>

### 1. 🚀 jQuery Validate
<br>
기본적으로 register.jsp 에서 jQuery Validate 설정 부분 중 116번째, 165번째 line의 noAdmin을 주석처리 해두었습니다.<br>
admin 계정을 생성한 후 해당 주석을 제거하면 정상적으로 admin 가입 방지용 유효성 검사가 작동합니다.

<br><br> 
<b>사이트 테스트용으로 생성하는 admin 계정 정보</b>
<br><br>
ID: admin
<br>
PW: admin000
<br><br>

관리자 Console이 구현되어 있기 때문에 필요한 내용으로 사전에 공지합니다.
<br><br>

### 2. 🚀 Schema.sql 파일
<br>
프로젝트 루트 폴더에 있는 Schema.sql 파일 쿼리문을 전체 복사하여 붙여넣고 실행하여야 합니다.
<br><br>

### 3. 🚀 프로젝트 실행 가이드

이 프로젝트를 로컬 환경에서 실행하기 위해서는 데이터베이스 설정이 필요합니다.

#### 3-1. 데이터베이스 설정

-   **데이터베이스 종류:** MariaDB
-   **데이터베이스 이름:** `spring`
-   **사용자 이름:** `spring`
-   **비밀번호:** `1234`
-   **port:** `3308`

#### 3-2. Spring 설정 파일 수정

`src/main/webapp/WEB-INF/spring/db-context.xml` 파일을 열어 아래와 같이 본인의 데이터베이스 환경에 맞게 수정해 주세요.

```xml
<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource">
    <property name="driverClassName" value="org.mariadb.jdbc.Driver"/>
    <property name="jdbcUrl" value="jdbc:mariadb://127.0.0.1:3308/[데이터베이스 이름]"/>
    <property name="username" value="[사용자 이름]"/>
    <property name="password" value="[비밀번호]"/>
    <property name="maximumPoolSize" value="10"/>
    <property name="minimumIdle" value="5"/>
</bean>
```
<br><br>

## 📝 <span id=1> 1. 프로젝트 소개</span>

주어진 '반려동물 관련' 이라는 조건 속에서, 기존과는 다른 특별하고 의미 있는 주제로 하자는 목표로 여러 방향을 탐구하였습니다.
<br>최종적으로 고민 끝에 <b>"반려동물 장례식장"</b> 이라는 주제를 선정하여 프로젝트를 시작하게 되었습니다.
<br><br>아래는 웹사이트 제작을 하게된 이유에 대해 간략히 기술합니다.
<br><br>
* 반려동물 수 증가에 따라 관련 서비스 수요가 늘고 있음.

  
* 반려동물 장례에 관한 정보는 여전히 부족하며, 사용자 중심의 맞춤 서비스가 필요하다고 판단함.

  
* 구현 단계에서 사용자 경험(UX) 향상을 최우선 가치로 두어, 직관적이고 쾌적한 사이트를 제공하는 데 포커스를 맞춤.

  
* 실생활에 밀접한 프로젝트이며, 기술적인 측면에서도 프로젝트를 통해 비동기 통신, QR 생성, API 활용, 챗봇 구현.. 등<br>
다양한 기술 통합 및 구현을 시도해볼 수 있음.


<br><br>

## 🙋‍♂️ <span id=2>  2. 팀원 소개</span>

|학번|이름|개발|
|:------:|:---:|:---:|
|2020261041|<a href="https://github.com/willy0126" target="_blank" rel="noopener noreferrer">박지원</a>|총괄, Front-End|
|2020261074|<a href="https://github.com/AnByoungJun0605" target="_blank" rel="noopener noreferrer">안병준</a>|Front-End|
|2021261037|<a href="https://github.com/Asj-Cell" target="_blank" rel="noopener noreferrer">안성준</a>|Back-End|
|2022261067|<a href="https://github.com/chltj" target="_blank" rel="noopener noreferrer">최서연</a>|Front-End|


<br><br>

## ⌛ <span id=3> 3. 개발 일정</span>

> 계획 수립 : 2025.04.15 ~ 2025.04.28 <프로세스 흐름도 및 기능 명세서 작성, Figma 디자인 수립>

> 개발 기간 : 2025.04.29 ~ 2025.06.09

<br><br>

## 🛠️ <span id=4> 4. 기술 스택</span>

🖥️ Front-end

* HTML5: 웹 페이지 기본 구조 구성
  
* CSS3: 웹 페이지의 디자인 및 레이아웃 스타일링
  * Bootstrap 5.3.3: 반응형 웹 디자인 및 UI 컴포넌트(Carousel, Modal...etc)
    
* JavaScript (ES6+): 동적인 화면 구성, 사용자 인터랙션 처리, Ajax 통신.. 등
  * jQuery: JavaScript 오픈 소스 기반 라이브러리
  * Naver Maps API v3: 지점 위치 안내 페이지에서 지도 표시 및 마커 기능 추가
    
* JSP: SSR(Server-Side Rendering)을 통해 동적인 웹 페이지 생성
* JSTL: JSP 내 조건문, 반복문 로직 처리

<br>

⚙️ Back-end

* Java 8: 해당 프로젝트에서 주 개발 언어로 사용

* Spring Framework (v5.3.39): 애플리케이션의 핵심 프레임워크로 사용
  * Spring MVC: 웹 계층의 MVC 패턴 구현
  * Spring Context: IoC 컨테이너 및 DI 기능 제공
  * Spring JDBC: 데이터베이스 연동을 위한 기본 기능 제공(MyBatis와 함께 사용)
 
* Spring Security (Crypto v5.8.11): 사용자 비밀번호 암호화를 위해 BcryptPasswordEncoder를 사용

* SLF4J (v1.7.36) & Log4j2 (v2.20.0): 로깅 인터페이스 및 구현체로 사용

<br>

🗄️ Database

* MariaDB (w. HeidiSQL): 주 데이터베이스 시스템으로 사용

* MyBatis (v3.5.13) & MyBatis-Spring (v2.1.1): SQL Mapper 프레임워크로, XML 파일에 SQL 쿼리를 작성하여 데이터베이스와 상호작용

* HikariCP (v4.0.3): 고성능 JDBC 커넥션 풀 라이브러리로 사용

<br>

🚀 Build & Deployment

* Apache Maven: 프로젝트 빌드 및 의존성 관리를 위해 사용
  
* Apache Tomcat: WAR 파일로 패키징, Tomcat WAS(Web Application Server)에 배포

* WAR (Web Application Archive): 최종 배포 파일 형식

<br><br>

## 🗂️ <span id="5"> 5. 브랜치 및 디렉토리 구조</span>

> 브랜치

- 'main' : 프로젝트 진행 중 항상 최신 상태로 유지하며, Stable 상태로 배포되어 바로 사용 가능한 브랜치입니다.

- 'jiwon', 'byoungjun', 'ASJ', 'seoyeon' : 개발 팀원들의 브랜치입니다.<br>각자가 맡은 기능 Test가 해당 각 브랜치에서 진행되며, 최종 Stable 버전을 Merge하여 main 브랜치에 푸시합니다.

<br>

> 디렉토리 구조

<br>

<details>
<summary>📂 전체 프로젝트 구조 보기 (클릭하여 펼치기)</summary>

```text
📦main
 ┣ 📂java
 ┃ ┗ 📂com
 ┃ ┃ ┗ 📂example
 ┃ ┃ ┃ ┗ 📂spring
 ┃ ┃ ┃ ┃ ┣ 📂adminconsole
 ┃ ┃ ┃ ┃ ┃ ┣ 📜adminconsoleController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜adminconsoleDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜adminconsoleDto.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜adminconsoleService.java
 ┃ ┃ ┃ ┃ ┣ 📂FuneralReview
 ┃ ┃ ┃ ┃ ┃ ┣ 📜FuneralReviewController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜FuneralReviewDAO.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜FuneralReviewDTO.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜FuneralReviewService.java
 ┃ ┃ ┃ ┃ ┣ 📂inquiry
 ┃ ┃ ┃ ┃ ┃ ┣ 📜InquiryController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜InquiryDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜InquiryDto.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜inquiryMapper.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜InquiryService.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜InquiryServiceImpl.java
 ┃ ┃ ┃ ┃ ┣ 📂interceptor
 ┃ ┃ ┃ ┃ ┃ ┗ 📜AuthInterceptor.java
 ┃ ┃ ┃ ┃ ┣ 📂libs
 ┃ ┃ ┃ ┃ ┃ ┗ 📜Pagination.java
 ┃ ┃ ┃ ┃ ┣ 📂mypage
 ┃ ┃ ┃ ┃ ┃ ┣ 📜mypageController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜mypageDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜mypageDto.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜mypageService.java
 ┃ ┃ ┃ ┃ ┣ 📂notice
 ┃ ┃ ┃ ┃ ┃ ┣ 📜NoticeController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜NoticeDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜NoticeDto.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜NoticeService.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜NoticeServiceImpl.java
 ┃ ┃ ┃ ┃ ┣ 📂obituary
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ObituaryController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ObituaryDto.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ObituaryMapper.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜ObituaryService.java
 ┃ ┃ ┃ ┃ ┣ 📂ObituaryReservation
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ObituaryReservationController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ObituaryReservationDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ObituaryReservationDto.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜ObituaryReservationService.java
 ┃ ┃ ┃ ┃ ┣ 📂reservation
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ReservationController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ReservationDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜ReservationDto.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜ReservationService.java
 ┃ ┃ ┃ ┃ ┣ 📂shortreview
 ┃ ┃ ┃ ┃ ┃ ┣ 📜shortreviewController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜shortreviewDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜shortreviewDto.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜shortreviewService.java
 ┃ ┃ ┃ ┃ ┣ 📂user
 ┃ ┃ ┃ ┃ ┃ ┣ 📜AuthController.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜UserDao.java
 ┃ ┃ ┃ ┃ ┃ ┣ 📜UserDto.java
 ┃ ┃ ┃ ┃ ┃ ┗ 📜UserService.java
 ┃ ┃ ┃ ┃ ┣ 📜BranchController.java
 ┃ ┃ ┃ ┃ ┣ 📜CSController.java
 ┃ ┃ ┃ ┃ ┣ 📜InfoController.java
 ┃ ┃ ┃ ┃ ┣ 📜LocationController.java
 ┃ ┃ ┃ ┃ ┣ 📜MainController.java
 ┃ ┃ ┃ ┃ ┗ 📜PolicyController.java
 ┣ 📂resources
 ┃ ┣ 📂mapper
 ┃ ┃ ┣ 📜adminconsoleMapper.xml
 ┃ ┃ ┣ 📜FuneralReviewMapper.xml
 ┃ ┃ ┣ 📜inquiryMapper.xml
 ┃ ┃ ┣ 📜mypageMapper.xml
 ┃ ┃ ┣ 📜NoticeMapper.xml
 ┃ ┃ ┣ 📜ObituaryReservationMapper.xml
 ┃ ┃ ┣ 📜ReservationMapper.xml
 ┃ ┃ ┣ 📜shortreviewMapper.xml
 ┃ ┃ ┗ 📜userMapper.xml
 ┃ ┣ 📜log4j2.xml
 ┃ ┗ 📜mybatis-config.xml
 ┗ 📂webapp
 ┃ ┣ 📂resources
 ┃ ┃ ┣ 📂css
 ┃ ┃ ┃ ┣ 📂inquiry
 ┃ ┃ ┃ ┃ ┣ 📜inquirystyle.css
 ┃ ┃ ┃ ┃ ┣ 📜viewstyle.css
 ┃ ┃ ┃ ┃ ┗ 📜writestyle.css
 ┃ ┃ ┃ ┣ 📂notice
 ┃ ┃ ┃ ┃ ┣ 📜noticestyle.css
 ┃ ┃ ┃ ┃ ┗ 📜writestylr.css
 ┃ ┃ ┃ ┣ 📜adminconsolestyle.css
 ┃ ┃ ┃ ┣ 📜branchstyle.css
 ┃ ┃ ┃ ┣ 📜checkstyle.css
 ┃ ┃ ┃ ┣ 📜csstyle.css
 ┃ ┃ ┃ ┣ 📜infostyle.css
 ┃ ┃ ┃ ┣ 📜locationstyle.css
 ┃ ┃ ┃ ┣ 📜loginstyle.css
 ┃ ┃ ┃ ┣ 📜mainstyle.css
 ┃ ┃ ┃ ┣ 📜mypagestyle.css
 ┃ ┃ ┃ ┣ 📜obituaryreservationstyle.css
 ┃ ┃ ┃ ┣ 📜obituarystyle.css
 ┃ ┃ ┃ ┣ 📜policystyle.css
 ┃ ┃ ┃ ┣ 📜reservationstyle.css
 ┃ ┃ ┃ ┗ 📜style.css
 ┃ ┃ ┣ 📂img
 ┃ ┃ ┃ ┣ 📜carousel1.jpg
 ┃ ┃ ┃ ┣ 📜carousel2.jpg
 ┃ ┃ ┃ ┣ 📜carousel3.jpg
 ┃ ┃ ┃ ┣ 📜chatbot.png
 ┃ ┃ ┃ ┣ 📜favicon-32x32.png
 ┃ ┃ ┃ ┣ 📜inquiry.jpg
 ┃ ┃ ┃ ┣ 📜license_sample.png
 ┃ ┃ ┃ ┣ 📜logo.png
 ┃ ┃ ┃ ┣ 📜mainbranchimg.jpg
 ┃ ┃ ┃ ┣ 📜mainbranchimg2.jpg
 ┃ ┃ ┃ ┣ 📜mainbranchimg3.jpg
 ┃ ┃ ┃ ┣ 📜mainbranchimg4.png
 ┃ ┃ ┃ ┣ 📜maincontent1.jpg
 ┃ ┃ ┃ ┣ 📜maincontent2.jpg
 ┃ ┃ ┃ ┣ 📜service_item01.png
 ┃ ┃ ┃ ┣ 📜service_item02.png
 ┃ ┃ ┃ ┣ 📜service_item03.png
 ┃ ┃ ┃ ┣ 📜service_item04.png
 ┃ ┃ ┃ ┣ 📜service_item05.png
 ┃ ┃ ┃ ┣ 📜service_item06.png
 ┃ ┃ ┃ ┣ 📜subbranch1img.png
 ┃ ┃ ┃ ┣ 📜subbranch1img2.png
 ┃ ┃ ┃ ┣ 📜subbranch1img3.png
 ┃ ┃ ┃ ┗ 📜subbranch1img4.png
 ┃ ┃ ┣ 📂js
 ┃ ┃ ┃ ┗ 📜app.js
 ┃ ┃ ┗ 📂uploads
 ┃ ┃ ┃ ┣ 📜12d99c85-92c1-4429-8890-327bc13179d7_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜18d99095-f0cf-4064-8858-b296dcd0e362_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜1fae1d9d-3770-4e2a-9690-6eb0e475eacb_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜36f68ca3-36e2-49c3-b7af-4a2c495463e5_강아지2.jpeg
 ┃ ┃ ┃ ┣ 📜43e72b96-2d52-466f-8630-b3b2749d3bf9_강아지2.jpeg
 ┃ ┃ ┃ ┣ 📜4c616527-8352-4ea2-9689-d08402967d71_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜5632f4fd-8d8c-4e2a-ab8d-50de52d86451_dog2.jpg
 ┃ ┃ ┃ ┣ 📜8d8476e2-da62-49a5-b31f-98b775a2c49c_강아지2.jpeg
 ┃ ┃ ┃ ┣ 📜9f3b9e43-cd2f-4118-80fc-cc751bd788ba_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜a80d05c5-20d5-408e-a7b6-613d912e93f9_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜bc0ba8f8-ba70-49cd-97c5-4d92fa85fdb1_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜c6140bf2-49a2-40db-b14d-d6d9b8782eaa_qrcode.png
 ┃ ┃ ┃ ┣ 📜d5f92ca5-04c7-4d7b-b3e0-c5dd5660c4c2_강아지1.jpeg
 ┃ ┃ ┃ ┣ 📜e4930ee4-f91c-4946-bdad-e7215ca3c493_강아지1.jpeg
 ┃ ┃ ┃ ┗ 📜ffb6eb44-a493-4f24-a913-aa24e603a700_강아지1.jpeg
 ┃ ┗ 📂WEB-INF
 ┃ ┃ ┣ 📂spring
 ┃ ┃ ┃ ┣ 📂appServlet
 ┃ ┃ ┃ ┃ ┗ 📜servlet-context.xml
 ┃ ┃ ┃ ┣ 📜db-context.xml
 ┃ ┃ ┃ ┗ 📜root-context.xml
 ┃ ┃ ┣ 📂views
 ┃ ┃ ┃ ┣ 📂common
 ┃ ┃ ┃ ┃ ┣ 📜footer.jsp
 ┃ ┃ ┃ ┃ ┣ 📜head.jsp
 ┃ ┃ ┃ ┃ ┣ 📜message.jsp
 ┃ ┃ ┃ ┃ ┣ 📜navbar.jsp
 ┃ ┃ ┃ ┃ ┣ 📜script.jsp
 ┃ ┃ ┃ ┃ ┗ 📜title.jsp
 ┃ ┃ ┃ ┗ 📂pages
 ┃ ┃ ┃ ┃ ┣ 📂adminconsole
 ┃ ┃ ┃ ┃ ┃ ┗ 📜adminconsole.jsp
 ┃ ┃ ┃ ┃ ┣ 📂auth
 ┃ ┃ ┃ ┃ ┃ ┣ 📜findUserId.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜login.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜register.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ 📜resetPassword.jsp
 ┃ ┃ ┃ ┃ ┣ 📂funeralReview
 ┃ ┃ ┃ ┃ ┃ ┣ 📜create.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜list.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜read.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ 📜update.jsp
 ┃ ┃ ┃ ┃ ┣ 📂inquiry
 ┃ ┃ ┃ ┃ ┃ ┣ 📜list.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜my-list.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜view.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ 📜write.jsp
 ┃ ┃ ┃ ┃ ┣ 📂mypage
 ┃ ┃ ┃ ┃ ┃ ┣ 📜changePassword.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜confirmPassword.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜editProfile.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜mypage.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ 📜withdraw.jsp
 ┃ ┃ ┃ ┃ ┣ 📂notice
 ┃ ┃ ┃ ┃ ┃ ┣ 📜detail.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ 📜list.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ 📜write.jsp
 ┃ ┃ ┃ ┃ ┣ 📂obituaryreservation
 ┃ ┃ ┃ ┃ ┃ ┗ 📜obituaryreservation.jsp
 ┃ ┃ ┃ ┃ ┣ 📂reservation
 ┃ ┃ ┃ ┃ ┃ ┣ 📜check.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ 📜reservation.jsp
 ┃ ┃ ┃ ┃ ┣ 📂shortreview
 ┃ ┃ ┃ ┃ ┃ ┗ 📜shortreview.jsp
 ┃ ┃ ┃ ┃ ┣ 📜faq.jsp
 ┃ ┃ ┃ ┃ ┣ 📜location.jsp
 ┃ ┃ ┃ ┃ ┣ 📜main.jsp
 ┃ ┃ ┃ ┃ ┣ 📜mainbranch.jsp
 ┃ ┃ ┃ ┃ ┣ 📜obituary.jsp
 ┃ ┃ ┃ ┃ ┣ 📜obituary_result.jsp
 ┃ ┃ ┃ ┃ ┣ 📜privacy.jsp
 ┃ ┃ ┃ ┃ ┣ 📜procedure.jsp
 ┃ ┃ ┃ ┃ ┣ 📜subbranch1.jsp
 ┃ ┃ ┃ ┃ ┣ 📜subbranch2.jsp
 ┃ ┃ ┃ ┃ ┗ 📜terms.jsp
 ┃ ┃ ┗ 📜web.xml
```
</details>

<br><br>


## 💻 <span id="6"> 6. 주요 기능 소개</span>
<br><br>
해당 사이트를 실제로 구동해보기 위한 번거로운 작업(DB 설정, 라이브러리 설치, 서버 설치 및 실행)이 너무나 많기에 사이트 주요 기능들에 대해서<br>gif 형식으로 첨부하여 소개합니다.


#### 1. 로그인 및 회원가입 페이지
![Image](https://github.com/user-attachments/assets/2085b18d-e0e6-4e31-923f-2403cf33f879)
![Image](https://github.com/user-attachments/assets/ce46bbb6-370b-4585-8b27-a59dab9c41f3)
<br><br>

#### 2. 로그인 후 사용자 웰컴 메세지 구현
![Image](https://github.com/user-attachments/assets/cfef4cb7-1d42-4cdb-9dd5-c8d938e62d2e)
<br><br>

#### 3. 메인 페이지 실시간 통계 카운터 기능
![Image](https://github.com/user-attachments/assets/e8038955-fa3c-4216-8b0f-a90c9c2d153a)
<br><br>

#### 4. 동적 시나리오 기반 챗봇 기능
![Image](https://github.com/user-attachments/assets/cd475b94-48b1-45d6-87fe-1a0911beb26d)
<br><br>

#### 5. 이용 안내 - 절차 및 비용 페이지
![Image](https://github.com/user-attachments/assets/9d616ab7-347d-4598-b60f-f67c2bdcd006)
<br><br>

#### 6. 지점 위치 페이지: 네이버 Maps API 사용
![Image](https://github.com/user-attachments/assets/8816c686-bacf-460e-a365-516d56aa2b32)
<br><br>

#### 7. 자주 묻는 질문 (FAQ)
![Image](https://github.com/user-attachments/assets/f4b19410-c799-42cd-b264-25d8807db8ff)
<br><br>

#### 8. 지점 소개 페이지
![Image](https://github.com/user-attachments/assets/9b1b8805-5565-44c3-9f5b-ffefbd02da93)
<br><br>

#### 9. 커뮤니티 - 한 마디 남기기 페이지
![Image](https://github.com/user-attachments/assets/e17be3a0-3ad6-4ed5-aba0-13b4ae8298a9)
<br><br>

#### 10. 어드민 계정 로그인 시
![Image](https://github.com/user-attachments/assets/2aea9a95-9ff4-446f-8fb8-1779ed7a0160)



<br><br>


## 📄 <span id="7"> 7. 상세 담당 업무</span>

#### 1) 박지원 (branch: jiwon)

- **🎨 UI**

  - 페이지: 메인 페이지, 절차 및 비용, 지점 소개, 지점 위치, FAQ, 챗봇, 
 
    
  - 공통 컴포넌트 제작: 사이트 로고 및 파비콘

- **🎯 중점 개발 내용**

  - UI/UX 향상: 사이트 전반에 걸쳐 CSS와 JavaScript를 활용한 동적 Fade-in 애니메이션을 적용하여 사용자 경험을 향상
 
    
  - 외부 API 연동(Naver Maps): 네이버 지도 API 연동으로 지점 위치를 시각적으로 제공함으로 써 직관적인 정보를 제공
 
    
  - 동적 기능 구현(JavaScript): 메인 페이지의 실시간 통계 Counter, FAQ 페이지의 아코디언 UI, 정적 시나리오 기반의 챗봇 구현 등 사용자 인터랙션 기능을 JavaScript로 개발
 

#### 2) 안병준 (branch: byoungjun)

- **🎨 UI**


- **🎯 중점 개발 내용**


#### 3) 안성준 (branch: ASJ)

- **🎨 UI**
  
  - 페이지: 로그인, 회원가입, 마이페이지(개인정보 수정, 비밀번호 변경), 장례 후기 게시판, 각 지점 예약 데이터 연동


  - 공통 컴포넌트 제작: 장례 후기 게시판 사이드바 및 콘텐츠 레이아웃

- **🎯 중점 개발 내용**
  
  - 인증 시스템 구축: Spring Security를 이용하고 BCryptPasswordEncoder를 적용하여 사용자의 비밀번호를 안전하게 암호화, AuthInterceptor를 통해 각 페이지에 대한 접근 권한을 체계적으로 제어하여 보안성을 강화
    
  - RESTful API 설계 및 Ajax 비동기 통신: jQuery와 Ajax를 활용하여 아이디, 이메일, 전화번호 중복 체크 기능을 비동기 방식으로 구현
    
  - 백앤드 연동: MyBatis Mapper와 동적 SQL(`<if>`, `<choose>`)을 사용하여 장례 후기 게시판의 다중 조건 검색(제목, 내용, 작성자 등) 및 페이징 기능을 구현, Spring MVC를 이용하여 CRUD 기능 구현 및 DB 연동
    
#### 4) 최서연 (branch: seoyeon)

- **🎨 UI**

  - 페이지: 공지사항, 문의게시판, 간편상담예약, 조회

  
  - 공통 컴포넌트 제작: 게시판 테이블 스타일링, 폼 디자인, 관리자 컨트롤 패널


- **🎯 중점 개발 내용**

  - UI/UX 향상: 공지사항 및 문의게시판에 반응형 테이블 디자인과 CSS Grid/Flexbox를 활용한 깔끔한 레이아웃 구현으로 가독성 향상

  
  - 백엔드 연동: Spring MVC와 JSP를 활용한 CRUD 기능 구현으로 공지사항 작성/수정/삭제, 문의글 관리, 상담예약 시스템의 완전한 데이터베이스 연동

  
  - 동적 기능 구현(JavaScript): 실시간 폼 유효성 검사, 알림 메시지 자동 페이드아웃 효과, 검색 기능, 관리자 권한별 동적 UI 표시/숨김 등 사용자 인터랙션 기능을 JavaScript로 개발

<br>

## 🚀 <span id="8"> 8. 주요 기술 구현 및 도전 과제</span>
**Spring MVC 아키텍처 구현** 

- Model-View-Controller 패턴을 적용하여 비즈니스 로직, 데이터 처리, 화면 렌더링을 명확히 분리

- @Controller, @Service, @Repository를 통한 계층적 구조 구현

**게시판 기능 구현**

- CRUD(생성, 조회, 수정, 삭제) 기능을 가진 게시판 구현

- JSP 기반의 화면 구성

- MyBatis를 통한 데이터베이스 연동

**MyBatis와 MySQL 연동**

- Mapper XML을 활용한 SQL 정의

- DTO를 통한 데이터 전달 객체 사용

**JSTL 및 EL(Expression Language) 활용**

- c:forEach, c:if 등을 사용하여 동적 JSP 페이지 구현

- 사용자에게 가독성 높은 데이터 제공

**로그인 및 세션 관리**

- 세션 기반 로그인 처리

- 로그인 여부에 따라 접근 제어

**에러 처리 및 유효성 검사**

- 잘못된 입력에 대한 서버 측 유효성 체크

- 예외 발생 시 사용자 친화적 메시지 제공

<br>

## 💥 <span id="9"> 9. 트러블 슈팅</span>

### 1. navbar 배열 문제

![Image](https://github.com/user-attachments/assets/e916c404-bd68-4db6-b9a7-91e53a8825a1)
마이페이지 단에서 ChangePassword.jsp 작업을 하던 도중, navbar의 배열 문제가 있음이 확인되었다.
사소하지만 footer에서도 이용 약관 메뉴와 개인정보 처리방침 버튼이 하이라이트되는 문제도 생겼다.

스타일적으로 어디서부터 건드릴 지 막막했지만 시행착오와 여러 개선작업을 시도해보고 매우 단순하지만 확실한 결론을 도출할 수 있었다.
<br>
아래는 수정에 대한 코드와 추가 설명이다.
<br>

### 💥 기존 코드

![Image](https://github.com/user-attachments/assets/94ad8599-5a30-4026-ab25-bbca62018e1a)

&lt;head&gt; 태그 안의 스타일시트는 기본적으로 위에서부터 아래대로 적용됩니다. 따라서 하나의 요소에 여러 css 파일들 혹은 Framework Style.. 등이 적용되어 있다면 가장 나중에 적용된 스타일이 적용됩니다.
<br><br>
이 문제를 해결하려고 접근할 때 9번째 줄의 Bootstrap Framework Style을 &lt;head&gt; 스타일시트 중 가장 상단에 위치하면 해당 배열 문제와 footer 부분의 문제까지도 해결이 될 것으로 판단하여 아래와 같이 수정하여 적용했습니다.
<br><br>

### 🚀 수정된 코드

![Image](https://github.com/user-attachments/assets/db7747bd-9c2f-4dd4-b369-0e23b17d7f48)

![Image](https://github.com/user-attachments/assets/709bcda2-1596-4409-8d10-53e9842dc4ab)
<br><br>
수정된 코드를 사용하여 페이지를 로드했을 때, 스타일에 문제가 발생하던 부분이 사라진 모습을 확인했다.
<br><br>
<b>이로 인해, 간단한 줄바꿈 만으로도 눈에 띄는 스타일적 변화가 생기는 부분을 해당 트러블슈팅으로 확인하는 계기가 되었다.</b>


<br><br>


### 2. 장례 예약 시간 중복 선택 문제

![Image](https://github.com/user-attachments/assets/bfebf1bc-e9d9-4e97-8fa1-259944467b01)

장례 예약 신청 시, 특정 지점의 특정 날짜에 이미 예약이 신청된 시간이 있더라도 사용자가 해당 시간을 드롭다운 메뉴에서 다시 선택할 수 있는 문제가 발견되었습니다. 서버 측에서 최종 제출을 막더라도, 사용자 경험 측면에서 미리 선택할 수 없도록 비활성화 처리가 필요했습니다.
<br><br>

### 💥 기존 코드

![Image](https://github.com/user-attachments/assets/7ae7f642-e0b7-4b35-8e38-904334b370a3)

최초 원인 분석 시, 예약 데이터를 데이터베이스에 최종 제출할 때 중복을 확인하는 checkDuplicateReservation 쿼리는 수정이 완료된 상태였습니다. 하지만 UI에서 예약된 시간을 비활성화하는 기능이 제대로 동작하지 않아, 근본적인 원인을 다시 파악해야 했습니다.
<br><br>

문제는 날짜를 선택했을 때, 해당 날짜의 예약된 시간 목록을 가져와 UI에 비활성화 처리용 데이터를 전달하는 getBookedTimesByDateAndBranch 쿼리에 있었습니다. 이 쿼리가 예약 상태가 '수락'인 경우만 확인하고, **'신청대기중'**인 예약을 누락하고 있어 UI에 예약된 시간 정보가 제대로 전달되지 않았습니다.

<br>

### 🚀 수정된 코드

![Image](https://github.com/user-attachments/assets/e8e945f2-d9ff-4686-a14e-66bc5c9963fc)

이 문제를 해결하기 위해, getBookedTimesByDateAndBranch 쿼리의 WHERE 절을 수정하여 '수락' 상태와 '신청대기중' 상태를 모두 포함하도록 변경했습니다.
<br><br>

![Image](https://github.com/user-attachments/assets/bb2f6322-8389-43ad-b117-3489878c8c1a)
수정된 코드를 적용하여 페이지를 다시 로드했을 때, '신청대기중' 상태였던 12시 타임이 정상적으로 **'(예약마감)'**으로 표시되며 비활성화된 것을 확인할 수 있었습니다.
<br><br>

<b>이번 트러블슈팅을 통해 서버 측의 데이터 유효성 검증 로직과 사용자에게 보여지는 UI 로직이 항상 동기화되어야 사용자 경험을 해치지 않는다는 점을 명확히 인지하게 되었습니다.</b>

<br><br>

## 💭 <span id="10"> 10. 개선 목표</span>


### 🚀 웹사이트 성능 분석 (Lighthouse Report)

우리 웹사이트의 성능 현황 및 개선점을 요약한 Lighthouse 리포트입니다. (측정일: 2025-06-08 )

### 📊 종합 점수

| Category | Score |
| :--- | :---: |
| 🟠 **Performance** | **81**  |
| 🟢 **Accessibility** | **95**  |
| 🟢 **Best Practices** | **96**  |
| 🟢 **SEO** | **91**  |

### 🔑 주요 현황 및 개선점 분석

* 🟠 **Performance (81점)**: **Largest Contentful Paint (LCP)가 3.3초 **로 로딩 속도 저하의 주요 원인입니다.
    * **이미지 최적화가 필요**합니다:
      
        * 차세대 형식으로 이미지 제공 (절감 예상: **3,228 KiB** )
        * 이미지 크기 적절하게 조정 (절감 예상: **2,913 KiB** )
          
    * **렌더링 차단 리소스** 제거 시 **530ms** 단축이 가능합니다.

* 🟢 **Accessibility (95점)**: 일부 요소의 **색상 명도 대비**가 부족합니다.

* 🟢 **Best Practices (96점)**: 모바일 반응성을 위한 **`<meta name="viewport">` 태그가 누락**되었습니다.

* 🟢 **SEO (91점)**: 검색엔진 노출을 위한 **메타 설명(meta description)이 없습니다**.

### 🎯 개선 필요사항

- [ ] **(중요) LCP 개선**: 이미지 최적화 (WebP 변환, 사이즈 조정)
- [ ] **(중요) `viewport` 메타 태그 추가**: 모바일 반응성 확보
- [ ] **(중요) 렌더링 차단 리소스 제거**: CSS/JS 로딩 방식 개선
- [ ] **(개선) SEO `meta description` 추가**
- [ ] **(개선) 접근성 명도 대비 문제 해결**

<br>

## 🧑‍🤝‍🧑 <span id="11"> 11. 프로젝트 후기</span>
<br>

### 박지원

<br>
페이지를 구성하면서 단순히 화면에 정보를 나열하는 것을 넘어서, CSS와 JavaScript를 적절히 활용하여 Fade-in 효과나 실시간 카운터 등을 추가하여 정적인 사이트에 부드럽고 생동감 있는 효과로 사용자의 시선을 자연스럽게 유도하고 사이트에 대해 긍정적인 첫 인상을 심어주었습니다. 
<br><br>
이러한 동적 기능 구현 경험은 <b>사용자 경험(UX)적 측면</b>에서 생각해보고 한 단계 발전해볼 수 있는 중요한 프로젝트가 됐던 것 같습니다.

<br><br>

### 안병준

<br>
팀 프로젝트를 통해 실전 웹 개발 과정을 직접 경험해보며 <b>MVC 패턴, DB 연동, Git 협업의 중요성</b>을 배울 수 있었습니다.

<br><br>

### 안성준

<br>
<b>사용자 관점의 UI와 서버의 데이터 무결성을 모두 고려하는 개발의 중요성을 체감한 프로젝트</b>였습니다. 예약 중복 버그를 해결하며 눈에 보이지 않는 로직의 작은 차이가 사용자 경험에 큰 영향을 미친다는 것을 배웠습니다.

<br><br>

### 최서연

<br>
Spring MVC를 처음 접하다 보니 간편 상담 예약, 문의 게시판, 공지사항 기능을 구현하는 게 쉽지 않았습니다. 에러가 자꾸 나고 연결이 잘 안 돼서 많이 헤맸지만, 하나하나 해결해 가며 이해가 깊어졌습니다.
비록 전공 수업 프로젝트였지만 끝까지 완성했을 때 <b>큰 성취감과 자신감</b>을 얻을 수 있었습니다.

<br><br>
