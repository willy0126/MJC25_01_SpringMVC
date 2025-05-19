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
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    <div class="page-wrapper">
        <main class="main-wrapper">
        <div class="login-container">
            <h2>로그인</h2>
            <form action="loginProcess.jsp" method="post">
                <div class="form-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="username" required>
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
                계정이 없으신가요? <a href="register.jsp">회원가입</a>
            </div>
        </div>
        </main>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
</body>
</html>