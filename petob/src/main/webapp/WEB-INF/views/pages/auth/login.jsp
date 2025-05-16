<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>로그인 - Star's Haven, 반려동물 장례식장</title>

    <link rel="stylesheet" href="<c:url value='/resources/css/loginstyle.css'/>" />
</head>

<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
        <div class="login-container">
            <h2>로그인</h2>
            <form action="/login" method="post">
                <div class="form-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="userId" required>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit">로그인</button>

            </form>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
            <div class="error-message"><%= errorMessage %></div>
            <%
                }
            %>
            <div class="link-to-register">
                계정이 없으신가요? <a href="register">회원가입</a>
                <p><a href="/find-user-id" class="btn btn-warning">아이디 찾기</a>
                <a href="/reset-password" class="btn btn-danger">비밀번호 초기화</a></p>
            </div>
        </div>
        </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
</body>
</html>