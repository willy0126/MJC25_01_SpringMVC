<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp" />
            <title>내 문의 목록 - Star's Haven</title>
            <link rel="stylesheet" href="<c:url value='/resources/css/inquiry/myliststyle.css'/>" />
        </head>

        <body>
            <div class="page-wrapper">
                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
                <main class="main-wrapper">
                    <div class="inquiry-container">
                        <h2>내 문의 목록</h2>
                        <c:if test="${not empty errorMessage}">
                            <div class="error-message">${errorMessage}</div>
                        </c:if>
                        <c:if test="${empty inquiryList}">
                            <div class="empty-state">
                                <p>작성한 문의가 없습니다.</p>
                                <a href="<c:url value='/inquiry/write'/>" class="btn btn-primary">문의 작성</a>
                            </div>
                        </c:if>
                        <c:if test="${not empty inquiryList}">
                            <table class="inquiry-table">
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>카테고리</th>
                                        <th>작성일</th>
                                        <th>상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
                                        <tr>
                                            <td>${totalCount - ((currentPage - 1) * pageSize + status.index)}</td>
                                            <td><a
                                                    href="<c:url value='/inquiry/view/${inquiry.inquiryId}'/>">${inquiry.title}</a>
                                            </td>
                                            <td>${inquiry.category}</td>
                                            <td>
                                                <fmt:formatDate value="${inquiry.createdDate}" pattern="yyyy-MM-dd" />
                                            </td>
                                            <td>${inquiry.status}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- 페이지네이션 생략 가능, 필요시 추가 -->
                        </c:if>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div>
        </body>

        </html>