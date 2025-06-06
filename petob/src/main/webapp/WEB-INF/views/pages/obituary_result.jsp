<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>반려동물 부고장</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Nunito&display=swap');

        body {
            background: #e6f4ff;
            font-family: 'Nunito', '맑은 고딕', sans-serif;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .obituary-card {
            background: linear-gradient(to bottom, #ffffff, #f7fbff);
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 480px;
        }

        .logo-area {
            margin-bottom: 30px;
        }

        .logo-area img {
            width: 80px;
            display: block;
            margin: 0 auto 10px auto;
        }

        .logo-area span {
            font-size: 20px;
            font-weight: bold;
            color: #555;
        }

        .obituary-card img.pet-photo {
            width: 220px;
            height: 220px;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 40px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .obituary-card h2 {
            font-size: 28px;
            margin-bottom: 10px;
            color: #007acc;
        }

        .divider {
            width: 60px;
            border: 0;
            border-top: 2px solid #007acc;
            margin: 12px auto 24px;
        }

        .label {
            font-weight: bold;
            color: #6c6f93;
        }

        .info-line {
            text-align: left;
            margin: 20px 0;
        }

        .obituary-card .date {
            font-size: 0.9em;
            color: #888;
        }

        .footer-info {
            margin-top: 40px;
            font-size: 0.8em;
            color: #aaa;
            text-align: center;
        }

        .footer-source {
            font-size: 0.75em;
            color: #ccc;
            margin-top: 5px;
            text-align: center;
        }

        .paw-icon {
            font-size: 22px;
            color: #ddd;
            margin-top: 30px;
        }
    </style>
</head>
<body>
<div class="obituary-card" id="capture-target">

    <!-- 로고 + 텍스트 -->
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="로고" />
        <span>Star's Haven</span>
    </div>

    <!-- 반려동물 사진 -->
    <c:if test="${not empty obituary.photoPath}">
        <img class="pet-photo" src="${pageContext.request.contextPath}${obituary.photoPath}" alt="반려동물 사진" />
    </c:if>

    <!-- 이름 + 하단 강조선 -->
    <h2><c:out value="${obituary.petName}" /></h2>
    <hr class="divider" />

    <!-- 좌측 정렬 항목들 -->
    <p class="info-line">
        <span class="label">이별한 날:</span> 
        <fmt:formatDate value="${obituary.passedDate}" pattern="yyyy-MM-dd"/>
    </p>

    <p class="info-line"><span class="label">추모 메시지:</span></p>
    <p class="info-line"><c:out value="${obituary.message}" /></p>

    <p class="info-line date">
        <span class="label">작성일:</span> 
        <fmt:formatDate value="${obituary.createdAt}" pattern="yyyy-MM-dd"/>
    </p>

    <!-- 하단 안내 -->
    <div class="footer-info">
        본 페이지는 추모를 위한 목적으로 제작되었습니다.
    </div>
    <div class="footer-source">
        Star's Haven - 반려동물 장례 서비스
    </div>

    <!-- 감성용 아이콘 -->
    <div class="paw-icon">🐾</div>
</div>

<!-- html2canvas: 카드만 캡처 -->
<script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
<script>
    window.onload = function () {
        setTimeout(() => {
            const card = document.querySelector("#capture-target");
            html2canvas(card).then(canvas => {
                const link = document.createElement('a');
                link.download = 'obituary.png';
                link.href = canvas.toDataURL();
                link.click();
            });
        }, 1000);
    };
</script>

</body>
</html>











