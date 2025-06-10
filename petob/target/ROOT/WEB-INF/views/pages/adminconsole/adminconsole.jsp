<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>관리자 콘솔 - Star's Haven</title>
                    <%-- 공통 스타일 및 라이브러리 --%>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <%--
                            Font Awesome --%>
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
                                rel="stylesheet"> <%-- Bootstrap Icons --%>
                                <link rel="stylesheet"
                                    href="${pageContext.request.contextPath}/resources/css/style.css"> <%-- 공통 메인 스타일
                                    --%>
                                    <link rel="stylesheet"
                                        href="${pageContext.request.contextPath}/resources/css/mypagestyle.css"> <%--
                                        마이페이지 레이아웃 스타일 재활용 --%>
                                        <link rel="stylesheet"
                                            href="${pageContext.request.contextPath}/resources/css/adminconsolestyle.css">
                                        <%-- 관리자 콘솔 전용 스타일 --%>
                                            <style>
                                                /* JSP 내 간단한 추가 스타일 (adminconsolestyle.css로 이동 권장) */
                                                .admin-sidebar .sidebar-nav .nav-item.active a {
                                                    background-color: #0d6efd;
                                                    /* Bootstrap primary color */
                                                    color: white;
                                                    font-weight: bold;
                                                }

                                                .badge {
                                                    font-size: 0.85em;
                                                    padding: 0.4em 0.6em;
                                                }

                                                .btn-sm {
                                                    padding: 0.25rem 0.5rem;
                                                    font-size: 0.875rem;
                                                    border-radius: 0.2rem;
                                                }
                                            </style>
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
                                                <li
                                                    class="nav-item ${currentSection == 'quick_counseling' ? 'active' : ''}">
                                                    <a
                                                        href="${pageContext.request.contextPath}/admin/console?section=quick_counseling">간편
                                                        상담 예약 현황</a>
                                                </li>
                                                <li
                                                    class="nav-item ${currentSection == 'funeral_reservations' ? 'active' : ''}">
                                                    <a
                                                        href="${pageContext.request.contextPath}/admin/console?section=funeral_reservations">장례
                                                        예약 현황</a>
                                                </li>

                                                <li class="nav-item ${currentSection == 'inquiry_board' ? 'active' : ''}">
                                                <a href="${pageContext.request.contextPath}/admin/console?section=inquiry_board">문의 게시판</a>
                                                </li>


                                            </ul>
                                        </nav>
                                    </aside>

                                    <%-- 오른쪽 콘텐츠 영역 --%>
                                        <main class="mypage-content">
                                            <%-- 성공/에러 메시지 표시 --%>
                                                <c:if test="${not empty successMessage}">
                                                    <div class="alert alert-success alert-dismissible fade show"
                                                        role="alert">
                                                        ${successMessage}
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                            aria-label="Close"></button>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty errorMessage}">
                                                    <div class="alert alert-danger alert-dismissible fade show"
                                                        role="alert">
                                                        ${errorMessage}
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                            aria-label="Close"></button>
                                                    </div>
                                                </c:if>

                                                <c:choose>
                                                    <%-- 1. 간편 상담 예약 현황 섹션 --%>
                                                        <c:when test="${currentSection == 'quick_counseling'}">
                                                            <div class="quick-counseling-container">
                                                                <h2><i class="bi bi-headset"></i> 간편 상담 예약 현황</h2>
                                                                <p class="sub-text">접수된 모든 간편 상담 예약 목록입니다.</p>
                                                                <hr class="title-divider">
                                                                <c:choose>
                                                                    <c:when test="${not empty quickCounselingList}">
                                                                        <div class="table-responsive">
                                                                            <table
                                                                                class="reservation-table table table-hover">
                                                                                <thead class="table-light">
                                                                                    <tr>
                                                                                        <th>예약ID</th>
                                                                                        <th>예약자명</th>
                                                                                        <th>연락처</th>
                                                                                        <th>이메일</th>
                                                                                        <th>상담 희망일</th>
                                                                                        <th>상담 희망 시간</th>
                                                                                        <th>신청일</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <c:forEach var="counseling"
                                                                                        items="${quickCounselingList}">
                                                                                        <tr>
                                                                                            <td>${counseling.reservationId}
                                                                                            </td>
                                                                                            <td>${fn:escapeXml(counseling.username)}
                                                                                            </td>
                                                                                            <td>${fn:escapeXml(counseling.phone)}
                                                                                            </td>
                                                                                            <td>${fn:escapeXml(counseling.email)}
                                                                                            </td>
                                                                                            <td>${fn:escapeXml(counseling.date)}
                                                                                            </td>
                                                                                            <td>${fn:escapeXml(counseling.time)}
                                                                                            </td>
                                                                                            <td>
                                                                                                <fmt:formatDate
                                                                                                    value="${counseling.createdAt}"
                                                                                                    pattern="yyyy-MM-dd HH:mm" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="no-data-message">
                                                                            <div class="icon"><i
                                                                                    class="bi bi-info-circle-fill"></i>
                                                                            </div>
                                                                            <p class="lead">현재 접수된 간편 상담 예약이 없습니다.</p>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </c:when>

                                                        <%-- 2. 장례 예약 현황 섹션 --%>
                                                            <c:when test="${currentSection == 'funeral_reservations'}">
                                                                <div class="reservations-container">
                                                                    <h2><i class="bi bi-calendar-heart-fill"></i> 장례 진행
                                                                        예약 현황</h2>
                                                                    <p class="sub-text">전체 장례 진행 예약 내역을 확인하고 관리합니다.</p>
                                                                    <hr class="title-divider">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${not empty funeralReservationList}">
                                                                            <div class="table-responsive">
                                                                                <table
                                                                                    class="reservation-table table table-hover">
                                                                                    <thead class="table-light">
                                                                                        <tr>
                                                                                            <th>예약ID</th>
                                                                                            <th>지점</th>
                                                                                            <th>아이명</th>
                                                                                            <th>무게(kg)</th>
                                                                                            <th>신청자</th>
                                                                                            <th>연락처</th>
                                                                                            <th>희망날짜</th>
                                                                                            <th>희망시간</th>
                                                                                            <th
                                                                                                style="min-width: 120px;">
                                                                                                요청사항</th>
                                                                                            <th>사용자ID</th>
                                                                                            <th>신청일시</th>
                                                                                            <th>신청 상태</th>
                                                                                            <th
                                                                                                style="min-width: 130px;">
                                                                                                관리</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <c:forEach var="reservation"
                                                                                            items="${funeralReservationList}">
                                                                                            <tr>
                                                                                                <td>${reservation.reservationId}
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.branch}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.petName}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <fmt:formatNumber
                                                                                                        value="${reservation.petWeight}"
                                                                                                        pattern="#,##0.0" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.applicantName}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.applicantPhone}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.obDate}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.obTime}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.notes}" />
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:out
                                                                                                        value="${reservation.userId}" />
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
                                                                                                                class="badge bg-warning text-dark">${reservation.status}</span>
                                                                                                        </c:when>
                                                                                                        <c:when
                                                                                                            test="${reservation.status == '수락'}">
                                                                                                            <span
                                                                                                                class="badge bg-success">${reservation.status}</span>
                                                                                                        </c:when>
                                                                                                        <c:when
                                                                                                            test="${reservation.status == '거절'}">
                                                                                                            <span
                                                                                                                class="badge bg-danger">${reservation.status}</span>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>
                                                                                                            <span
                                                                                                                class="badge bg-secondary">${fn:escapeXml(reservation.status)}</span>
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <c:if
                                                                                                        test="${reservation.status == '신청대기중'}">
                                                                                                        <form
                                                                                                            action="${pageContext.request.contextPath}/admin/obituary/${reservation.reservationId}/accept"
                                                                                                            method="post"
                                                                                                            style="display: inline-block; margin-right: 5px;">
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="btn btn-sm btn-success">수락</button>
                                                                                                        </form>
                                                                                                        <form
                                                                                                            action="${pageContext.request.contextPath}/admin/obituary/${reservation.reservationId}/reject"
                                                                                                            method="post"
                                                                                                            style="display: inline-block;">
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="btn btn-sm btn-danger">거절</button>
                                                                                                        </form>
                                                                                                    </c:if>
                                                                                                    <c:if
                                                                                                        test="${reservation.status != '신청대기중'}">
                                                                                                        <span>-</span>
                                                                                                    </c:if>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </c:forEach>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="no-data-message">
                                                                                <div class="icon"><i
                                                                                        class="bi bi-calendar-x-fill"></i>
                                                                                </div>
                                                                                <p class="lead">현재 접수된 장례 진행 예약이 없습니다.
                                                                                </p>
                                                                                <p>새로운 예약이 접수되면 여기에 표시됩니다.</p>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:when>


                                                            <%-- 3. 문의 게시판 섹션 --%>
                                                            <c:when test="${currentSection == 'inquiry_board'}">
                                                                <div class="inquiry-board-container">
                                                                    <h2><i class="bi bi-question-circle-fill"></i> 문의 게시판 관리</h2>
                                                                    <p class="sub-text">사용자들이 작성한 문의 목록입니다.</p>
                                                                    <hr class="title-divider">
                                                                    
                                                                    <c:choose>
                                                                        <c:when test="${not empty inquiryList}">
                                                                            <div class="inquiry-summary mb-3">
                                                                                <span class="text-muted">총 <strong>${fn:length(inquiryList)}</strong>건의 문의</span>
                                                                            </div>
                                                                            <div class="table-responsive">
                                                                                <table class="reservation-table table table-hover">
                                                                                    <thead class="table-light">
                                                                                        <tr>
                                                                                            <th style="width: 80px;">번호</th>
                                                                                            <th>제목</th>
                                                                                            <th style="width: 120px;">작성자</th>
                                                                                            <th style="width: 120px;">처리상태</th>
                                                                                            <th style="width: 140px;">작성일</th>
                                                                                            <th style="width: 100px;">관리</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
                                                                                            <tr>
                                                                                                <td>${inquiry.inquiryId}</td>
                                                                                                <td>
                                                                                                    <a href="${pageContext.request.contextPath}/admin/inquiry/view/${inquiry.inquiryId}" 
                                                                                                       class="text-decoration-none text-dark fw-medium">
                                                                                                        <c:out value="${inquiry.title}" />
                                                                                                    </a>
                                                                                                </td>
                                                                                                <td><c:out value="${inquiry.username}" /></td>
                                                                                                <td>
                                                                                                    <c:choose>
                                                                                                        <c:when test="${inquiry.status == 'WAITING'}">
                                                                                                            <span class="badge" style="background-color: #fff3cd; color: #856404; border: 1px solid #ffeaa7;">답변대기</span>
                                                                                                        </c:when>
                                                                                                        <c:when test="${inquiry.status == 'PROCESSING'}">
                                                                                                            <span class="badge bg-primary">처리중</span>
                                                                                                        </c:when>
                                                                                                        <c:when test="${inquiry.status == 'COMPLETED'}">
                                                                                                            <span class="badge bg-success">답변완료</span>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>
                                                                                                            <span class="badge" style="background-color: #fff3cd; color: #856404; border: 1px solid #ffeaa7;">답변대기</span>
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>
                                                                                                </td>
                                               <td>
    <c:choose>
        <c:when test="${not empty inquiry.createdDate}">
            ${fn:replace(fn:substring(inquiry.createdDate, 0, 16), 'T', ' ')}
        </c:when>
        <c:otherwise>-</c:otherwise>
    </c:choose>
