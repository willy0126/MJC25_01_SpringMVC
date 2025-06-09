<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp" />
            <title>부고장 작성 - Star's Haven, 반려동물 장례식장</title>
            <!-- 부고장 전용 CSS -->
            <link rel="stylesheet" href="<c:url value='/resources/css/obituarystyle.css'/>" />
        </head>

        <body>
            <div class="page-wrapper">

                <!-- (1) Navbar -->
                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                <main class="main-wrapper">
                    <div class="site-container">
                        <form action="${pageContext.request.contextPath}/obituary/submit" method="post"
                            enctype="multipart/form-data" class="obituary-form">
                            <div class="form-group">
                                <label for="petName">반려동물 이름</label>
                                <input type="text" id="petName" name="petName" required />
                            </div>

                            <div class="form-group">
                                <label for="passedDate">사망일</label>
                                <input type="date" id="passedDate" name="passedDate" required />
                            </div>

                            <div class="form-group">
                                <label for="message">추모 메시지</label>
                                <textarea id="message" name="message" rows="5" required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="photo">사진 업로드 (선택)</label>
                                <input type="file" id="photo" name="photo" accept="image/*" />
                            </div>

                            <div class="form-group">
                                <button type="submit" class="submit-btn">부고장 작성</button>
                            </div>
                        </form>
                    </div>
                </main>

                <!-- (3) Footer -->
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />

                <!-- (4) Scripts -->
                <jsp:include page="/WEB-INF/views/common/script.jsp" />
            </div>
        </body>

        </html>