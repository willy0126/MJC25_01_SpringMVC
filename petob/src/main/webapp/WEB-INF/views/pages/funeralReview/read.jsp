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
                <div class="card mb-3">
                    <div class="card-header">
                        <strong>${FuneralReview.title}</strong>
                    </div>
                    <div class="card-body">
                        <div class="mb-3 text-muted">
                            아이디: ${FuneralReview.userId} | 이름: ${FuneralReview.username} | 전화번호: ${FuneralReview.phone} | 이메일: ${FuneralReview.email}
                        </div>
                        <div class="mb-3 text-muted">
                            등록일시: <fmt:formatDate value="${FuneralReview.createdAt}" pattern="yyyy-MM-dd HH:mm"/> | 수정일시: <fmt:formatDate value="${FuneralReview.updatedAt}" pattern="yyyy-MM-dd HH:mm"/>
                        </div>
                        <c:if test="${post.fileName != null}">
                            <div class="mb-3">
                                첨부파일: <a href="/FuneralReview-posts/${post.id}/download" class="btn btn-outline-primary">${post.originalFileName}</a>
                            </div>
                        </c:if>
                        <div class="mb-3">
                            ${post.content}
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="/FuneralReview-posts" class="btn btn-primary">목록</a>
                        <c:if test="${FuneralReview.userId eq sessionScope.userId}">
                            <a href="/FuneralReview-posts/${FuneralReview.id}/update" class="btn btn-warning">수정</a>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
                        </c:if>
                    </div>
                </div>
                <%--// 게시글 보기 --%>
            </div>
        </div>
        <%--// 페이지 내용 --%>
    </div>

    <c:if test="${post.userId eq sessionScope.userId}">
    <%-- 삭제 모달 --%>
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="deleteForm" action="/FuneralReview-posts/${post.id}/delete" method="POST">
                    <%-- modal-header --%>
                    <div class="modal-header">
                        <h1 class="modal-title fs-5 text-danger" id="deleteModalModalLabel">
                            <strong>게시글 삭제</strong>
                        </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <%--// modal-header --%>

                    <%-- modal-body --%>
                    <div class="modal-body">
                        <div class="mb-3">
                            <p class="text-danger">삭제된 데이터는 복구할 수 없습니다.</p>
                            <p>비밀번호를 입력해주세요.</p>
                        </div>
                        <div>
                            <input type="password" id="password" name="password" placeholder="비밀번호" class="form-control" required>
                        </div>
                    </div>
                    <%--// modal-body --%>

                    <%-- modal-footer --%>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-danger">삭제</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    </div>
                    <%--// modal-footer --%>
                </form>
            </div>
        </div>
    </div>
    <%-- 삭제 모달 --%>
    </c:if>

    <%-- 자바스크립트 --%>
    <%@ include file="../../common/script.jsp" %>
    <%--// 자바스크립트 --%>
</body>
</html>
