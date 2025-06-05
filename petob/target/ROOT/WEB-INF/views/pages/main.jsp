<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp" />
            <title>Star's Haven - 반려동물 장례식장, 아름다운 이별을 위한 공간</title>

            <link rel="stylesheet" href="<c:url value='/resources/css/mainstyle.css'/>" />
            <%-- style.css는 head.jsp에서 이미 로드되었거나, 필요시 여기에 link 태그 추가 --%>
        </head>

        <body>
            <div class="page-wrapper">

                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                <main class="main-wrapper">
                    <%-- 캐러셀을 감싸는 전체 너비 wrapper 추가 --%>
                        <div class="carousel-wrapper-full-width">
                            <section id="carousel">
                                <%-- 기존 site-container는 제거하거나, 캐러셀 캡션 내부로 이동. 여기서는 제거하고 캡션에 적용 --%>
                                    <div id="mainCarousel" class="carousel slide fade-in" data-bs-ride="carousel"
                                        data-bs-interval="3000" style="height:400px; overflow:hidden;">
                                        <div class="carousel-indicators">
                                            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0"
                                                class="active" aria-current="true" aria-label="슬라이드 1"></button>
                                            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1"
                                                aria-label="슬라이드 2"></button>
                                            <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2"
                                                aria-label="슬라이드 3"></button>
                                        </div>

                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <img src="${pageContext.request.contextPath}/resources/img/carousel1.jpg"
                                                    class="d-block w-100" alt="슬라이드1"
                                                    style="height:400px; object-fit:cover;">
                                                <%-- 캡션에 .site-container 클래스 추가 --%>
                                                    <div
                                                        class="carousel-caption d-none d-md-block text-start site-container">
                                                        <h5 class="text-white">따뜻한 이별을, 진심으로</h5>
                                                        <p class="text-white">처음과 마지막을 지켜드리겠습니다.</p>
                                                    </div>
                                            </div>

                                            <div class="carousel-item">
                                                <img src="${pageContext.request.contextPath}/resources/img/carousel2.jpg"
                                                    class="d-block w-100" alt="슬라이드2"
                                                    style="height:400px; object-fit:cover;">
                                                <div
                                                    class="carousel-caption d-none d-md-block text-start site-container">
                                                    <h5 class="text-white">마지막 여정을, 아름답게</h5>
                                                    <p class="text-white">좋은 추억만을 간직하겠습니다.</p>
                                                </div>
                                            </div>

                                            <div class="carousel-item">
                                                <img src="${pageContext.request.contextPath}/resources/img/carousel3.jpg"
                                                    class="d-block w-100" alt="슬라이드3"
                                                    style="height:400px; object-fit:cover;">
                                                <div
                                                    class="carousel-caption d-none d-md-block text-start site-container">
                                                    <h5 class="text-white">함께한 시간을, 영원히</h5>
                                                    <p class="text-white">소중한 기억이 되도록 곁을 지키겠습니다.</p>
                                                </div>
                                            </div>
                                        </div>

                                        <button class="carousel-control-prev" type="button"
                                            data-bs-target="#mainCarousel" data-bs-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">이전</span>
                                        </button>
                                        <button class="carousel-control-next" type="button"
                                            data-bs-target="#mainCarousel" data-bs-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">다음</span>
                                        </button>
                                    </div>
                            </section>
                        </div> <%-- carousel-wrapper-full-width 끝 --%>

                            <div class="site-container">
                                <section id="daily-stars-counter-section" class="intro-item"
                                    style="flex-direction: column; align-items: center; text-align: center; margin-top: 60px; margin-bottom: 60px; padding: 40px 20px; background-color: #f8f9fa; border-radius: 8px;">
                                    <h3 class="section-title show"
                                        style="text-align: center; font-size: 1.7em; margin-bottom: 15px;">오늘, 우리 곁을 떠난
                                        작은 별들</h3>
                                    <p
                                        style="font-size: 2.5em; font-weight: bold; color: hsl(0, 100%, 63%); margin-bottom: 10px;">
                                        <span id="daily-pet-loss-count">0</span> 마리
                                    </p>
                                    <p style="font-size: 1em; color: #666; margin-bottom: 20px;">
                                        매년 약 50만, 하루 평균 1,300마리의 반려동물이 우리의 시간을 떠나갑니다.<br>
                                        이는 약 1분 남짓한 시간마다 한 아이가 별이 되고 있다는 뜻입니다.
                                    </p>
                                    <p style="font-size: 1.1em; color: #333;">
                                        Star's Haven은 그 모든 순간의 무게를 함께하며 깊이 위로합니다.
                                    </p>
                                </section>
                            </div>



                            <section id="intro">
                                <div class="site-container">
                                    <h2 class="section-title">사이트 소개</h2>

                                    <div class="intro-item">
                                        <img src="<c:url value='/resources/img/maincontent1.jpg'/>" alt="위로의 말 이미지">
                                        <div class="text">
                                            <h3>위로의 말</h3>
                                            <p>반려동물의 평온한 이별을 위한, 당신의 든든한 동반자.<br>장례, 추모, 기억까지... 당신의 슬픔을 함께 나누고 공감하는
                                                공간입니다.</p>
                                        </div>
                                    </div>

                                    <div class="intro-item reverse">
                                        <img src="<c:url value='/resources/img/maincontent2.jpg'/>" alt="천사 강아지 이미지">
                                        <div class="text">
                                            <h3>영원의 안식으로</h3>
                                            <p>사랑과 추억을 남기고 떠나는 마지막 길을, 따뜻함으로 지켜드립니다.<br>영원의 안식 속에서도, 소중한 기억은 언제나 함께할
                                                것입니다.</p>
                                        </div>
                                    </div>

                                </div>
                            </section>

                            <section id="notices">

