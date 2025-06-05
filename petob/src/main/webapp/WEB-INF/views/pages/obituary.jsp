<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>부고장 작성 - Star's Haven, 반려동물 장례식장</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/infostyle.css'/>" />
</head>
<body>
<div class="page-wrapper">
    
    <!-- (1) Navbar -->
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <main class="main-wrapper">
        <div class="site-container">
    <!-- (2) 메인 컨텐츠 -->
        이 부분에 부고장 폼을 작성하면 됩니다.
        </div>
    </main>
    <!-- (3) Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- (4) Scripts -->
    <jsp:include page="/WEB-INF/views/common/script.jsp" />

</body>
</html>