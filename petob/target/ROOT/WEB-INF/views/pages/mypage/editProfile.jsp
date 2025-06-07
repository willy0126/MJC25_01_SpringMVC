<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>개인정보 수정</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/resources/css/mypagestyle.css'/>">
            <style>
                .profile-edit-container .form-label {
                    font-weight: 600;
                }
            </style>
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
                                    <li class="nav-item active"><a href="<c:url value='/mypage/edit'/>">개인정보 수정</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/change-password'/>">비밀번호 변경</a>
                                    </li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/withdraw'/>">회원 탈퇴</a></li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="mypage-content">
                            <h2>개인정보 수정</h2>
                            <p class="sub-text">회원님의 정보를 최신으로 관리하세요.</p>
                            <hr class="title-divider">

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success" role="alert">${successMessage}</div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">${errorMessage}</div>
                            </c:if>

                            <section class="profile-edit-container">
                                <form action="<c:url value='/mypage/edit'/>" method="post">
                                    <div class="mb-3">
                                        <label for="userId" class="form-label">아이디</label>
                                        <input type="text" class="form-control" id="userId" name="userId"
                                            value="${user.userId}" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="username" class="form-label">이름</label>
                                        <input type="text" class="form-control" id="username" name="username"
                                            value="${user.username}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">전화번호</label>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                            value="${user.phone}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">이메일</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="${user.email}" required>
                                    </div>

                                    <p class="form-text text-muted small">비밀번호 변경은 '비밀번호 변경' 메뉴를 이용해주세요.</p>

                                    <button type="submit" class="btn btn-primary mt-3">정보 수정</button>
                                    <a href="<c:url value='/mypage'/>" class="btn btn-secondary mt-3">취소</a>
                                </form>
                            </section>
                        </main>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>