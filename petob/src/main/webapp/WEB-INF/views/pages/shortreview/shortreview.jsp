<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PetOb - 한 마디 남기기</title>
    
    <%-- 공통 CSS 및 Bootstrap 등 라이브러리 포함 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    
    <%-- 이 페이지 전용 스타일 --%>
    <style>
        .review-section {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
        }
        .review-section h2 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 2rem;
            text-align: center;
        }
        .review-form .form-control {
            border-radius: 20px 0 0 20px;
        }
        .review-form .btn {
            border-radius: 0 20px 20px 0;
        }
        .review-item {
            border-bottom: 1px solid #f0f0f0;
            padding: 1rem 0;
        }
        .review-item:last-child {
            border-bottom: none;
        }
        .review-author {
            font-weight: 600;
            color: #333;
        }
        .review-date {
            font-size: 0.85em;
            color: #888;
        }
        .review-content {
            color: #555;
            margin-top: 5px;
            word-wrap: break-word;
        }
        .flash-message {
            animation: fadeOut 5s forwards;
        }
        @keyframes fadeOut {
            0% { opacity: 1; }
            80% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <div class="review-section">
                <h2>💬 소중한 한 마디</h2>

                <%-- Controller에서 전달된 성공/에러 메시지 표시 --%>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success flash-message" role="alert">
                        ${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger flash-message" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>

                <%-- 한 마디 작성 폼 (로그인한 경우에만 표시) --%>
                <c:if test="${not empty sessionScope.userId}">
                    <form action="<c:url value='/short-reviews/create'/>" method="post" class="mb-4 review-form">
                        <div class="input-group">
                            <input type="text" name="content" class="form-control" placeholder="따뜻한 한 마디를 남겨주세요." required maxlength="200" aria-label="한 마디 입력">
                            <button class="btn btn-outline-primary" type="submit">남기기</button>
                        </div>
                    </form>
                </c:if>

                <%-- 한 마디 목록 --%>
                <div class="review-list mt-4">
                    <c:choose>
                        <c:when test="${not empty shortReviews and fn:length(shortReviews) > 0}">
                            <c:forEach items="${shortReviews}" var="review">
                                <div class="review-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="review-author">${review.maskedUserId}</span>
                                        <span class="review-date ms-2">
                                            <fmt:formatDate value="${review.updatedAt}" pattern="yyyy.MM.dd HH:mm"/>
                                        </span>
                                        <p class="review-content mb-0">${fn:escapeXml(review.content)}</p>
                                    </div>

                                    <%-- 삭제 버튼 (작성자 본인 또는 관리자에게만 보임) --%>
                                    <c:if test="${sessionScope.userId eq review.userId or sessionScope.role eq 'ADMIN'}">
                                        <form action="<c:url value='/short-reviews/delete/${review.id}'/>" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" class="ms-3">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">&times;</button>
                                        </form>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center p-5 text-muted">
                                <p>아직 등록된 한 마디가 없습니다.<br>첫 번째 글을 남겨보세요!</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>