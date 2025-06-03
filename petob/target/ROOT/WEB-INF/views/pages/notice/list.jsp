<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>공지사항 - Star's Haven, 반려동물 장례식장</title>
    
    <!-- 문의 게시판 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/noticestyle.css'/>" />
  
</head>

<body>
    <div class="page-wrapper">
        <!-- Navbar -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <div class="container">
                <!-- 페이지 제목 -->
                <div class="page-title-section" style="margin-top: 30px; margin-bottom: 30px; text-align: center;">
                    <h1>📢 공지사항</h1>
                    <p style="color: #6c757d; margin-top: 10px;">중요한 공지사항을 확인하세요</p>
                </div>
                
                <!-- 알림 메시지 -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>
                <c:if test="${param.error == 'unauthorized'}">
                    <div class="alert alert-error">⚠️ 관리자만 접근 가능합니다.</div>
                </c:if>
                <c:if test="${param.error == 'not_found'}">
                    <div class="alert alert-error">⚠️ 요청하신 공지사항을 찾을 수 없습니다.</div>
                </c:if>
                
                <!-- 관리자 컨트롤 -->
                <c:if test="${isAdmin}">
                    <div class="admin-controls">
                        <h4>🛠️ 관리자 메뉴</h4>
                        <a href="${contextPath}/notice/write" class="btn btn-success">✏️ 새 공지사항 작성</a>
                    </div>
                </c:if>
                
                <!-- 검색 영역 -->
                <div class="search-area">
                    <form method="get" action="${contextPath}/notice/search" class="search-form">
                        <input type="text" name="title" class="search-input" 
                               placeholder="제목으로 검색하세요..." 
                               value="${searchKeyword}">
                        <button type="submit" class="btn btn-primary">🔍 검색</button>
                        <c:if test="${not empty searchKeyword}">
                            <a href="${contextPath}/notice/list" class="btn btn-secondary">전체보기</a>
                        </c:if>
                    </form>
                </div>
                
                <!-- 검색 결과 표시 -->
                <c:if test="${not empty searchKeyword}">
                    <div class="alert alert-warning">
                        "<strong>${searchKeyword}</strong>" 검색 결과: 총 ${notices.size()}개의 공지사항이 있습니다.
                    </div>
                </c:if>
                
                <!-- 공지사항 테이블 -->
                <table class="notice-table">
                    <thead>
                        <tr>
                            <th style="width: 80px;">번호</th>
                            <th>제목</th>
                            <th style="width: 150px;">작성자</th>
                            <th style="width: 150px;">작성일</th>
                            <c:if test="${isAdmin}">
                                <th style="width: 120px;">관리</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty notices}">
                                <tr>
                                    <td colspan="${isAdmin ? '4' : '3'}" class="empty-notice">
                                        <div>
                                            <i>📋</i>
                                            <h3>등록된 공지사항이 없습니다</h3>
                                            <p>새로운 공지사항을 기다리고 있습니다.</p>
                                            <c:if test="${isAdmin}">
                                                <a href="${contextPath}/notice/write" class="btn btn-success">첫 공지사항 작성하기</a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="notice" items="${notices}" varStatus="status">
                                    <tr>
                                        <td data-label="번호"><strong>${status.count}</strong></td>
                                        <td data-label="제목">
                                            <a href="${contextPath}/notice/detail/${notice.id}" 
                                               class="notice-title">
                                                ${notice.title}
                                            </a>
                                        </td>
                                        <td data-label="작성일" class="notice-date">
                                            <fmt:formatDate value="${notice.createdDate}" pattern="yyyy-MM-dd"/>
                                            <br>
                                            <small><fmt:formatDate value="${notice.createdDate}" pattern="HH:mm"/></small>
                                        </td>
                                        <c:if test="${isAdmin}">
                                            <td data-label="관리" class="notice-actions">
                                                <a href="${contextPath}/notice/edit/${notice.id}" 
                                                   class="btn btn-primary btn-small">✏️ 수정</a>
                                                <form method="post" 
                                                      action="${contextPath}/notice/delete/${notice.id}" 
                                                      style="display: inline;" 
                                                      onsubmit="return confirmDelete('⚠️ 정말 삭제하시겠습니까?\\n삭제된 공지사항은 복구할 수 없습니다.');">
                                                    <button type="submit" class="btn btn-danger btn-small">🗑️ 삭제</button>
                                                </form>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
                <!-- 통계 정보 -->
                <c:if test="${not empty notices}">
                    <div style="margin-top: 20px; text-align: center; color: #6c757d; font-size: 0.9em;">
                        총 <strong>${notices.size()}</strong>개의 공지사항이 있습니다.
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <!-- 공통 스크립트 -->
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
    
    <!-- 공통 푸터 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>

