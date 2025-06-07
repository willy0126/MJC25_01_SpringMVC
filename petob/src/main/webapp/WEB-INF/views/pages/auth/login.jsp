<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>로그인 - Petob</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/loginstyle.css'/>" />
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    <main class="main-wrapper">
        <div class="auth-container">
            <h2>로그인</h2>
            <form action="<c:url value='/login'/>" method="post">
                <div class="form-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary mt-3">로그인</button>
            </form>

            <%-- Flash Message (에러 또는 성공 메시지 표시) --%>
            <c:if test="${not empty param.error or not empty errorMessage or not empty successMessage}">
                <div class="flash-message ${not empty param.error or not empty errorMessage ? 'error' : 'success'}">
                    <c:choose>
                        <c:when test="${not empty errorMessage}">${errorMessage}</c:when>
                        <c:when test="${not empty successMessage}">${successMessage}</c:when>
                        <c:otherwise>아이디 또는 비밀번호가 올바르지 않습니다.</c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <%-- [수정됨] 클래스 이름을 .auth-helpers로 변경 --%>
            <div class="auth-helpers">
                <p>계정이 없으신가요? <a href="<c:url value='/register'/>">회원가입</a></p>
                <div class="link-group">
                    <a href="<c:url value='/find-user-id'/>">아이디 찾기</a>
                    <a href="<c:url value='/reset-password'/>">비밀번호 초기화</a>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>
<jsp:include page="/WEB-INF/views/common/script.jsp" />
</body>
</html>