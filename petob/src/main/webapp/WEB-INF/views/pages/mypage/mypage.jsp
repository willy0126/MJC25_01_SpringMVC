<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 날짜 포맷팅을 위해 추가 --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - Star's Haven</title>
    <%-- 공통 스타일 및 라이브러리 --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"> <%-- 공통 메인 스타일 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypagestyle.css"> <%-- 마이페이지 전용 스타일 --%>
    <style>
        /* JSP 내 간단한 추가 스타일 (필요시 mypagestyle.css로 이동) */
        .mypage-sidebar .sidebar-nav .nav-item.active a {
            background-color: #0d6efd; /* Bootstrap primary color */
            color: white;
            font-weight: bold;
        }
        .password-verification-container .input-group .form-control {
            border-right: 0; /* 비밀번호 필드와 버튼 사이 선 제거 */
        }
        .password-verification-container .input-group .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
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
                    <h3 class="sidebar-title">내 정보 관리</h3>
                    <nav class="sidebar-nav">
                        <ul>
                            <li class="nav-item ${empty param.section or param.section == 'profile' ? 'active' : ''}">
                                <a href="${pageContext.request.contextPath}/mypage?section=profile">개인정보변경</a>
                            </li>
                            <li class="nav-item ${param.section == 'reservations' ? 'active' : ''}">
                                <a href="${pageContext.request.contextPath}/mypage?section=reservations">예약 확인</a>
                            </li>
                            <li class="nav-item ${param.section == 'withdrawal' ? 'active' : ''}">
                                <a href="${pageContext.request.contextPath}/mypage?section=withdrawal">회원 탈퇴</a>
                            </li>
                        </ul>
                    </nav>
                </aside>

                <%-- 오른쪽 콘텐츠 영역 --%>
                <main class="mypage-content">
                    <c:choose>
                        <%-- 1. 개인정보변경 섹션 (초기 진입 또는 'profile' 선택 시) --%>
                        <c:when test="${empty param.section or param.section == 'profile'}">
                            <c:choose>
                                <c:when test="${sessionScope.passwordVerifiedForProfile}">
                                    <%-- 비밀번호 확인 완료 후 실제 정보 수정 폼 --%>
                                    <div class="profile-edit-container">
                                        <h2>개인정보변경</h2>
                                        <p class="sub-text">회원님의 정보를 안전하게 수정하세요.</p>
                                        <hr class="title-divider">
                                        <%-- TODO: 실제 회원정보 수정 폼 구현 --%>
                                        <form action="${pageContext.request.contextPath}/user/update" method="post">
                                            <div class="mb-3">
                                                <label for="username" class="form-label">이름</label>
                                                <input type="text" class="form-control" id="username" name="username" value="${fn:escapeXml(sessionScope.username)}" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="userId" class="form-label">아이디</label>
                                                <input type="text" class="form-control" id="userId" name="userId" value="${fn:escapeXml(sessionScope.userId)}" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="newPassword" class="form-label">새 비밀번호 (변경 시 입력)</label>
                                                <input type="password" class="form-control" id="newPassword" name="password">
                                            </div>
                                            <div class="mb-3">
                                                <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                                            </div>
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">연락처</label>
                                                <input type="text" class="form-control" id="phone" name="phone" value="${fn:escapeXml(loginUser.phone)}"> {/* 컨트롤러에서 loginUser 정보 전달 필요 */}
                                            </div>
                                             <div class="mb-3">
                                                <label for="email" class="form-label">이메일</label>
                                                <input type="email" class="form-control" id="email" name="email" value="${fn:escapeXml(loginUser.email)}"> {/* 컨트롤러에서 loginUser 정보 전달 필요 */}
                                            </div>
                                            <button type="submit" class="btn btn-primary">정보 수정</button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <%-- 비밀번호 확인 요청 화면 --%>
                                    <div class="password-verification-container">
                                        <h2>개인정보변경</h2>
                                        <p class="sub-text">고객님의 개인정보보호를 위해 최선을 다하겠습니다.</p>
                                        <hr class="title-divider">
                                        <p class="instruction-text">고객님의 개인정보 보호를 위해 본인 확인을 진행합니다.<br><strong>현재 비밀번호</strong>를 입력해주세요.</p>
                                        <form action="${pageContext.request.contextPath}/mypage/verify-password" method="post" class="password-form">
                                            <input type="hidden" name="targetSection" value="profile">
                                            <div class="input-group mb-3">
                                                <input type="password" name="password" class="form-control" placeholder="현재 비밀번호 입력" aria-label="비밀번호 확인" required>
                                                <button type="submit" class="btn btn-primary">확인</button>
                                            </div>
                                            <c:if test="${not empty param.error and param.targetSection eq 'profile'}">
                                                <div class="alert alert-danger mt-2" role="alert">
                                                    비밀번호가 일치하지 않습니다.
                                                </div>
                                            </c:if>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>

                        <%-- 2. 예약 확인 섹션 --%>
                        <c:when test="${param.section == 'reservations'}">
                            <div class="reservations-container">
                                <h2>예약 확인</h2>
                                <p class="sub-text">고객님의 장례 예약 현황입니다.</p>
                                <hr class="title-divider">
                                <c:choose>
                                    <c:when test="${not empty funeralReservationList}">
                                        <div class="table-responsive">
                                            <table class="reservation-table table table-hover">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>지점</th>
                                                        <th>반려동물 이름</th>
                                                        <th>신청자명</th>
                                                        <th>연락처</th>
                                                        <th>장례일</th>
                                                        <th>장례시간</th>
                                                        <th style="min-width: 150px;">요청사항</th>
                                                        <th>신청일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="reservation" items="${funeralReservationList}">
                                                        <tr>
                                                            <td>${fn:escapeXml(reservation.branch)}</td>
                                                            <td>${fn:escapeXml(reservation.petName)}</td>
                                                            <td>${fn:escapeXml(reservation.applicantName)}</td>
                                                            <td>${fn:escapeXml(reservation.applicantPhone)}</td>
                                                            <td>${fn:escapeXml(reservation.obDate)}</td>
                                                            <td>${fn:escapeXml(reservation.obTime)}</td>
                                                            <td>${fn:escapeXml(reservation.notes)}</td>
                                                            <td><fmt:formatDate value="${reservation.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-reservations text-center p-5">
                                            <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                            <p class="lead">신청하신 장례 예약 내역이 없습니다.</p>
                                            <a href="${pageContext.request.contextPath}/obituary-reservation/form" class="btn btn-primary-action btn-lg">장례 예약하기</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>

                        <%-- 3. 회원 탈퇴 섹션 --%>
                        <c:when test="${param.section == 'withdrawal'}">
                             <c:choose>
                                <c:when test="${sessionScope.passwordVerifiedForWithdrawal}">
                                    <%-- 비밀번호 확인 완료 후 실제 탈퇴 진행 --%>
                                    <div class="withdrawal-container">
                                        <h2>회원 탈퇴</h2>
                                        <hr class="title-divider">
                                        <div class="alert alert-warning" role="alert">
                                            <h4 class="alert-heading"><i class="fas fa-exclamation-triangle"></i> 정말로 탈퇴하시겠습니까?</h4>
                                            <p>회원 탈퇴 시 회원님의 모든 정보는 관련 법령 및 개인정보처리방침에 따라 처리되며, 일부 정보는 복구가 불가능할 수 있습니다. 예약 정보 등 중요한 내용은 미리 백업해주시기 바랍니다.</p>
                                            <p class="mb-0">탈퇴 후에는 동일한 아이디로 재가입이 제한될 수 있습니다. 신중하게 결정해주세요.</p>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/user/delete" method="post" onsubmit="return confirm('정말로 회원에서 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.');" class="mt-4">
                                            <button type="submit" class="btn btn-danger btn-lg w-100">회원 탈퇴 진행</button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <%-- 비밀번호 확인 요청 화면 --%>
                                    <div class="password-verification-container">
                                        <h2>회원 탈퇴</h2>
                                        <p class="sub-text">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인합니다.</p>
                                        <hr class="title-divider">
                                        <p class="instruction-text">안전한 회원 탈퇴를 위해 <strong>현재 비밀번호</strong>를 입력해주세요.</p>
                                        <form action="${pageContext.request.contextPath}/mypage/verify-password" method="post" class="password-form">
                                            <input type="hidden" name="targetSection" value="withdrawal">
                                            <div class="input-group mb-3">
                                                <input type="password" name="password" class="form-control" placeholder="현재 비밀번호 입력" aria-label="비밀번호 확인" required>
                                                <button type="submit" class="btn btn-primary">확인</button>
                                            </div>
                                            <c:if test="${not empty param.error and param.targetSection eq 'withdrawal'}">
                                                <div class="alert alert-danger mt-2" role="alert">
                                                    비밀번호가 일치하지 않습니다.
                                                </div>
                                            </c:if>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </main>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JavaScript로 현재 선택된 사이드바 메뉴 활성화 (선택적)
        // CSS로도 처리 가능하며, JSP EL을 사용한 클래스 부여 방식이 더 간단할 수 있습니다.
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const section = urlParams.get('section') || 'profile'; // 기본값 profile
            const navLinks = document.querySelectorAll('.mypage-sidebar .sidebar-nav .nav-item a');

            navLinks.forEach(link => {
                link.parentElement.classList.remove('active');
                if (link.getAttribute('href').includes('section=' + section)) {
                    link.parentElement.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>