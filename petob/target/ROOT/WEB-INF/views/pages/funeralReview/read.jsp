<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLine", "\n"); %>

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
                <%-- 게시글 보기 --%>
                <c:if test="${not empty post}">
                <div class="card mb-3">
                    <div class="card-header">
                        <strong>${post.reviewTitle}</strong>
                    </div>
                    <div class="card-body">
                        <%-- 아이디, 이름 등 기본 정보 --%>
                        <div class="mb-3 text-muted small">
                            아이디: ${post.userId} | 이름: ${post.username}
                        </div>
                        <%-- 장례일, 장소 정보 --%>
                        <div class="mb-3 text-muted small">
                            장례일: <fmt:formatDate value="${post.funeralDate}" pattern="yyyy-MM-dd"/> | 장소: ${post.location}
                        </div>
                        <%-- 작성일, 수정일 정보 --%>
                        <div class="mb-3 text-muted small">
                            작성일: <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/> |
                            수정일: <fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>

                        <%-- 첨부파일 다운로드 링크 --%>
                        <c:if test="${not empty post.fileName}">
                            <div class="mb-3">
                                첨부파일: <a href="${pageContext.request.contextPath}/funeral-reviews/${post.id}/download" class="btn btn-sm btn-outline-primary">${post.originalFileName}</a>
                            </div>
                        </c:if>

                        <%-- === 여기에 첨부 이미지 표시 코드 추가 === --%>
                        <c:if test="${not empty post.fileName}">
                            <c:set var="fileNameLower" value="${fn:toLowerCase(post.fileName)}" />
                            <c:if test="${fn:endsWith(fileNameLower, '.jpg') || fn:endsWith(fileNameLower, '.jpeg') || fn:endsWith(fileNameLower, '.png') || fn:endsWith(fileNameLower, '.gif')}">
                                <div style="text-align: left; margin: 20px 0;">
                                    <img src="${pageContext.request.contextPath}/funeral-reviews/image/${post.fileName}"
                                         alt="첨부 이미지 - ${post.originalFileName}"
                                         style="max-width: 100%; width: 500px; height: auto; margin: 25px; border: 1px solid #ddd;" />
                                </div>
                            </c:if>
                        </c:if>

                        <%-- 본문 내용 --%>
                        <div class="mb-3" style="min-height: 200px;">
                            ${post.reviewContent}
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/funeral-reviews" class="btn btn-primary">목록</a>
                        <c:if test="${(not empty sessionScope.userId and post.userId eq sessionScope.userId) or (not empty sessionScope.role and sessionScope.role eq 'ADMIN')}">
                            <a href="${pageContext.request.contextPath}/funeral-reviews/${post.id}/update" class="btn btn-warning">수정</a>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
                        </c:if>
                    </div>
                </div>
                </c:if>
                <c:if test="${empty post}">
                    <p class="text-center">해당 게시글을 찾을 수 없습니다.</p>
                </c:if>
                <%--// 게시글 보기 --%>
            </div>
        </div>
        <%--// 페이지 내용 --%>
    </div>

    <%-- 삭제 모달 (현재 로그인한 사용자가 글 작성자이거나 관리자일 경우에만 렌더링) --%>
    <c:if test="${not empty post and ((not empty sessionScope.userId and post.userId eq sessionScope.userId) or (not empty sessionScope.role and sessionScope.role eq 'ADMIN'))}">
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="deleteForm" action="${pageContext.request.contextPath}/funeral-reviews/${post.id}/delete" method="POST">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5 text-danger" id="deleteModalLabel">
                            <strong>게시글 삭제</strong>
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-danger">게시글을 정말 삭제하시겠습니까?<br>삭제된 데이터는 복구할 수 없습니다.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-danger">삭제</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    </c:if>
    <%--// 삭제 모달 --%>

    <%-- 자바스크립트 --%>
    <%@ include file="../../common/script.jsp" %>
    <%--// 자바스크립트 --%>
</body>
</html>