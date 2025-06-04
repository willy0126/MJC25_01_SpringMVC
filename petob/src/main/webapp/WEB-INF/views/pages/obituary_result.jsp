<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>반려동물 부고장</title>
    <style>
        body {
            background: #e6f4ff;
            font-family: '맑은 고딕', sans-serif;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .obituary-card {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 480px;
        }

        .obituary-card img {
            width: 220px;
            height: 220px;
            object-fit: cover;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .obituary-card h2 {
            font-size: 28px;
            margin-bottom: 10px;
            color: #007acc;
        }

        .obituary-card .label {
            font-weight: bold;
            color: #555;
        }

        .obituary-card p {
            margin: 10px 0;
            line-height: 1.5;
            color: #444;
        }

        .obituary-card .date {
            font-size: 0.85em;
            color: #888;
            margin-top: 20px;
        }

        .qr-button {
            margin-top: 25px;
        }

        .qr-button button {
            padding: 10px 20px;
            background-color: #007acc;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }

        .qr-section {
            margin-top: 20px;
        }

        .qr-section img {
            margin-top: 10px;
            width: 160px;
            height: 160px;
        }
    </style>
</head>
<body>
<div class="obituary-card">

    <c:if test="${not empty obituary.photoPath}">
        <img src="${pageContext.request.contextPath}${obituary.photoPath}" alt="반려동물 사진" />
    </c:if>

    <h2>${obituary.petName}</h2>

    <p><span class="label">이별한 날:</span> 
        <fmt:formatDate value="${obituary.passedDate}" pattern="yyyy-MM-dd"/>
    </p>

    <p><span class="label">추모 메시지:</span></p>
    <p>${obituary.message}</p>

    <p class="date">
        <span class="label">작성일:</span> 
        <fmt:formatDate value="${obituary.createdAt}" pattern="yyyy-MM-dd"/>
    </p>

    <div class="qr-button">
        <form method="get" action="${pageContext.request.contextPath}/obituary/qrcode">
            <button type="submit">QR 코드 생성</button>
        </form>
    </div>

    <c:if test="${not empty qrCodePath}">
        <div class="qr-section">
            <p>부고장 QR 코드</p>
            <img src="${pageContext.request.contextPath}${qrCodePath}" alt="QR 코드" />
        </div>
    </c:if>

</div>
</body>
</html>



