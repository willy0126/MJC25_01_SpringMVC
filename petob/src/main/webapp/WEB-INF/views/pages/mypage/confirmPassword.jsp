<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>비밀번호 확인</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/resources/css/mypagestyle.css'/>">
        </head>

        <body>
            <div class="page-wrapper">
                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                <div class="main-wrapper">
                    <div class="mypage-layout-container">
                        <aside class="mypage-sidebar">
                            <h3 class="sidebar-title">마이페이지</h3>
                            <nav class="sidebar-nav">
                                <ul>
                                    <li class="nav-item"><a href="<c:url value='/mypage'/>">예약 내역</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/my-inquiry'/>">나의 문의</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/edit'/>">개인정보 수정</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/change-password'/>">비밀번호 변경</a>
                                    </li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/withdraw'/>">회원 탈퇴</a></li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="mypage-content password-verification-container">
                            <c:choose>
                                <c:when test="${action == 'withdraw'}">
                                    <h2>회원 탈퇴</h2>
                                    <p class="instruction-text">안전한 회원 탈퇴를 위해 현재 비밀번호를 입력해주세요.</p>
                                </c:when>
                                <%-- 다른 action에 대한 제목/설명 추가 가능 --%>
                                    <c:otherwise>
                                        <h2>비밀번호 확인</h2>
                                        <p class="instruction-text">계정 보호를 위해 현재 비밀번호를 다시 한번 입력해주세요.</p>
                                    </c:otherwise>
                            </c:choose>
                            <hr class="title-divider">

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">${errorMessage}</div>
                            </c:if>

                            <form action="<c:url value='/mypage/confirm-password'/>" method="post"
                                class="password-form">
                                <input type="hidden" name="action" value="${action}">
                                <div class="input-group mb-3">
                                    <input type="password" class="form-control" id="password" name="password"
                                        placeholder="현재 비밀번호 입력" required>
                                    <button class="btn btn-primary" type="submit">확인</button>
                                </div>
                            </form>
                            <a href="<c:url value='/mypage'/>" class="btn btn-outline-secondary btn-sm">마이페이지로 돌아가기</a>
                        </main>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>