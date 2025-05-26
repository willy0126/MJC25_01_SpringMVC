<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp" />
            <title>홍대입구점 - Star's Haven, 반려동물 장례식장</title>

            <link rel="stylesheet" href="<c:url value='/resources/css/branchstyle.css'/>" />
        </head>

        <body>
            <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
            <div class="page-wrapper">
                <main class="main-wrapper">
                    <div class="site-container">
                        <h3 class="page-section-title content-fade-in"><b>홍대입구점</b></h3>
                        <div class="row g-2">
                            <div class="col-md-8">
                                <div id="basicCarousel" class="carousel slide content-fade-in delay-1"
                                    data-bs-ride="carousel" data-bs-interval="3000" data-bs-pause="hover">

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
                                            <img src="${pageContext.request.contextPath}/resources/img/subbranch1img.png"
                                                class="d-block w-100" alt="Image 1">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/resources/img/subbranch1img2.png"
                                                class="d-block w-100" alt="Image 2">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/resources/img/subbranch1img3.png"
                                                class="d-block w-100" alt="Image 3">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="${pageContext.request.contextPath}/resources/img/subbranch1img4.png"
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

                            </div>

                            <div class="col-md-4 mt-3 mt-md-0 ps-md-2 content-fade-in delay-2">
                                <h5>최상의 서비스를 제공하는 여기는,<br><b>Star's Haven 홍대입구점</b>입니다.
                                </h5>
                                <p>
                                    여기에 캐러셀 옆에 표시될 본점 관련 텍스트 내용을 입력하세요.
                                    장례 절차, 시설 안내, 오시는 길 등 다양한 정보를 담을 수 있습니다.
                                </p>
                                <p class="address-info-line first-address-line d-flex align-items-center">
                                    <span><b>지점 주소:</b>서울특별시 마포구 동교동 172-14</span>
                                    <a href="${pageContext.request.contextPath}/location?branch=hongdae"
                                        class="btn btn-outline-secondary btn-xs view-map-btn" target="_blank">지도 보기</a>
                                </p>
                                <p class="address-info-line">
                                    <b>지점 번호:</b> 02-987-6543
                                </p>
                                <p class="address-info-line">
                                    <b>운영 시간:</b> 09:00 ~ 18:00
                                </p>
                                <p class="mt-3">
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#businessLicenseModal"
                                        class="text-decoration-underline">
                                        사업자 정보 확인하기
                                    </a>
                                </p>
                                <a href="#" class="btn btn-primary mt-3">홍대입구점 예약하기</a>
                            </div>
                        </div>
                    </div>
                </main>
            </div>

            <%-- 사업자 등록증 표시를 위한 Bootstrap Modal --%>
                <div class="modal fade" id="businessLicenseModal" tabindex="-1"
                    aria-labelledby="businessLicenseModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="businessLicenseModalLabel">사 업 자 등 록 증</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body text-center">

                                <img src="${pageContext.request.contextPath}/resources/img/license_sample.png"
                                    class="img-fluid" alt="Star's Haven 사업자 등록증 샘플">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                <jsp:include page="/WEB-INF/views/common/script.jsp" />
        </body>
        </html>