<div align=center>
<img src = "https://github.com/user-attachments/assets/9843c825-c481-4a17-a202-50b233532d76" width="35%" height="35%">
  
## 반려동물 장례식장 웹사이트 - Star's Haven
### 2025 MJC 웹프로그래밍실습 팀프로젝트

</div>
  
<br>

## 0. 목차
1. [프로젝트 소개](#1)
2. [팀원 소개](#2)

## 📝 <span id=1> 1. 프로젝트 소개</span>

주어진 '반려동물 관련' 이라는 조건 속에서, 기존과는 다른 신선함 + 의미 있는 주제로 하자는 목표로 여러 방향을 탐구하였습니다.
<br>최종적으로 고민 끝에 <b>"반려동물 장례식장"</b> 이라는 주제를 선정하여 프로젝트를 시작하게 되었습니다.
<br><br>아래는 웹사이트 제작을 하게된 이유에 대해 간략히 기술합니다.
<br><br>
* 반려동물 수 증가에 따라 관련 서비스 수요가 늘고 있음.

  
* 반려동물 장례에 관한 정보는 여전히 부족하며, 사용자 중심의 맞춤 서비스가 필요하다고 판단함.

  
* 구현 단계에서 사용자 경험(UX) 향상을 최우선 가치로 두어, 직관적이고 쾌적한 사이트를 제공하는 데 포커스를 맞춤.

  
* 실생활에 밀접한 프로젝트이며, 기술적인 측면에서도 해당 프로젝트를 통해 비동기 통신, QR 생성, API 활용, 챗봇 구현.. 등<br>
다양한 기술 통합 및 구현을 시도해볼 수 있음.


<br><br>

## 🙋‍♂️ <span id=2>  2. 팀원 소개</span>

|학번|이름|개발|
|:------:|:---:|:---:|
|2020261041|<a href="https://github.com/willy0126" target="_blank" rel="noopener noreferrer">박지원</a>|테스트|
|2020261074|<a href="https://github.com/AnByoungJun0605" target="_blank" rel="noopener noreferrer">안병준</a>|테스트|
|2021261037|<a href="https://github.com/Asj-Cell" target="_blank" rel="noopener noreferrer">안성준</a>|테스트|
|2022261067|<a href="https://github.com/chltj" target="_blank" rel="noopener noreferrer">최서연</a>|테스트|


<br><br>

## ⌛  3. 개발 일정

> 계획 수립 : 2025.04.15 ~ 2025.04.28 (프로세스 흐름도 및 Figma로 디자인 수립)

> 개발 기간 : 2025.04.29 ~ 진행중

<br><br>

## 🛠️ 4. 기술 스택

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


