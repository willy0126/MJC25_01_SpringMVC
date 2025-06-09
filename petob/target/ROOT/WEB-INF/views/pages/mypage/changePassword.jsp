<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>비밀번호 변경</title>
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
                                    <li class="nav-item"><a href="<c:url value='/mypage/edit'/>">개인정보 수정</a></li>
                                    <li class="nav-item active"><a href="<c:url value='/mypage/change-password'/>">비밀번호
                                            변경</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/withdraw'/>">회원 탈퇴</a></li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="mypage-content">
                            <h2>비밀번호 변경</h2>
                            <p class="sub-text">새로운 비밀번호를 설정하여 계정을 안전하게 보호하세요.</p>
                            <hr class="title-divider">

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success" role="alert">${successMessage}</div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">${errorMessage}</div>
                            </c:if>

                            <section class="password-change-container">
                                <form action="<c:url value='/mypage/change-password'/>" method="post">
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">현재 비밀번호</label>
                                        <input type="password" class="form-control" id="currentPassword"
                                            name="currentPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">새 비밀번호</label>
                                        <input type="password" class="form-control" id="newPassword" name="newPassword"
                                            required minlength="6">
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmNewPassword" class="form-label">새 비밀번호 확인</label>
                                        <input type="password" class="form-control" id="confirmNewPassword"
                                            name="confirmNewPassword" required minlength="6">
                                    </div>
                                    <button type="submit" class="btn btn-primary mt-3">비밀번호 변경</button>
                                    <a href="<c:url value='/mypage'/>" class="btn btn-secondary mt-3">취소</a>
                                </form>
                            </section>
                        </main>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div>
        </body>
        </html>