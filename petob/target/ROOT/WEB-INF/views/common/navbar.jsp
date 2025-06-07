<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 환영 메시지와 기존 링크 사이의 간격을 위한 스타일 추가 */
    .auth-links {
        display: flex;
        align-items: center; /* 세로 정렬을 위해 추가 */
        gap: 10px; /* 링크 사이의 간격 */
    }
    .welcome-message {
        color: #333; /* 텍스트 색상 */
        font-weight: 500; /* 폰트 굵기 */
        margin-right: 10px; /* 오른쪽 마이페이지 링크와의 간격 */
        white-space: nowrap; /* 줄바꿈 방지 */
    }
</style>

<div class="navbar-container">

  <div class="navbar-left">
    <a href="${pageContext.request.contextPath}/">
      <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="로고" class="logo-img">
    </a>
  </div>

  <div class="navbar-right">

    <div class="auth-links">
      <c:choose>
        
        <c:when test="${empty sessionScope.userId}">
          <a href="${pageContext.request.contextPath}/login" class="auth-link">로그인</a>
          <a href="${pageContext.request.contextPath}/register" class="auth-link">회원가입</a>
        </c:when>
      
        <c:otherwise>
          <%-- 로그인 시 환영 메시지 표시 --%>
          <span class="welcome-message">${sessionScope.username}님, 소중한 기억과 함께합니다.</span>
            <%-- 역할(role)에 따라 다른 링크 표시 --%>
            <c:choose>
                <c:when test="${sessionScope.userId == 'admin'}">
                    <%-- 관리자(ADMIN)일 경우 --%>
                    <%-- TODO: 실제 관리자 콘솔 페이지 경로로 수정해주세요. --%>
                    <a href="${pageContext.request.contextPath}/admin/console" class="auth-link"><b>CONSOLE</b></a>
                </c:when>
                <c:otherwise>
                    <%-- 일반 사용자일 경우 --%>
                    <a href="${pageContext.request.contextPath}/mypage" class="auth-link">마이페이지</a>
                </c:otherwise>
            </c:choose>
            
            <a href="${pageContext.request.contextPath}/logout" class="auth-link">로그아웃</a>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="menu-links">
      <div class="menu-item">
        <a href="#" class="menu-link">이용 안내</a>
        <ul class="dropdown">
          <li><a href="${pageContext.request.contextPath}/info/procedure">절차 및 비용</a></li>
          <li><a href="${pageContext.request.contextPath}/info/obituary">부고장 작성 </a></li>
        </ul>
      </div>
      <div class="menu-item">
        <a href="#" class="menu-link">지점 소개</a>
        <ul class="dropdown">
          <li><a href="${pageContext.request.contextPath}/branches/mainbranch">본점</a></li>
          <li><a href="${pageContext.request.contextPath}/branches/subbranch1">홍대입구점</a></li>
          <li><a href="${pageContext.request.contextPath}/branches/subbranch2">서대문점</a></li>
        </ul>
      </div>
      <div class="menu-item">
        <a href="#" class="menu-link">커뮤니티</a>
        <ul class="dropdown">
          <li><a href="${pageContext.request.contextPath}/funeral-reviews">장례 후기</a></li>
          <li><a href="${pageContext.request.contextPath}/short-reviews">한 마디 나누기</a></li>
        </ul>
      </div>
      <div class="menu-item">
        <a href="${pageContext.request.contextPath}/location" class="menu-link">지점 위치</a>
      </div>
      <div class="menu-item">
        <a href="#" class="menu-link">고객센터</a>
        <ul class="dropdown">
          <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
          <li><a href="${pageContext.request.contextPath}/inquiry/list">문의 게시판</a></li>
          <li><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
        </ul>
      </div>

      <a href="${pageContext.request.contextPath}/reservation" class="reserve-button">상담 예약</a>

    </div>

  </div>

</div>