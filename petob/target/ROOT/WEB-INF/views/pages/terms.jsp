<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp"/>
    <title>이용 약관 - Star's Haven, 반려동물 장례식장</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/policystyle.css'/>"/>
</head>
<body>
<div class="page-wrapper">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
    <main class="main-wrapper">
        <div class="site-container">
            <section class="page-title-section">
                <h2>이용 약관</h2>
                <p>Star's Haven 웹사이트 이용에 대한 약관입니다. 서비스를 이용하시기 전에 다음 내용을 주의 깊게 읽어주시기 바랍니다.</p>
            </section>

            <section class="terms-section">
                <h3>제 1조: 총칙</h3>
                <p>[본 약관은 Star's Haven 웹사이트 이용에 관한 제반 사항을 규정함을 목적으로 합니다.]</p>
                <p>[본 약관은 서비스 화면에 게시하거나 기타의 방법으로 공지함으로써 효력이 발생합니다.]</p>
                <p>[이용자는 본 약관에 동의함으로써 서비스를 이용할 수 있습니다.]</p>
                <p>[약관의 개정 시에는 개정된 약관을 공지하며, 이용자는 이를 확인하여야 합니다.]</p>
                <p>[약관에 동의하지 않는 경우 서비스 이용을 중단하여야 하며, 계속 이용할 경우 약관에 동의한 것으로 간주합니다.]</p>
                <p><b>[해당 사이트는 실존하지 않는 서비스를 다룹니다. 사용자는 필히 이용 약관 및 유의 사항을 확인하시어 피해가 없도록 하시길 바랍니다.]</b></p>
            </section>

            <section class="terms-section">
                <h3>제 2조: 이용자의 의무</h3>
                <ul>
                    <li>[이용자는 관계 법령, 본 약관의 규정, 이용 안내 및 서비스와 관련하여 공지한 주의사항 등을 준수하여야 합니다.]</li>
                    <li>[허위 사실 기재, 타인의 정보 도용 등의 부정 행위를 하지 않습니다.]</li>
                </ul>
            </section>

            <section class="terms-section">
                <h3>제 3조: 서비스 이용</h3>
                <p>[서비스 이용 관련 내용 입력: 서비스 이용 시간, 중단, 변경 등에 대한 내용을 기술합니다.]</p>
            </section>

            <section class="terms-section">
                <h3>제 4조: 개인정보 보호</h3>
                <p>[자세한 내용은 <b><a href="/policy/privacy"><개인정보 처리방침></a></b>을 참고하시기 바랍니다.]</p>
            </section>

            <section class="terms-section">
                <h3>제 5조: 면책 조항</h3>
                <p>[서비스 제공 중단, 정보의 오류 등에 대한 회사의 책임 범위를 기술합니다.]</p>
            </section>

            <section class="terms-section">
                <h3>부칙</h3>
                <p>[약관의 효력 발생일 또는 개정일 등을 기재합니다.]</p>
            </section>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <jsp:include page="/WEB-INF/views/common/script.jsp"/>
</div>
</body>
</html>
