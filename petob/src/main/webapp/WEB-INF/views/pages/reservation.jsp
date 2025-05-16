<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>예약하기</title>
    <link rel="stylesheet" href="/css/reservation.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <script>
        $(function() {
            $("#datePicker").datepicker({
                dateFormat: 'yy-mm-dd',
                minDate: 0
            });
        });
    </script>
</head>
<body>

<div class="container">
    <h2>예약하기</h2>

    <form:form method="post" modelAttribute="reservation" action="/reservation">
        <label>이름</label>
        <form:input path="name" cssClass="input"/><br/>

        <label>날짜</label>
        <input type="text" id="datePicker" name="date" class="input"/><br/>

        <label>시간</label>
        <form:input path="time" cssClass="input"/><br/>

        <label>전화번호</label>
        <form:input path="phone" cssClass="input"/><br/>

        <input type="submit" value="예약하기" class="btn"/>
    </form:form>
</div>

</body>
</html>
