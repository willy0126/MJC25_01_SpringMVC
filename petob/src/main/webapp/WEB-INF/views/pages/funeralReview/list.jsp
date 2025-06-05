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
                    <%-- action 경로 수정 --%>
                    <form action="${pageContext.request.contextPath}/funeral-reviews" method="get">
                        <div class="input-group">
                            <select name="searchType" class="form-select" style="width: 120px;">
                                <option value="reviewTitle" ${searchType == 'reviewTitle' ? 'selected' : ''}>제목</option>
                                <option value="reviewContent" ${searchType == 'reviewContent' ? 'selected' : ''}>내용</option>
                                <option value="username" ${searchType == 'username' ? 'selected' : ''}>작성자명</option> <%-- FuneralReviewDTO에 username 필드 있음 --%>
                                <option value="location" ${searchType == 'location' ? 'selected' : ''}>장소</option> <%-- FuneralReviewDTO에 location 필드 있음 --%>
                                <option value="userId" ${searchType == 'userId' ? 'selected' : ''}>작성자ID</option>
                                <option value="all" ${empty searchType or searchType == 'all' ? 'selected' : ''}>전체</option>
                            </select>
                            <input type="text" name="searchKeyword" class="form-control" value="${searchKeyword}" placeholder="검색어를 입력하세요" style="width: 300px;">
                            <button type="submit" class="btn btn-primary">검색</button>
                            <c:if test="${not empty searchKeyword}">
                                <%-- 취소 버튼 경로 수정 --%>
                                <a href="${pageContext.request.contextPath}/funeral-reviews" class="btn btn-danger">취소</a>
                            </c:if>
                        </div>
                    </form>
                    <%--// 검색 --%>

                    <%-- 등록 버튼 --%>
                    <%-- 등록 버튼 경로 수정 --%>
                    <a href="${pageContext.request.contextPath}/funeral-reviews/create" class="btn btn-primary">등록</a>
                    <%--// 등록 버튼 --%>
                </div>
                <%--// 검색, 등록 버튼 --%>

                <%-- 게시글 목록 --%>
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>수정일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${posts}" var="post">
                            <tr>
                                <td>${post.id}</td>
                                <%-- 제목 링크 경로 수정 --%>
                                <td><a href="${pageContext.request.contextPath}/funeral-reviews/${post.id}">${post.reviewTitle}</a></td>
                                <td>${post.username}</td> <%-- FuneralReviewDTO에 username 필드 있음 --%>
                                <td><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty posts}">
                            <tr>
                                <td colspan="5" class="text-center">게시글이 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                <%--// 게시글 목록 --%>

                <%-- 페이지네이션 --%>
                <c:if test="${not empty posts and pagination.totalPages > 0}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <%-- 이전 페이지 --%>
                        <c:if test="${pagination.currentPage > 1}">
                            <li class="page-item">
                                <%-- 페이지네이션 링크 경로 수정 --%>
                                <a class="page-link" href="${pageContext.request.contextPath}/funeral-reviews?page=1<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">처음</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/funeral-reviews?page=${pagination.currentPage - 1}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">이전</a>
                            </li>
                        </c:if>
                        <%--// 이전 페이지 --%>

                        <%-- 페이지 번호 --%>
                        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="pageNumber">
                            <li class="page-item <c:if test='${pageNumber == pagination.currentPage}'>active</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/funeral-reviews?page=${pageNumber}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">${pageNumber}</a>
                            </li>
                        </c:forEach>
                        <%--// 페이지 번호 --%>

                        <%-- 다음 페이지 --%>
                        <c:if test="${pagination.currentPage < pagination.totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/funeral-reviews?page=${pagination.currentPage + 1}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">다음</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/funeral-reviews?page=${pagination.totalPages}<c:if test='${not empty searchKeyword}'>&searchType=${searchType}&searchKeyword=${searchKeyword}</c:if>">마지막</a>
                            </li>
                        </c:if>
                        <%--// 다음 페이지 --%>
                    </ul>
                </nav>
                </c:if>
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