<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>예약 조회 - Star's Haven</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/checkstyle.css'/>" />
</head>

<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <div class="reservation-container">
                <h2>예약 조회</h2>
                
                <!-- 에러/성공 메시지 -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="success-message">${successMessage}</div>
                </c:if>
                
                <!-- 예약 조회 폼 -->
                <c:if test="${empty reservations}">
                    <div class="reservation-info">
                        <h4>예약 조회 안내</h4>
                        <p>예약하실 때 입력하신 전화번호를 정확히 입력해주세요.</p>
                        <p>해당 전화번호로 등록된 모든 예약 내역을 확인하실 수 있습니다.</p>
                    </div>
                    
                    <form action="<c:url value='/reservation/check'/>" method="post">
                        <div class="form-group">
                            <label for="phone">전화번호</label>
                            <input type="text" id="phone" name="phone" required 
                                   placeholder="01012345678" 
                                   pattern="[0-9]{9,11}" 
                                   title="숫자만 입력해주세요 (9~11자리)"
                                   value="${phone}">
                        </div>
                        <button type="submit">예약 조회</button>
                    </form>
                </c:if>
                
                <!-- 예약 목록 -->
                <c:if test="${not empty reservations}">
                    <div class="reservation-info">
                        <h3><strong>${phone}</strong> 번호로 등록된 예약 (<strong>${reservations.size()}건</strong>)</h3>
                        <p>예약 정보를 확인해주세요. 변경이나 취소가 필요하시면 전화로 연락주시기 바랍니다.</p>
                    </div>
                    
                    <div class="reservation-list">
                        <c:forEach var="reservation" items="${reservations}" varStatus="status">
                            <div class="reservation-card">
                                <div class="reservation-header">
                                    <strong>예약번호: #${reservation.reservationId}</strong>
                                </div>
                                
                                <div class="reservation-details">
                                    <div class="detail-row">
                                        <span class="label">예약자명</span>
                                        <span class="value">${reservation.username}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span class="label">전화번호</span>
                                        <span class="value">${reservation.phone}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span class="label">이메일</span>
                                        <span class="value">${reservation.email}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span class="label">예약날짜</span>
                                        <span class="value">${reservation.date}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span class="label">예약시간</span>
                                        <span class="value">${reservation.time}</span>
                                    </div>
                                    <div class="detail-row">
                                        <span class="label">등록일시</span>
                                        <span class="value">
                                            <fmt:formatDate value="${reservation.createdAt}" 
                                                          pattern="yyyy-MM-dd HH:mm" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="form-actions">
                        <a href="<c:url value='/reservation/check'/>" class="btn-secondary">다시 조회</a>
                        <a href="<c:url value='/reservation'/>" class="btn-primary">새 예약</a>
                    </div>
                </c:if>
                
                <div class="navigation-links">
                    <a href="<c:url value='/reservation'/>">예약하기</a>
                    <a href="<c:url value='/'/>">메인으로</a>
                </div>
            </div>
        </main>
        
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
    
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
    
    <script>
        // 전화번호 입력 시 자동 포맷팅 (필요한 경우)
        document.getElementById('phone').addEventListener('input', function(e) {
            // 숫자만 남기기
            let value = e.target.value.replace(/[^\d]/g, '');
            
            // 11자리로 제한
            if (value.length > 11) {
                value = value.substring(0, 11);
            }
            
            e.target.value = value;
        });
        
        // 폼 제출 전 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            const phone = document.getElementById('phone').value.trim();
            
            if (!phone) {
                e.preventDefault();
                alert('전화번호를 입력해주세요.');
                return false;
            }
            
            if (phone.length < 9 || phone.length > 11) {
                e.preventDefault();
                alert('전화번호는 9~11자리로 입력해주세요.');
                return false;
            }
            
            // 숫자만 있는지 확인
            if (!/^[0-9]+$/.test(phone)) {
                e.preventDefault();
                alert('전화번호는 숫자만 입력해주세요.');
                return false;
            }
        });
    </script>
</body>
</html>