<div align=center>
<img src = "https://github.com/user-attachments/assets/9843c825-c481-4a17-a202-50b233532d76" width="35%" height="35%">
  
## 반려동물 장례식장 웹사이트 - Star's Haven
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


> 디렉토리 구조

최종 단계에 추가할 예정.

<br><br>


## 💻 <span id="6"> 6. 주요 기능 소개</span>

최종 단계에 추가할 예정. (이곳에 사이트 이용 gif 추가 예정)

<br><br>


## 📄 <span id="7"> 7. 상세 담당 업무</span>

#### 1) 박지원 (branch: jiwon)

- **🎨 UI**

  - 페이지: 메인 페이지, 절차 및 비용, 지점 소개, 지점 위치, FAQ, 챗봇, 
 
    
  - 공통 컴포넌트 제작: 사이트 로고 및 파비콘

- **🎯 중점 개발 내용 **

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
추가 예정

<br>

## 💭 <span id="10"> 10. 개선 목표</span>
lighthouse performance 지표 사용으로 확인할 예정.

<br>

## 🧑‍🤝‍🧑 <span id="11"> 11. 프로젝트 후기</span>
추가 예정

<br>
