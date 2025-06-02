<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 콘솔 - Star's Haven</title>
    <%-- 공통 스타일 및 라이브러리 --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"> <%-- 공통 메인 스타일 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypagestyle.css"> <%-- 마이페이지 레이아웃 스타일 재활용 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminconsole.css"> <%-- 관리자 콘솔 전용 스타일 --%>
</head>
<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

        <div class="main-wrapper">
            <div class="mypage-layout-container container mt-4 mb-4">
                <%-- 왼쪽 사이드바 --%>
                <aside class="mypage-sidebar admin-sidebar">
                    <h3 class="sidebar-title">관리자 메뉴</h3>
                    <nav class="sidebar-nav">
                        <ul>
                            <li class="nav-item ${empty param.section or param.section == 'quick_counseling' ? 'active' : ''}">
                                <a href="${pageContext.request.contextPath}/admin/console?section=quick_counseling">간편 상담 예약 현황</a>
                            </li>
                            <li class="nav-item ${param.section == 'funeral_reservations' ? 'active' : ''}">
                                <a href="${pageContext.request.contextPath}/admin/console?section=funeral_reservations">장례 예약 현황</a>
                            </li>
                        </ul>
                    </nav>
                </aside>

                <%-- 오른쪽 콘텐츠 영역 --%>
                <main class="mypage-content">
                    <c:choose>
                        <%-- 1. 간편 상담 예약 현황 섹션 --%>
                        <c:when test="${empty param.section or param.section == 'quick_counseling'}">
                            <div class="quick-counseling-container">
                                <h2><i class="fas fa-headset"></i> 간편 상담 예약 현황</h2>
                                <p class="sub-text">접수된 모든 간편 상담 예약 목록입니다.</p>
                                <hr class="title-divider">
                                <c:choose>
                                    <c:when test="${not empty quickCounselingList}">
                                        <div class="table-responsive">
                                            <table class="reservation-table table table-hover">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>번호</th>
                                                        <th>예약자명</th>
                                                        <th>연락처</th>
                                                        <th>이메일</th>
                                                        <th>상담 희망일</th>
                                                        <th>상담 희망 시간</th>
                                                        <th>신청일</th>
                                                        <%-- <th>관리</th> --%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="counseling" items="${quickCounselingList}" varStatus="status">
                                                        <tr>
                                                            <td>${status.count}</td>
                                                            <td>${fn:escapeXml(counseling.username)}</td>
                                                            <td>${fn:escapeXml(counseling.phone)}</td>
                                                            <td>${fn:escapeXml(counseling.email)}</td>
                                                            <td>${fn:escapeXml(counseling.date)}</td>
                                                            <td>${fn:escapeXml(counseling.time)}</td>
                                                            <td><fmt:formatDate value="${counseling.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                            <%-- <td><button class="btn btn-sm btn-outline-primary">상세</button></td> --%>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-data-message">
                                            <div class="icon"><i class="fas fa-info-circle"></i></div>
                                            <p class="lead">현재 접수된 간편 상담 예약이 없습니다.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>

                        <%-- 2. 장례 예약 현황 섹션 --%>
                        <c:when test="${param.section == 'funeral_reservations'}">
                            <div class="reservations-container">
                                <h2><i class="fas fa-paw"></i> 장례 예약 현황</h2>
                                <p class="sub-text">접수된 모든 장례 예약 목록입니다.</p>
                                <hr class="title-divider">
                                <c:choose>
                                    <c:when test="${not empty funeralReservationList}">
                                        <div class="table-responsive">
                                            <table class="reservation-table table table-hover">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>번호</th>
                                                        <th>지점</th>
                                                        <th>반려동물 이름</th>
                                                        <th>신청자명</th>
                                                        <th>연락처</th>
                                                        <th>장례일</th>
                                                        <th>장례시간</th>
                                                        <th style="min-width: 150px;">요청사항</th>
                                                        <th>신청자 ID</th>
                                                        <th>신청일</th>
                                                        <%-- <th>관리</th> --%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="reservation" items="${funeralReservationList}" varStatus="status">
                                                        <tr>
                                                            <td>${status.count}</td>
                                                            <td>${fn:escapeXml(reservation.branch)}</td>
                                                            <td>${fn:escapeXml(reservation.petName)}</td>
                                                            <td>${fn:escapeXml(reservation.applicantName)}</td>
                                                            <td>${fn:escapeXml(reservation.applicantPhone)}</td>
                                                            <td>${fn:escapeXml(reservation.obDate)}</td>
                                                            <td>${fn:escapeXml(reservation.obTime)}</td>
                                                            <td>${fn:escapeXml(reservation.notes)}</td>
                                                            <td>${fn:escapeXml(reservation.userId)}</td>
                                                            <td><fmt:formatDate value="${reservation.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                            <%-- <td><button class="btn btn-sm btn-outline-success">상태변경</button></td> --%>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-data-message">
                                            <div class="icon"><i class="fas fa-calendar-times"></i></div>
                                            <p class="lead">현재 접수된 장례 예약이 없습니다.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>
                    </c:choose>
                </main>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            let section = urlParams.get('section');
            if (!section) { // 기본 섹션 설정
                section = 'quick_counseling';
            }
            
            const navLinks = document.querySelectorAll('.admin-sidebar .sidebar-nav .nav-item a');

            navLinks.forEach(link => {
                link.parentElement.classList.remove('active');
                const linkSection = new URL(link.href).searchParams.get('section');
                if (linkSection === section) {
                    link.parentElement.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>