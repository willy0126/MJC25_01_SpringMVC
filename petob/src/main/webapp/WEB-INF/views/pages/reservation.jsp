<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>간편 예약 - Star's Haven, 반려동물 장례식장</title>

    <link rel="stylesheet" href="<c:url value='/resources/css/reservationstyle.css'/>" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
   <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
   <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
   

<script>

    let reservedTimes = [];

    $(function () {
        // Datepicker 설정
        $("#datePicker").datepicker({
            dateFormat: "yy-mm-dd",
            minDate: 0,
            beforeShowDay: function (date) {
                const day = date.getDay();
                return [day !== 0 && day !== 6, ""];
            },
        });
      }
    )

</script>

</head>

<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
        <div class="reservation-container">
            <h2>간편 상담 예약</h2>
            <form action="/" method="post">
                <div class="form-group">
                    <label for="username">이름</label>
                    <input type="text" id="username" name="username" required  
                    pattern="[a-zA-Z가-힣\s]+" 
                    title="이름은 한글 또는 영문만 입력해주세요.">
                </div>
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="phone" id="phone" name="phone" required
                     pattern="[0-9]{9,11}" 
                     title="숫자만 입력해주세요 (9~11자리)">
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="date">날짜 선택</label>
                    <input type="text" id="datePicker" name="date" required>
                </div>

               <div class="form-group">
                    <label for="time">시간 선택</label>
                    <select id="time" name="time" required>
                    </select>

              </div>
                <button type="submit" id="submitBtn">예약하기</button>
            </form>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
            <div class="error-message"><%= errorMessage %></div>
            <%
                }
            %>
        </div>
        </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
    <script>
         const allTimes = [
        "09:00", "09:30", "10:00", "10:30",
        "11:00", "11:30", "12:00", "12:30",
        "13:00", "13:30", "14:00", "14:30",
        "15:00", "15:30", "16:00", "16:30",
        "17:00", "17:30", "18:00"
    ];

    document.addEventListener("DOMContentLoaded", function () {
        const select = document.getElementById("time");
        allTimes.forEach(time => {
            const option = document.createElement("option");
            option.value = time;
            option.textContent = time;
            select.appendChild(option);
        });
        console.log("✅ 시간 옵션 추가 완료");
    });
    </script>
</body>
</html>