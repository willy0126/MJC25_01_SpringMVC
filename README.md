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
|2020261041|<a href="https://github.com/willy0126" target="_blank" rel="noopener noreferrer">박지원</a>|Front-End|
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

최종 단계에 추가할 예정. (이곳에 사이트 이용 gif 추가 예정)

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


- **🎯 중점 개발 내용**


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
추가 예정

<br>
