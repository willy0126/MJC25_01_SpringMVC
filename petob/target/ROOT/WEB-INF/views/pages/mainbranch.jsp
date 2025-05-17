<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp" />
            <title>본점 - Star's Haven, 반려동물 장례식장</title>

            <link rel="stylesheet" href="<c:url value='/resources/css/branchstyle.css'/>" />
        </head>

        <body>
            <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
            <div class="page-wrapper">
                <main class="main-wrapper">
                    <div class="container mt-4">
                        <h3><b>본점</b></h3>
                        <div class="row">
                            <div class="col-md-8">
                                <div id="basicCarousel" class="carousel slide" data-bs-ride="carousel"
                                    data-bs-interval="3000" data-bs-pause="hover">

                                    <div class="carousel-indicators">
                                        <button type="button" data-bs-target="#basicCarousel" data-bs-slide-to="0"
                                            class="active" aria-current="true" aria-label="Slide 1"></button>
                                        <button type="button" data-bs-target="#basicCarousel" data-bs-slide-to="1"
                                            aria-label="Slide 2"></button>
                                        <button type="button" data-bs-target="#basicCarousel" data-bs-slide-to="2"
                                            aria-label="Slide 3"></button>
                                        <button type="button" data-bs-target="#basicCarousel" data-bs-slide-to="3"
                                            aria-label="Slide 4"></button>
                                    </div>

                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <img src="${pageContext.request.contextPath}/resources/img/mainbranchimg.jpg"
                                                class="d-block w-100" alt="Image 1">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/resources/img/mainbranchimg2.jpg"
                                                class="d-block w-100" alt="Image 2">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/resources/img/mainbranchimg3.jpg"
                                                class="d-block w-100" alt="Image 3">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/resources/img/mainbranchimg4.png"
                                                class="d-block w-100" alt="Image 4">
                                        </div>
                                    </div>

                                    <button class="carousel-control-prev" type="button" data-bs-target="#basicCarousel"
                                        data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#basicCarousel"
                                        data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>

                                <%-- 여기에 나중에 썸네일 캐러셀이 추가될 예정입니다 (메인 캐러셀 아래, 이 컬럼 안에서) --%>

                            </div>

                            <div class="col-md-4 mt-3 mt-md-0 ps-md-4">
                                <h5>소중한 아이를 배웅하는 길,<br><b>Star's Haven 본점</b>에서 함께합니다.
                                    <h5>
                                        <p>
                                            여기에 캐러셀 옆에 표시될 본점 관련 텍스트 내용을 입력하세요.
                                            장례 절차, 시설 안내, 오시는 길 등 다양한 정보를 담을 수 있습니다.
                                        </p>
                                        <p>
                                            이 텍스트 블록은 화면이 커지면 캐러셀과 나란히 배치되고, 화면이 작아지면 캐러셀 아래로 자동으로 이동합니다.
                                        </p>
                                        <a href="#" class="btn btn-primary mt-3">본점 예약하기</a>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            <jsp:include page="/WEB-INF/views/common/script.jsp" />
        </body>

        </html>