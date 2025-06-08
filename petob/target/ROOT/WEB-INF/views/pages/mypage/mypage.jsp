<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>마이페이지 - Star's Haven</title>
                    <%-- 공통 스타일 및 라이브러리 --%>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
                            rel="stylesheet"> <%-- Bootstrap Icons 추가 --%>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
                            <link rel="stylesheet"
                                href="${pageContext.request.contextPath}/resources/css/mypagestyle.css">
                            <style>
                                /* JSP 내 간단한 추가 스타일 (mypagestyle.css로 이동 권장) */
                                .mypage-sidebar .sidebar-nav .nav-item.active a {
                                    background-color: #0d6efd;
                                    /* Bootstrap primary color */
                                    color: white;
                                    font-weight: bold;
                                }

                                .password-verification-container .input-group .form-control {
                                    border-right: 0;
                                }

                                .password-verification-container .input-group .btn {
                                    border-top-left-radius: 0;
                                    border-bottom-left-radius: 0;
                                }

                                /* 성공/에러 메시지 스타일 */
                                .flash-message {
                                    margin-bottom: 1rem;
                                }

                                .badge {
                                    font-size: 0.85em;
                                    padding: 0.4em 0.6em;
                                }
                            </style>
                </head>

                <body>
                    <div class="page-wrapper">
                        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                        <div class="main-wrapper">
                            <div class="mypage-layout-container container mt-4 mb-4">
                                <%-- 왼쪽 사이드바 --%>
                                    <aside class="mypage-sidebar">
                                        <h3 class="sidebar-title">마이페이지</h3>
                                        <nav class="sidebar-nav">
                                            <ul>
                                                <%-- 컨트롤러에서 전달하는 currentSection 값으로 active 클래스 제어 --%>
                                                    <li
                                                        class="nav-item ${currentSection == 'reservations' or empty currentSection ? 'active' : ''}">
                                                        <a href="${pageContext.request.contextPath}/mypage">예약 확인</a>
                                                    </li>
                                                    <li
                                                        class="nav-item ${currentSection == 'editProfile' ? 'active' : ''}">
                                                        <a href="${pageContext.request.contextPath}/mypage/edit">개인정보
                                                            수정</a>
                                                    </li>
                                                    <li
                                                        class="nav-item ${currentSection == 'changePassword' ? 'active' : ''}">
                                                        <a
                                                            href="${pageContext.request.contextPath}/mypage/change-password">비밀번호
                                                            변경</a>
                                                    </li>
                                                    <li
                                                        class="nav-item ${currentSection == 'withdraw' ? 'active' : ''}">
                                                        <a href="${pageContext.request.contextPath}/mypage/withdraw">회원
                                                            탈퇴</a>
                                                    </li>
                                            </ul>
                                        </nav>
                                    </aside>

                                    <%-- 오른쪽 콘텐츠 영역 --%>
                                        <main class="mypage-content">
                                            <%-- 컨트롤러에서 전달된 성공/에러 메시지 표시 --%>
                                                <c:if test="${not empty successMessage}">
                                                    <div class="alert alert-success flash-message" role="alert">
                                                        ${successMessage}</div>
                                                </c:if>
                                                <c:if test="${not empty errorMessage}">
                                                    <div class="alert alert-danger flash-message" role="alert">
                                                        ${errorMessage}</div>
                                                </c:if>



                                                <h2><i class="fas fa-calendar-alt"></i> 예약 확인</h2>
                                                <p class="sub-text">고객님의 장례 예약 현황입니다.</p>
                                                <hr class="title-divider">

                                                <div class="reservations-container">
                                                    <c:choose>
                                                        <c:when test="${not empty funeralReservationList}">
                                                            <div class="table-responsive">
                                                                <table class="reservation-table table table-hover">
                                                                    <thead class="table-light">
                                                                        <tr>
                                                                            <th>예약ID</th>
                                                                            <th>지점</th>
                                                                            <th>반려동물 이름</th>
                                                                            <th>신청자명</th>
                                                                            <th>연락처</th>
                                                                            <th>장례일</th>
                                                                            <th>장례시간</th>
                                                                            <th style="min-width: 150px;">요청사항</th>
                                                                            <th>신청일</th>
                                                                            <th>신청 상태</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach var="reservation"
                                                                            items="${funeralReservationList}">
                                                                            <tr>
                                                                                <td>${reservation.reservationId}</td>
                                                                                <td>${fn:escapeXml(reservation.branch)}
                                                                                </td>
                                                                                <td>${fn:escapeXml(reservation.petName)}
                                                                                </td>
                                                                                <td>${fn:escapeXml(reservation.applicantName)}
                                                                                </td>
                                                                                <td>${fn:escapeXml(reservation.applicantPhone)}
                                                                                </td>
                                                                                <td>${fn:escapeXml(reservation.obDate)}
                                                                                </td>
                                                                                <td>${fn:escapeXml(reservation.obTime)}
                                                                                </td>
                                                                                <td>${fn:escapeXml(reservation.notes)}
                                                                                </td>
                                                                                <td>
                                                                                    <fmt:formatDate
                                                                                        value="${reservation.createdAt}"
                                                                                        pattern="yyyy-MM-dd HH:mm" />
                                                                                </td>
                                                                                <td>
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${reservation.status == '신청대기중'}">
                                                                                            <span
                                                                                                class="badge bg-warning text-dark">${fn:escapeXml(reservation.status)}</span>
                                                                                        </c:when>
                                                                                        <c:when
                                                                                            test="${reservation.status == '수락'}">
                                                                                            <span
                                                                                                class="badge bg-success">${fn:escapeXml(reservation.status)}</span>
                                                                                        </c:when>
                                                                                        <c:when
                                                                                            test="${reservation.status == '거절'}">
                                                                                            <span
                                                                                                class="badge bg-danger">${fn:escapeXml(reservation.status)}</span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span
                                                                                                class="badge bg-secondary">${fn:escapeXml(reservation.status)}</span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="no-reservations text-center p-5">
                                                                <i
                                                                    class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                                                <p class="lead">${funeralMessage != null ?
                                                                    funeralMessage : "신청하신 장례 예약 내역이 없습니다."}</p>
                                                                <a href="${pageContext.request.contextPath}/obituary-reservation/form"
                                                                    class="btn btn-primary-action btn-lg">장례 예약하기</a>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                        </main>
                            </div>
                        </div>
                        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>