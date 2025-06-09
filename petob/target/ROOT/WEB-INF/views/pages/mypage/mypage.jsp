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

                                /* 문의 관련 스타일 */
                                .inquiry-card {
                                    border: 1px solid #e0e0e0;
                                    border-radius: 8px;
                                    margin-bottom: 1rem;
                                    transition: box-shadow 0.2s;
                                }

                                .inquiry-card:hover {
                                    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                                }

                                .inquiry-header {
                                    background-color: #f8f9fa;
                                    padding: 1rem;
                                    border-bottom: 1px solid #e0e0e0;
                                    border-radius: 8px 8px 0 0;
                                }

                                .inquiry-body {
                                    padding: 1rem;
                                }

                                .inquiry-meta {
                                    font-size: 0.9em;
                                    color: #6c757d;
                                    margin-bottom: 0.5rem;
                                }

                                .inquiry-title {
                                    font-size: 1.1em;
                                    font-weight: 600;
                                    margin-bottom: 0.5rem;
                                    color: #212529;
                                }

                                .inquiry-content {
                                    color: #495057;
                                    line-height: 1.5;
                                    margin-bottom: 1rem;
                                }

                                .inquiry-actions {
                                    display: flex;
                                    gap: 0.5rem;
                                    margin-top: 1rem;
                                }

                                .status-waiting {
                                    background-color: #fff3cd;
                                    color: #856404;
                                    border: 1px solid #ffeaa7;
                                }

                                .status-processing {
                                    background-color: #cce5ff;
                                    color: #004085;
                                    border: 1px solid #99d6ff;
                                }

                                .status-completed {
                                    background-color: #d1edff;
                                    color: #0c5460;
                                    border: 1px solid #bee5eb;
                                }

                                .reply-section {
                                    background-color: #f8f9fa;
                                    border-top: 1px solid #e0e0e0;
                                    padding: 1rem;
                                    margin-top: 1rem;
                                    border-radius: 0 0 8px 8px;
                                }

                                .reply-header {
                                    font-weight: 600;
                                    color: #495057;
                                    margin-bottom: 0.5rem;
                                    display: flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                }

                                .reply-content {
                                    color: #495057;
                                    line-height: 1.5;
                                    white-space: pre-wrap;
                                }

                                .write-inquiry-btn {
                                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                    border: none;
                                    color: white;
                                    padding: 0.75rem 1.5rem;
                                    border-radius: 8px;
                                    font-weight: 600;
                                    transition: all 0.3s ease;
                                    text-decoration: none;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                }

                                .write-inquiry-btn:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                                    color: white;
                                    text-decoration: none;
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
                                                    <li class="nav-item ${currentSection == 'myInquiry' ? 'active' : ''}">
                                                        <a href="${pageContext.request.contextPath}/mypage/my-inquiry">나의 문의</a>
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

 
                                                <c:choose>
                                                    <%-- 1. 예약 확인 섹션 (기본) --%>
                                                    <c:when test="${currentSection == 'reservations' or empty currentSection}">
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
                                                    </c:when>

                                                    <%-- 2. 나의 문의 섹션 --%>
                                                    <c:when test="${currentSection == 'myInquiry'}">
                                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                                            <div>
                                                                <h2><i class="bi bi-question-circle-fill"></i> 나의 문의</h2>
                                                                <p class="sub-text">작성하신 문의 내역과 답변을 확인하실 수 있습니다.</p>
                                                            </div>
                                                            <a href="${pageContext.request.contextPath}/inquiry/write" 
                                                               class="write-inquiry-btn">
                                                                <i class="bi bi-plus-circle"></i>
                                                                새 문의 작성
                                                            </a>
                                                        </div>
                                                        <hr class="title-divider">

                                                        <div class="inquiry-container">
                                                            <c:choose>
                                                                <c:when test="${not empty myInquiryList}">
                                                                    <div class="inquiry-summary mb-3">
                                                                        <span class="text-muted">총 <strong>${fn:length(myInquiryList)}</strong>건의 문의</span>
                                                                    </div>
                                                                    
                                                                    <c:forEach var="inquiry" items="${myInquiryList}" varStatus="status">
                                                                        <div class="inquiry-card">
                                                                            <div class="inquiry-header">
                                                                                <div class="d-flex justify-content-between align-items-start">
                                                                                    <div class="inquiry-meta">
                                                                                        <span class="me-3">
                                                                                            <i class="bi bi-calendar3"></i>
                                                                                            ${inquiry.createdDateFormatted}
                                                                                        </span>
                                                                                        <span class="me-3">
                                                                                            <i class="bi bi-tag"></i>
                                                                                            ${inquiry.categoryName}
                                                                                        </span>
                                                                                        <c:if test="${inquiry.isSecret}">
                                                                                            <span class="badge bg-secondary">
                                                                                                <i class="bi bi-lock"></i> 비밀글
                                                                                            </span>
                                                                                        </c:if>
                                                                                    </div>
                                                                                    <div>
                                                                                        <c:choose>
                                                                                            <c:when test="${inquiry.status == 'WAITING'}">
                                                                                                <span class="badge status-waiting">답변대기</span>
                                                                                            </c:when>
                                                                                            <c:when test="${inquiry.status == 'PROCESSING'}">
                                                                                                <span class="badge status-processing">처리중</span>
                                                                                            </c:when>
                                                                                            <c:when test="${inquiry.status == 'COMPLETED'}">
                                                                                                <span class="badge status-completed">답변완료</span>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <span class="badge status-waiting">답변대기</span>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            
                                                                            <div class="inquiry-body">
                                                                                <div class="inquiry-title">
                                                                                    <c:out value="${inquiry.title}" />
                                                                                </div>
                                                                                <div class="inquiry-content">
                                                                                    <c:out value="${inquiry.content}" />
                                                                                </div>
                                                                                
                                                                                <div class="inquiry-actions">
                                                                                    <a href="${pageContext.request.contextPath}/inquiry/view/${inquiry.inquiryId}" 
                                                                                       class="btn btn-sm btn-outline-primary">
                                                                                        <i class="bi bi-eye"></i> 상세보기
                                                                                    </a>
                                                                                    <c:if test="${inquiry.status != 'COMPLETED'}">
                                                                                        <a href="${pageContext.request.contextPath}/inquiry/edit/${inquiry.inquiryId}" 
                                                                                           class="btn btn-sm btn-outline-secondary">
                                                                                            <i class="bi bi-pencil"></i> 수정
                                                                                        </a>
                                                                                        <form action="${pageContext.request.contextPath}/inquiry/delete/${inquiry.inquiryId}" 
                                                                                              method="post" style="display: inline;"
                                                                                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                                                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                                                                <i class="bi bi-trash"></i> 삭제
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:if>
                                                                                </div>
                                                                                
                                                                                <%-- 답변이 있는 경우 표시 --%>
                                                                                <c:if test="${not empty inquiry.replyContent}">
                                                                                    <div class="reply-section">
                                                                                        <div class="reply-header">
                                                                                            <i class="bi bi-reply-fill text-primary"></i>
                                                                                            관리자 답변
                                                                                            <small class="text-muted ms-2">
                                                                                                <fmt:formatDate value="${inquiry.replyDate}" pattern="yyyy-MM-dd HH:mm" />
                                                                                            </small>
                                                                                        </div>
                                                                                        <div class="reply-content">
                                                                                            <c:out value="${inquiry.replyContent}" />
                                                                                        </div>
                                                                                    </div>
                                                                                </c:if>
                                                                            </div>
                                                                        </div>
                                                                    </c:forEach>
                                                                    
                                                                    <%-- 페이징 처리 (필요시) --%>
                                                                    <c:if test="${not empty totalPages and totalPages > 1}">
                                                                        <nav aria-label="Page navigation" class="mt-4">
                                                                            <ul class="pagination justify-content-center">
                                                                                <c:if test="${currentPage > 1}">
                                                                                    <li class="page-item">
                                                                                        <a class="page-link" href="${pageContext.request.contextPath}/mypage/my-inquiry?page=${currentPage - 1}">이전</a>
                                                                                    </li>
                                                                                </c:if>
                                                                                
                                                                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                                                        <a class="page-link" href="${pageContext.request.contextPath}/mypage/my-inquiry?page=${i}">${i}</a>
                                                                                    </li>
                                                                                </c:forEach>
                                                                                
                                                                                <c:if test="${currentPage < totalPages}">
                                                                                    <li class="page-item">
                                                                                        <a class="page-link" href="${pageContext.request.contextPath}/mypage/my-inquiry?page=${currentPage + 1}">다음</a>
                                                                                    </li>
                                                                                </c:if>
                                                                            </ul>
                                                                        </nav>
                                                                    </c:if>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="no-data-message text-center p-5">
                                                                        <i class="bi bi-chat-square-text fa-3x text-muted mb-3"></i>
                                                                        <p class="lead">작성하신 문의가 없습니다.</p>
                                                                        <p class="text-muted mb-4">궁금한 사항이 있으시면 언제든지 문의해 주세요.</p>
                                                                        <a href="${pageContext.request.contextPath}/inquiry/write" 
                                                                           class="write-inquiry-btn">
                                                                            <i class="bi bi-plus-circle"></i>
                                                                            첫 문의 작성하기
                                                                        </a>
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
                </body>

                </html>