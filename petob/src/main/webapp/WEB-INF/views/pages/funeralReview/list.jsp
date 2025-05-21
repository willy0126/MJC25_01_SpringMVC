<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="../../common/head.jsp" %>
<body>
    <div class="container">
        <%-- 네비게이션 --%>
        <%@ include file="../../common/navbar.jsp" %>
        <%--// 네비게이션 --%>

        <%-- 페이지 제목 --%>
        <%@ include file="../../common/title.jsp" %>
        <%--// 페이지 제목 --%>

        <%-- 메시지 --%>
        <%@ include file="../../common/message.jsp" %>
        <%--// 메시지 --%>

        <%-- 페이지 내용 --%>
        <div class="row">
            <div class="col-12">
                <%-- 검색, 등록 버튼 --%>
                <div class="mb-3 d-flex justify-content-between">
                    <%-- 검색 --%>
                    <form action="/FuneralReview-posts" method="get">
                        <div class="input-group">
                            <select name="searchType" class="form-select" style="width: 120px;">
                                <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                                <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                                <option value="username" ${searchType == 'username' ? 'selected' : ''}>이름</option>
                                <option value="phone" ${searchType == 'phone' ? 'selected' : ''}>전화번호</option>
                                <option value="email" ${searchType == 'email' ? 'selected' : ''}>이메일</option>
                                <option value="all" <c:if test="${searchType == null}">selected</c:if>>전체</option>
                            </select>
                            <input type="text" name="searchKeyword" class="form-control" value="${searchKeyword}" placeholder="검색어를 입력하세요" style="width: 300px;">
                            <button type="submit" class="btn btn-primary">검색</button>
                            <c:if test="${searchKeyword != null}">
                                <a href="/FuneralReview-posts" class="btn btn-danger">취소</a>
                            </c:if>
                        </div>
                    </form>
                    <%--// 검색 --%>

                    <%-- 등록 버튼 --%>
                    <a href="/FuneralReview-posts/create/" class="btn btn-primary">등록</a>
                    <%--// 등록 버튼 --%>
                </div>
                <%--// 검색, 등록 버튼 --%>

                <%-- 게시글 목록 --%>
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>이름</th>
                            <th>생성일시</th>
                            <th>수정일시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${posts}" var="post">
                            <tr>
                                <td>${post.id}</td>
                                <td><a href="/FuneralReview-posts/${post.id}/">${post.title}</a></td>
                                <td>${post.username}</td>
                                <td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <%--// 게시글 목록 --%>

                <%-- 페이지네이션 --%>
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <%-- 이전 페이지 --%>
                        <c:if test="${pagination.currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="/FuneralReview-posts?page=1">처음</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="/FuneralReview-posts?page=${pagination.currentPage - 1}">이전</a>
                            </li>
                        </c:if>
                        <%--// 이전 페이지 --%>

                        <%-- 페이지 번호 --%>
                        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="pageNumber">
                            <li class="page-item">
                                <a class="page-link <c:if test='${pageNumber == pagination.currentPage}'>active</c:if>" href="/FuneralReview-posts?page=${pageNumber}">${pageNumber}</a>
                            </li>
                        </c:forEach>
                        <%--// 페이지 번호 --%>

                        <%-- 다음 페이지 --%>
                        <c:if test="${pagination.currentPage < pagination.totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="/FuneralReview-posts?page=${pagination.currentPage + 1}">다음</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="/FuneralReview-posts?page=${pagination.totalPages}">마지막</a>
                            </li>
                        </c:if>
                        <%--// 다음 페이지 --%>
                    </ul>
                </nav>
                <%--// 페이지네이션 --%>

            </div>
        </div>
        <%--// 페이지 내용 --%>
    </div>

    <%-- 자바스크립트 --%>
    <%@ include file="../../common/script.jsp" %>
    <%--// 자바스크립트 --%>
</body>
</html>

