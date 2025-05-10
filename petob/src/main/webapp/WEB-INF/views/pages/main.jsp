<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- 공통 메타·공통 CSS -->
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>Star's Haven - 반려동물 장례식장, 아름다운 이별을 위한 공간</title>

    <!-- main 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/mainstyle.css'/>" />
</head>
<body>
<div class="page-wrapper">

    <!-- (1) Navbar -->
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <!-- (2) 메인 컨텐츠 -->
    <main class="main-wrapper">

        <div class="analog-clock">
            <div class="dial"></div>
            <div class="hand hour-hand"></div>
            <div class="hand minute-hand"></div>
            <div class="hand second-hand"></div>
        </div>

        <!-- 메인 슬라이드 캐러셀 -->
        <section id="carousel">
            <div class="site-container">
                <div id="mainCarousel" class="carousel slide fade-in" data-bs-ride="carousel"
                    data-bs-interval="3000" style="height:400px; overflow:hidden;">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="슬라이드 1"></button>
                        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1" aria-label="슬라이드 2"></button>
                        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2" aria-label="슬라이드 3"></button>
                    </div>

                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="${pageContext.request.contextPath}/resources/img/carousel1.jpg" class="d-block w-100" alt="슬라이드1" style="height:400px; object-fit:cover;">
                            <div class="carousel-caption d-none d-md-block text-start">
                                <h5 class="text-white">따뜻한 이별을, 진심으로</h5>
                                <p class="text-white">처음과 마지막을 지켜드리겠습니다.</p>
                            </div>
                        </div>

                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/resources/img/carousel2.jpg" class="d-block w-100" alt="슬라이드2" style="height:400px; object-fit:cover;">
                            <div class="carousel-caption d-none d-md-block text-start">
                                <h5 class="text-white">마지막 여정을, 아름답게</h5>
                                <p class="text-white">좋은 추억만을 간직하겠습니다.</p>
                            </div>
                        </div>

                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/resources/img/carousel3.jpg" class="d-block w-100" alt="슬라이드3" style="height:400px; object-fit:cover;">
                            <div class="carousel-caption d-none d-md-block text-start">
                                <h5 class="text-white">함께한 시간을, 영원히</h5>
                                <p class="text-white">소중한 기억이 되도록 곁을 지키겠습니다.</p>
                            </div>
                        </div>
                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">이전</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">다음</span>
                    </button>
                </div>
            </div>
        </section>

        <!-- 사이트 소개 -->
        <section id="intro">
            <div class="site-container">
                <h2 class="section-title">사이트 소개</h2>

                <div class="intro-item">
                    <img src="<c:url value='/resources/img/maincontent1.jpg'/>" alt="위로의 말 이미지">
                    <div class="text">
                        <h3>위로의 말</h3>
                        <p>반려동물의 평온한 이별을 위한, 당신의 든든한 동반자.<br>장례, 추모, 기억까지... 당신의 슬픔을 함께 나누고 공감하는 공간입니다.</p>
                    </div>
                </div>

                <div class="intro-item reverse">
                    <img src="<c:url value='/resources/img/maincontent2.jpg'/>" alt="천사 강아지 이미지">
                    <div class="text">
                        <h3>영원의 안식으로</h3>
                        <p>사랑과 추억을 남기고 떠나는 마지막 길을, 따뜻함으로 지켜드립니다.<br>영원의 안식 속에서도, 소중한 기억은 언제나 함께할 것입니다.</p>
                    </div>
                </div>

            </div>
        </section>

        <!-- 공지사항 및 개발 비하인드 (Mini Carousel) -->
        <section id="notices">
        <div class="notice-list">
            <h4>사이트 공지사항</h4>
            <ul>
                <li><span class="title">공지사항 예시 1 입니다.</span><span class="date">2025.05.02</span></li>
                <li><span class="title">mini carousel 사진 변경 및 수정</span><span class="date">2025.05.03</span></li>
                <li><span class="title">margin값 변경하기</span><span class="date">2025.05.05</span></li>
                <li><span class="title">공지사항 게시판과 연동하기 (상위 3~4개 컨텐츠만)</span><span class="date">2025.05.08</span></li>
            </ul>
        </div>

        <div class="mini-carousel">
            <h4>개발 비하인드</h4>
            <div id="miniCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <h5>사이트 이름 이야기</h5>
                        <p><b>"Star's Haven"</b>은 여러분의 반려동물,<br>이제는 별이 된 친구들이 편히 쉬는 안식처를 뜻합니다.</p>
                    </div>
                    <div class="carousel-item">
                        <h5>개발 계기</h5>
                        <p>반려동물과의 마지막 이별은 너무나 슬프기에<br>따뜻한 공간을 만들고자 시작했습니다.</p>
                    </div>
                    <div class="carousel-item">
                        <h5>개발자의 마음</h5>
                        <p>저희 사이트가 작은 위로가 되어드리길 기원합니다.</p>
                    </div>
                    <div class="carousel-item">
                        <h5>전하고 싶은 말</h5>
                        <p>이곳을 찾아주신 여러분과 별이 된 친구들에게<br>최상의 서비스로 보답하겠습니다.</p>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#miniCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#miniCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>    
            </div>
        </div>
        </section>
    </main>

    <!-- (3) Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<!-- (4) Scripts -->
<jsp:include page="/WEB-INF/views/common/script.jsp" />

</body>
</html>