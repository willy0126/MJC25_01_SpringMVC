<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>FAQ - Star's Haven</title>

            <link rel="stylesheet" href="${contextPath}/resources/css/style.css">
            <link rel="stylesheet" href="${contextPath}/resources/css/csstyle.css"> <%-- CS 전용 CSS --%>
        </head>

        <body>
            <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

            <div class="page-wrapper">
                <main class="main-wrapper">
                <div class="site-container">
                    <div class="page-title-section" style="margin-top: 100px; margin-bottom: 75px; text-align: center;">
                        <h1>자주 묻는 질문 (FAQ)</h1>
                    </div>

                    <div class="faq-container"> <%-- 전체 FAQ 항목을 감싸는 컨테이너 --%>

                            <div class="faq-item">
                                <button class="faq-question" type="button">
                                    <span>Q. 회원가입은 어떻게 하나요?</span>
                                    <span class="faq-icon">+</span> <%-- 아이콘 영역 --%>
                                </button>
                                <div class="faq-answer">
                                    <p>A. 홈페이지 상단의 '회원가입' 메뉴를 통해 가입하실 수 있습니다. 아이디, 비밀번호, 이름, 전화번호, 이메일 정보를 입력하시면 됩니다.</p>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-question" type="button">
                                    <span>Q. 예약은 어떻게 진행되나요?</span>
                                    <span class="faq-icon">+</span>
                                </button>
                                <div class="faq-answer">
                                    <p>A. 상단 메뉴의 '지점 소개' 버튼을 클릭하여 지점을 선택 후 시간을 정해 예약하실 수 있습니다. 간편 상담 예약으로 유선상 답변도 드리고 있습니다.
                                    </p>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-question" type="button">
                                    <span>Q. 반려동물 장례 절차는 어떻게 되나요?</span>
                                    <span class="faq-icon">+</span>
                                </button>
                                <div class="faq-answer">
                                    <p>A. 저희 Star's Haven에서는 아이와의 마지막 추억을 소중히 간직하실 수 있도록 다음과 같은 절차로 진행합니다.</p>
                                    <ul>
                                        <li>1. 전화 또는 온라인 상담 및 예약</li>
                                        <li>2. 아이 운구 및 안치</li>
                                        <li>3. 추모 예식</li>
                                        <li>4. 개별 화장</li>
                                        <li>5. 유골 수습 및 봉안/메모리얼 스톤 제작 등</li>
                                    </ul>
                                    <p>자세한 내용은 '절차 및 비용 안내' 페이지를 참고해 주십시오.</p>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-question" type="button">
                                    <span>Q. 지점 위치는 어디인가요?</span>
                                    <span class="faq-icon">+</span>
                                </button>
                                <div class="faq-answer">
                                    <p>A. 저희 Star's Haven은 현재 본점, 홍대입구점, 서대문점을 운영하고 있습니다. 각 지점의 상세 위치는 홈페이지 '지점 위치' 메뉴에서
                                        확인하실 수 있습니다.</p>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-question" type="button">
                                    <span>Q. 이 사이트는 실제하는 서비스를 설명하고 있나요?</span>
                                    <span class="faq-icon">+</span>
                                </button>
                                <div class="faq-answer">
                                    <p>A. 이 사이트는 실제 서비스를 제공하는 것이 아니라, 반려동물 장례 서비스에 대한 이해를 돕기 위한 예시 사이트입니다. 실제 서비스는 제공하지 않으며, 학습 및 연습용으로 제작되었습니다.</p>
                                    </p>
                                </div>
                            </div>

                            <div class="faq-item">
                                <button class="faq-question" type="button">
                                    <span>Q. 팀원(관리자) 구성은 어떻게 되어있나요?</span>
                                    <span class="faq-icon">+</span>
                                </button>
                                <div class="faq-answer">
                                    <p>A. 저희 사이트 제작은 {박지원, 안병준, 안성준, 최서연} 4명의 팀원으로 구성 및 진행했습니다. 각자의 역할을 맡아 사이트를 개발하고 유지보수하고 있습니다. 
                                    </p>
                                </div>
                            </div>

                    </div>
                </div>
                </main>
            </div>

            <%-- FAQ 아코디언 기능을 위한 JavaScript --%>
                <script type="text/javascript">
                    document.addEventListener('DOMContentLoaded', function () {
                        const faqQuestions = document.querySelectorAll('.faq-question');

                        faqQuestions.forEach(button => {
                            button.addEventListener('click', () => {
                                const answer = button.nextElementSibling; // .faq-answer
                                const icon = button.querySelector('.faq-icon');

                                // 버튼에 active 클래스 토글
                                button.classList.toggle('active');

                                if (button.classList.contains('active')) {
                                    // 답변을 보여줌
                                    answer.style.display = 'block';
                                    icon.textContent = '+';
                                } else {
                                    // 답변을 숨김
                                    answer.style.display = 'none';
                                    icon.textContent = '+';
                                }

                                // 다른 열려있는 답변들을 닫고 싶을 경우 (한 번에 하나만 열리도록)
                                faqQuestions.forEach(otherButton => {
                                    if (otherButton !== button && otherButton.classList.contains('active')) {
                                        otherButton.classList.remove('active');
                                        otherButton.nextElementSibling.style.display = 'none';
                                        otherButton.querySelector('.faq-icon').textContent = '+';
                                    }
                                });
                            });
                        });
                    });
                </script>

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            <jsp:include page="/WEB-INF/views/common/script.jsp" />
        </body>
        </html>