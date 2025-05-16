<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>예약하기</title>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

    <script>
    $(function() {
        // 날짜 선택: 오늘 이후만 가능
        $("#datePicker").datepicker({
            dateFormat: 'yy-mm-dd',
            minDate: 0 // 오늘부터 선택 가능
        });
    });
    </script>
</head>
<body>
    <h2>예약하기</h2>

    <form:form method="post" modelAttribute="reservation">

        이름: <form:input path="name"/><br/><br/>
        전화번호: <form:input path="phone"/><br/><br/>

        예약 날짜:
        <form:input path="date" id="datePicker" readonly="true"/><br/><br/>

        예약 시간:
        <form:select path="time">
            <form:option value="">시간 선택</form:option>
            <form:option value="10:00">09:00</form:option>
            <form:option value="10:00">10:00</form:option>
            <form:option value="11:00">11:00</form:option>
            <form:option value="12:00">12:00</form:option>
            <form:option value="13:00">13:00</form:option>
            <form:option value="14:00">14:00</form:option>
            <form:option value="15:00">15:00</form:option>
            <form:option value="16:00">16:00</form:option>
            <form:option value="17:00">17:00</form:option>
        </form:select><br/><br/>

        인원수: <form:input path="numberOfPeople" type="number" min="1"/><br/><br/>

        <input type="submit" value="예약하기"/>
    </form:form>
</body>
</html>
