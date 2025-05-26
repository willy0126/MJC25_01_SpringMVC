<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
          <a href="${pageContext.request.contextPath}/myPage" class="auth-link">마이페이지</a>
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
          <li><a href="#">장례 후기</a></li>
          <li><a href="#">한 마디 나누기</a></li>
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
          <li><a href="#">공지사항</a></li>
        </ul>
      </div>

      <!-- 상담 예약 버튼 (가장 오른쪽) -->
      <a href="${pageContext.request.contextPath}/reservation" class="reserve-button">상담 예약</a>

    </div>

  </div>

</div>
