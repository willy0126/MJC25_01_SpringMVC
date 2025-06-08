<!-- inquiry/view.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <jsp:include page="/WEB-INF/views/common/head.jsp" />
                <title>문의 상세 보기 - Star's Haven</title>
                <link rel="stylesheet" href="<c:url value='/resources/css/inquiry/viewstyle.css'/>" />
                <style>
                    .status-badge {
                        display: inline-block;
                        padding: 4px 12px;
                        border-radius: 20px;
                        font-size: 14px;
                        font-weight: bold;
                        text-align: center;
                    }

                    .status-waiting {
                        background-color: #fff3cd;
                        color: #856404;
                        border: 1px solid #ffeaa7;
                    }

                    .status-completed {
                        background-color: #d4edda;
                        color: #155724;
                        border: 1px solid #c3e6cb;
                    }

                    .inquiry-reply {
                        margin-top: 20px;
                        padding: 15px;
                        background-color: #f8f9fa;
                        border-left: 4px solid #007bff;
                        border-radius: 4px;
                    }

                    .reply-meta {
                        font-size: 12px;
                        color: #6c757d;
                        margin-top: 10px;
                        font-style: italic;
                    }

                    .date-info {
                        display: flex;
                        gap: 20px;
                        flex-wrap: wrap;
                    }

                    .date-item {
                        display: flex;
                        flex-direction: column;
                        gap: 5px;
                    }

                    .date-item label {
                        font-weight: bold;
                        color: #495057;
                    }

                    .weekday {
                        font-size: 12px;
                        color: #6c757d;
                    }
                </style>
            </head>

            <body>
                <div class="page-wrapper">
                    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
                    <main class="main-wrapper">
                        <div class="inquiry-container">
                            <h2>문의 정보</h2>
                            <c:if test="${not empty errorMessage}">
                                <div class="error-message">${errorMessage}</div>
                            </c:if>
                            <c:if test="${not empty inquiry}">
                                <div class="inquiry-detail">
                                    <div class="inquiry-field">
                                        <label>제목:</label>
                                        <p>${inquiry.title}</p>
                                    </div>
                                    <div class="inquiry-field">
                                        <label>카테고리:</label>
                                        <p>${inquiry.category}</p>
                                    </div>
                                    <div class="inquiry-field">
                                        <label>내용:</label>
                                        <p>${inquiry.content}</p>
                                    </div>

                                    <!-- 작성일 표시 -->
                                    <div class="inquiry-field">
                                        <label>작성일:</label>
                                        <c:choose>
                                            <c:when test="${not empty inquiry.createdDateFormatted}">
                                                <span class="date-unified">
                                                    ${inquiry.createdDateFormatted}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="date-unified">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- 상태 표시 (배지 스타일) -->
                                    <div class="inquiry-field">
                                        <label>상태:</label>
                                        <c:choose>
                                            <c:when
                                                test="${inquiry.status == '답변완료' || not empty inquiry.replyContent}">
                                                <span class="status-badge status-completed">✓ 답변완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-waiting">⏳ 답변대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- 관리자 답변 섹션 (내용 밑에 배치) -->
                                    <c:if test="${not empty inquiry.replyContent}">
                                        <div class="inquiry-reply">
                                            <h4>📝 관리자 답변</h4>
                                            <p>${inquiry.replyContent}</p>
                                            <div class="reply-meta">
                                                답변자: ${not empty inquiry.replyBy ? inquiry.replyBy : '관리자'} |
                                                답변일:
                                                <c:choose>
                                                    <c:when test="${not empty inquiry.replyDate}">
                                                        <c:catch var="replyDateException">
                                                            <fmt:formatDate value="${inquiry.replyDate}"
                                                                pattern="yyyy-MM-dd HH:mm" />
                                                        </c:catch>
                                                        <c:if test="${not empty replyDateException}">
                                                            ${inquiry.replyDate}
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        날짜 정보 없음
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- 관리자 답변 작성 폼 (답변이 없을 때만 표시) -->
                                    <c:if test="${canReply && empty inquiry.replyContent}">
                                        <div class="admin-reply">
                                            <h4>답변 작성</h4>
                                            <form action="<c:url value='/inquiry/reply'/>" method="post">
                                                <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
                                                <textarea name="reply" placeholder="답변을 입력하세요..." required
                                                    rows="5"></textarea>
                                                <button type="submit" class="btn btn-primary">답변 등록</button>
                                            </form>
                                        </div>
                                    </c:if>

                                    <!-- 관리자 답변 수정 폼 (이미 답변이 있고 수정 권한이 있을 때) -->
                                    <c:if test="${canReply && not empty inquiry.replyContent}">
                                        <div class="admin-reply">
                                            <h4>답변 수정</h4>
                                            <form action="<c:url value='/inquiry/reply'/>" method="post">
                                                <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
                                                <textarea name="reply" placeholder="답변을 수정하세요..." required
                                                    rows="5">${inquiry.replyContent}</textarea>
                                                <button type="submit" class="btn btn-primary">답변 수정</button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>

                            <div class="button-group">
                                <c:if test="${canEdit}">
                                    <a href="<c:url value='/inquiry/edit/${inquiry.inquiryId}'/>"
                                        class="btn btn-primary">✏️ 수정하기</a>
                                </c:if>
                                <a href="<c:url value='/inquiry/list'/>" class="btn btn-secondary">📋 목록</a>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                </div>
            </body>

            </html>