<div class="notice-list">
    <h4>사이트 공지사항</h4>
    <ul>
        <c:choose>
            <c:when test="${not empty recentNotices}">
                <c:forEach var="notice" items="${recentNotices}" varStatus="status">
                    <li>
                        <a href="<c:url value='/notice/detail/${notice.id}'/>" class="notice-link">
                            <span class="title">${notice.title}</span>
                            <span class="date">
                                <c:choose>
                                    <c:when test="${notice.createdDate != null}">
                                        ${notice.createdDate.toString().substring(0, 10).replace('-', '.')}
                                    </c:when>
                                    <c:otherwise>
                                        날짜없음
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </a>
                    </li>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <!-- 공지사항이 없을 때 기본 메시지 -->
                <li>
                    <span class="title">등록된 공지사항이 없습니다.</span>
                    <span class="date">-</span>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
    
    <!-- 더보기 링크 -->
    <div class="notice-more">
        <a href="<c:url value='/notice/list'/>" class="btn-more">공지사항 더보기 →</a>
    </div>
</div>

                                <div class="mini-carousel">
                                    <h4>개발 비하인드</h4>
                                    <div id="miniCarousel" class="carousel slide" data-bs-ride="carousel"
                                        data-bs-interval="3000">
                                        <div class="carousel-inner">
                                            <div class="carousel-item active">
                                                <h5>사이트 이름 이야기</h5>
                                                <p><b>"Star's Haven"</b>은 여러분의 반려동물,<br>이제는 별이 된 친구들이 편히 쉬는 안식처를 뜻합니다.
                                                </p>
                                            </div>
                                            <div class="carousel-item">
                                                <h5>개발 계기</h5>
                                                <p>반려동물과의 마지막 이별은 너무나 슬프기에<br>따뜻한 공간을 만들고자 시작했습니다.</p>
                                            </div>
                                            <div class="carousel-item">
                                                <h5>개발자의 마음</h5>
                                                <p>저희 사이트가 작은 위로가 되어드리길 기원합니다.</p>
                                            </div>
                                            <div class="carousel-item">
                                                <h5>전하고 싶은 말</h5>
                                                <p>이곳을 찾아주신 여러분과 별이 된 친구들에게<br>최상의 서비스로 보답하겠습니다.</p>
                                            </div>
                                        </div>
                                        <button class="carousel-control-prev" type="button"
                                            data-bs-target="#miniCarousel" data-bs-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Previous</span>
                                        </button>
                                        <button class="carousel-control-next" type="button"
                                            data-bs-target="#miniCarousel" data-bs-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Next</span>
                                        </button>
                                    </div>
                                </div>
                            </section>
                </main>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div> <%-- .page-wrapper 끝 --%>

                <%-- "도움의 손길" 사이드바 - "챗봇 상담" 버튼만 초기에 표시 --%>
                    <div class="quick-help-sidebar">
                        <button id="openChatbot" class="quick-help-button chatbot-toggle-button">
                            <img src="${contextPath}/resources/img/chatbot.png" alt="챗봇 아이콘" class="button-icon">
                            <span>챗봇</span>
                        </button>
                    </div>

                    <%-- 챗봇 UI가 들어갈 자리 (초기에는 숨김) --%>
                        <div id="chatbotContainer" class="chatbot-container">
                            <div class="chatbot-header">
                                <h5>Star's Haven 챗봇</h5>
                                <button id="closeChatbot" class="chatbot-close-button">&times;</button>
                            </div>
                            <div class="chatbot-messages" id="chatbotMessages">
                                <%-- 챗봇 메시지가 여기에 표시됩니다 --%>
                            </div>
                            <div class="chatbot-input-area">
                                <div id="chatbotOptionsContainer">
                                    <%-- 시나리오에 따른 옵션 버튼들이 여기에 동적으로 추가됩니다 --%>
                                </div>
                            </div>
                        </div>

                        <jsp:include page="/WEB-INF/views/common/script.jsp" />

                        <script type="text/javascript">
                            document.addEventListener('DOMContentLoaded', function () {
                                // --- Daily Pet Loss Counter Script START ---
                                const countElement = document.getElementById('daily-pet-loss-count');
                                if (countElement) {
                                    const petsPerDay = 1300;
                                    const secondsInDay = 24 * 60 * 60;
                                    let initialAnimationComplete = false;
                                    const initialDelay = 2000;
                                    const animationDuration = 3500;

                                    function calculateCurrentPetLossCount() {
                                        const now = new Date();
                                        const startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                                        const millisecondsSinceStartOfDay = now.getTime() - startOfDay.getTime();
                                        const secondsSinceStartOfDay = millisecondsSinceStartOfDay / 1000;
                                        const proportionOfDayPassed = secondsSinceStartOfDay / secondsInDay;
                                        let count = Math.floor(petsPerDay * proportionOfDayPassed);
                                        return count < 0 ? 0 : count;
                                    }

                                    function easeInOutQuint(t, b, c, d) {
                                        t /= d / 2;
                                        if (t < 1) return c / 2 * t * t * t * t * t + b;
                                        t -= 2;
                                        return c / 2 * (t * t * t * t * t + 2) + b;
                                    }

                                    function easeOutExpo(t, b, c, d) {
                                        return (t == d) ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b;
                                    }

                                    function animateInitialCount() {
                                        const targetCount = calculateCurrentPetLossCount();
                                        let currentAnimatedValue = 0;
                                        const framesPerSecond = 60;
                                        const stepTime = 1000 / framesPerSecond;
                                        let currentTime = 0;

                                        if (window.countUpInterval) {
                                            clearInterval(window.countUpInterval);
                                        }

                                        setTimeout(() => {
                                            window.countUpInterval = setInterval(() => {
                                                currentTime += stepTime;
                                                if (currentTime >= animationDuration) {
                                                    currentAnimatedValue = targetCount;
                                                    clearInterval(window.countUpInterval);
                                                    initialAnimationComplete = true;
                                                    updateLiveCount();
                                                } else {
                                                    if (currentTime < animationDuration * 0.5) {
                                                        currentAnimatedValue = easeInOutQuint(currentTime, 0, targetCount, animationDuration);
                                                    } else {
                                                        let t_expo = currentTime - (animationDuration * 0.5);
                                                        let b_expo = easeInOutQuint(animationDuration * 0.5, 0, targetCount, animationDuration);
                                                        let c_expo = targetCount - b_expo;
                                                        let d_expo = animationDuration * 0.5;
                                                        currentAnimatedValue = easeOutExpo(t_expo, b_expo, c_expo, d_expo);
                                                    }
                                                }
                                                countElement.textContent = Math.floor(currentAnimatedValue).toLocaleString();
                                            }, stepTime);
                                        }, initialDelay);
                                    }

                                    function updateLiveCount() {
                                        if (initialAnimationComplete) {
                                            const liveTargetCount = calculateCurrentPetLossCount();
                                            if (parseInt(countElement.textContent.replace(/,/g, '')) !== liveTargetCount) {
                                                countElement.textContent = liveTargetCount.toLocaleString();
                                                countElement.classList.add('updated');
                                                setTimeout(() => {
                                                    countElement.classList.remove('updated');
                                                }, 500);
                                            }
                                        }
                                    }

                                    if (countElement) {
                                        countElement.textContent = '0';
                                        animateInitialCount();
                                        setInterval(updateLiveCount, 1000);
                                    }
                                }
                                // --- Daily Pet Loss Counter Script END ---

                                // --- Chatbot Script START ---
                                const chatbotContainer = document.getElementById('chatbotContainer');
                                const openChatbotButton = document.getElementById('openChatbot'); // "챗봇 상담" 버튼
                                const closeChatbotButton = document.getElementById('closeChatbot');
                                const chatbotMessagesContainer = document.getElementById('chatbotMessages');
                                const chatbotOptionsContainer = document.getElementById('chatbotOptionsContainer');
                                const contextPath = "${pageContext.request.contextPath}";
                                const quickHelpSidebar = document.querySelector('.quick-help-sidebar');


                                const scenarios = {
                                    "default": { // 챗봇 처음 열었을 때 기본 시나리오
                                        initialMessage: "안녕하세요! Star's Haven 챗봇입니다. 무엇을 도와드릴까요?",
                                        options: [
                                            { text: "아이를 떠나보냈어요", nextScenario: "initial_loss" },
                                            { text: "장례 절차가 궁금해요", nextScenario: "procedure_q" },
                                            { text: "비용이 궁금해요", nextScenario: "cost_q" },
                                            { text: "Star's Haven 이 어떤 의미인가요?", nextScenario: "meaning_q" },
                                        ]
                                    },
                                    "initial_loss": {
                                        initialMessage: "마음이 많이 힘드시겠어요. 어떤 도움이 필요하신가요? 저희가 함께 하겠습니다.",
                                        options: [
                                            { text: "지금 바로 상담하고 싶어요", action: "link", value: contextPath + "/reservation" },
                                            { text: "장례 절차를 알려주세요", nextScenario: "procedure_q" },
                                            { text: "마음 진정시키는 법", nextScenario: "comfort_info" },
                                            { text: "처음으로", nextScenario: "default" }
                                        ]
                                    },
                                    "procedure_q": {
                                        initialMessage: "Star's Haven의 장례 절차는 다음과 같습니다. 기본 절차의 내용은 '절차 및 비용' 페이지를 참고해주세요.",
                                        content: "<p>1. 온라인 상담 및 예약<br>2. 아이 운구 및 안치<br>3. 추모 예식<br>4. 개별 화장<br>5. 유골 수습 및 봉안/메모리얼 스톤 제작 등</p><p><a href='" + contextPath + "/info/procedure' target='_blank' class='chatbot-link'>자세히 보기 &raquo;</a></p>",
                                        options: [
                                            { text: "비용도 알려주세요", nextScenario: "cost_q" },
                                            { text: "처음으로", nextScenario: "default" }
                                        ]
                                    },
                                    "cost_q": {
                                        initialMessage: "장례 비용은 아이의 체중과 선택하시는 서비스에 따라 달라집니다. '절차 및 비용' 페이지에서 상세 내용을 확인하시거나, 예약을 통해 맞춤 상담을 받아보세요.",
                                        content: "<p><a href='" + contextPath + "/info/procedure' target='_blank' class='chatbot-link'>비용 안내 페이지 바로가기 &raquo;</a></p>",
                                        options: [
                                            { text: "예약하기", action: "link", value: contextPath + "/reservation" },
                                            { text: "처음으로", nextScenario: "default" }
                                        ]
                                    },
                                    "comfort_info": {
                                        initialMessage: "갑작스러운 이별에 많이 힘드시죠. 잠시 심호흡을 하시고, 주변에 도움을 요청하는 것도 좋은 방법입니다. 저희에게 언제든 문의해주세요.",
                                        options: [
                                            { text: "상담 예약하기", action: "link", value: contextPath + "/reservation" },
                                            { text: "처음으로", nextScenario: "default" }
                                        ]
                                    },
                                    "meaning_q": {
                                        initialMessage: "Star's Haven은 '별의 안식처'라는 뜻으로, 반려동물과의 마지막 이별을 따뜻하게 지켜드리기 위해 만들어졌습니다. 소중한 기억을 간직하고, 아이들이 편히 쉴 수 있는 공간이 되기를 바랍니다.",
                                        options: [
                                            { text: "처음으로", nextScenario: "default" }
                                        ]
                                    }
                                };

                                function addBotMessage(message, contentHTML = "") {
                                    if (!chatbotMessagesContainer) return;
                                    const messageWrapper = document.createElement('div'); // 각 메시지를 감싸는 div
                                    messageWrapper.style.overflow = "hidden"; // float 해제

                                    const messageDiv = document.createElement('div');
                                    messageDiv.classList.add('chatbot-message', 'bot');

                                    const messageParagraph = document.createElement('p');
                                    messageParagraph.textContent = message;
                                    messageDiv.appendChild(messageParagraph);

                                    if (contentHTML) {
                                        const contentDiv = document.createElement('div');
                                        contentDiv.innerHTML = contentHTML;
                                        messageDiv.appendChild(contentDiv);
                                    }
                                    messageWrapper.appendChild(messageDiv);
                                    chatbotMessagesContainer.appendChild(messageWrapper);
                                    scrollToBottom();
                                }

                                function addUserSelectionMessage(text) { // 사용자가 선택한 옵션을 메시지창에 표시
                                    if (!chatbotMessagesContainer) return;
                                    const messageWrapper = document.createElement('div');
                                    messageWrapper.style.overflow = "hidden";

                                    const messageDiv = document.createElement('div');
                                    messageDiv.classList.add('chatbot-message', 'user-selection');
                                    messageDiv.textContent = text;

                                    messageWrapper.appendChild(messageDiv);
                                    chatbotMessagesContainer.appendChild(messageWrapper);
                                    scrollToBottom();
                                }


                                function showOptions(options) {
                                    if (!chatbotOptionsContainer) return;
                                    chatbotOptionsContainer.innerHTML = '';
                                    if (options && options.length > 0) {
                                        options.forEach(option => {
                                            const button = document.createElement('button');
                                            button.textContent = option.text;
                                            button.addEventListener('click', () => handleOptionClick(option));
                                            chatbotOptionsContainer.appendChild(button);
                                        });
                                    }
                                }

                                function handleOptionClick(option) {
                                    addUserSelectionMessage(option.text); // 사용자가 선택한 옵션 텍스트를 메시지 창에 표시

                                    // 옵션 버튼들을 잠시 비활성화하여 중복 클릭 방지
                                    const buttons = chatbotOptionsContainer.querySelectorAll('button');
                                    buttons.forEach(btn => btn.disabled = true);

                                    setTimeout(() => { // 약간의 딜레이 후 다음 동작 실행 (시각적 효과)
                                        if (option.nextScenario) {
                                            loadScenario(option.nextScenario);
                                        } else if (option.action === 'link') {
                                            window.open(option.value, '_blank');
                                            addBotMessage("해당 페이지로 안내해 드렸습니다. 추가로 궁금한 점이 있으신가요?");
                                            showOptions(scenarios.default.options); // 링크 후에는 기본 옵션 다시 표시
                                        }
                                        // 새 옵션이 로드되면 버튼은 다시 활성화됨 (showOptions 함수에서 새로 만들어지므로)
                                    }, 300); // 0.3초 딜레이
                                }

                                function loadScenario(scenarioKey) {
                                    const scenario = scenarios[scenarioKey] || scenarios.default;
                                    addBotMessage(scenario.initialMessage, scenario.content || "");
                                    showOptions(scenario.options);
                                }

                                function scrollToBottom() {
                                    if (chatbotMessagesContainer) {
                                        chatbotMessagesContainer.scrollTop = chatbotMessagesContainer.scrollHeight;
                                    }
                                }

                                function openChatbot() {
                                    if (!chatbotContainer || !chatbotMessagesContainer) return;
                                    chatbotContainer.style.display = 'flex';
                                    chatbotContainer.classList.add('open');
                                    chatbotMessagesContainer.innerHTML = ''; // 이전 메시지 비우기
                                    if (quickHelpSidebar) quickHelpSidebar.style.display = 'none'; // 사이드바 숨기기
                                    loadScenario("default"); // "챗봇 상담" 버튼 클릭 시 항상 default 시나리오로 시작
                                }

                                function closeChatbot() {
                                    if (!chatbotContainer) return;
                                    chatbotContainer.classList.remove('open');
                                    setTimeout(() => {
                                        chatbotContainer.style.display = 'none';
                                        if (quickHelpSidebar) quickHelpSidebar.style.display = 'flex'; // 사이드바 다시 보이기
                                    }, 300);
                                }

                                if (openChatbotButton) { // "챗봇 상담" 버튼만 이벤트 리스너 연결
                                    openChatbotButton.addEventListener('click', openChatbot);
                                }

                                if (closeChatbotButton) {
                                    closeChatbotButton.addEventListener('click', closeChatbot);
                                }
                                // --- "도움의 손길" 챗봇 관련 스크립트 끝 ---

                                // --- 스크롤 감지하여 사이드바 나타나게 하는 로직 추가 ---
                                let sidebarShown = false; // 사이드바가 이미 나타났는지 확인하는 플래그
                                const showSidebarScrollPosition = 300; // 사이드바가 나타날 스크롤 위치 (px)

                                window.addEventListener('scroll', function () {
                                    if (quickHelpSidebar) { // quickHelpSidebar 요소가 있는지 확인
                                        if (window.pageYOffset > showSidebarScrollPosition && !sidebarShown) {
                                            quickHelpSidebar.classList.add('show');
                                            sidebarShown = true;
                                        } else if (window.pageYOffset <= showSidebarScrollPosition && sidebarShown) {
                                            // 위로 다시 스크롤했을 때 숨기고 싶다면 아래 주석 해제 (이 프로젝트에서는 숨기지 않음)
                                            quickHelpSidebar.classList.remove('show');
                                            sidebarShown = false;
                                        }
                                    }
                                });
                            });
                        </script>
        </body>
        </html>