</td>
                                                                                                <td>
                                                                                                    <a href="${pageContext.request.contextPath}/admin/inquiry/view/${inquiry.inquiryId}" 
                                                                                                       class="btn btn-sm btn-outline-primary">
                                                                                                        보기
                                                                                                    </a>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </c:forEach>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="no-data-message">
                                                                                <div class="icon"><i class="bi bi-inbox-fill"></i></div>
                                                                                <p class="lead">현재 등록된 문의가 없습니다.</p>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:when>

                                                            <%-- 기본 섹션 (간편 상담) --%>
                                                            <c:otherwise>
                                                                <div class="quick-counseling-container">
                                                                    <h2><i class="bi bi-headset"></i> 간편 상담 예약 현황</h2>
                                                                    <p class="sub-text">접수된 모든 간편 상담 예약 목록입니다.</p>
                                                                    <hr class="title-divider">
                                                                    <c:choose>
                                                                        <c:when test="${not empty quickCounselingList}">
                                                                            <div class="table-responsive">
                                                                                <table class="reservation-table table table-hover">
                                                                                    <thead class="table-light">
                                                                                        <tr>
                                                                                            <th>예약ID</th>
                                                                                            <th>예약자명</th>
                                                                                            <th>연락처</th>
                                                                                            <th>이메일</th>
                                                                                            <th>상담 희망일</th>
                                                                                            <th>상담 희망 시간</th>
                                                                                            <th>신청일</th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <c:forEach var="counseling" items="${quickCounselingList}">
                                                                                            <tr>
                                                                                                <td>${counseling.reservationId}</td>
                                                                                                <td>${fn:escapeXml(counseling.username)}</td>
                                                                                                <td>${fn:escapeXml(counseling.phone)}</td>
                                                                                                <td>${fn:escapeXml(counseling.email)}</td>
                                                                                                <td>${fn:escapeXml(counseling.date)}</td>
                                                                                                <td>${fn:escapeXml(counseling.time)}</td>
                                                                                                <td>
                                                                                                    <fmt:formatDate value="${counseling.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </c:forEach>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="no-data-message">
                                                                                <div class="icon"><i class="bi bi-info-circle-fill"></i></div>
                                                                                <p class="lead">현재 접수된 간편 상담 예약이 없습니다.</p>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                     </div>
                                                            </c:otherwise>
                                                </c:choose>
                                        </main>
                            </div>
                        </div>
                        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            let section = urlParams.get('section');
                            if (!section) { // 기본 섹션 설정
                                section = 'quick_counseling';
                            }

                            // 동적으로 active 클래스 설정 (이미 컨트롤러에서 currentSection으로 처리하고 있지만, 클라이언트 사이드에서도 보강)
                            const navLinks = document.querySelectorAll('.admin-sidebar .sidebar-nav .nav-item a');
                            navLinks.forEach(link => {
                                link.parentElement.classList.remove('active');
                                // href에서 section 파라미터 값 추출
                                const linkSection = new URL(link.href, window.location.origin).searchParams.get('section');
                                if (linkSection === section) {
                                    link.parentElement.classList.add('active');
                                }
                            });

                            // Flash 메시지 자동 닫기 (선택 사항)
                            const alertList = document.querySelectorAll('.alert-dismissible');
                            alertList.forEach(function (alert) {
                                new bootstrap.Alert(alert); // Bootstrap 알림 초기화 (닫기 버튼 기능 활성화)
                                // setTimeout(() => {
                                //     const bsAlert = bootstrap.Alert.getInstance(alert);
                                //     if (bsAlert) {
                                //         bsAlert.close();
                                //     }
                                // }, 5000); // 5초 후 자동 닫기
                            });
                        });
                    </script>
                </body>

                </html>