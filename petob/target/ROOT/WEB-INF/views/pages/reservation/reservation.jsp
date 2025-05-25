<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />

    <title>간편 예약 - Star's Haven, 반려동물 장례식장</title>

    <link rel="stylesheet" href="<c:url value='/resources/css/reservationstyle.css'/>" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script> <!-- 한국어 설정 -->
</head>

<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
        <div class="reservation-container">
            <h2>간편 상담 예약</h2>
            
            <!-- 성공/에러 메시지 표시 -->
            <c:if test="${not empty successMessage}">
                <div class="success-message">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            
            <!-- 폼 액션을 /reservation으로 수정 -->
            <form action="<c:url value='/reservation'/>" method="post">
                <div class="form-group">
                    <label for="username">이름</label>
                    <input type="text" id="username" name="username" required  
                    pattern="[a-zA-Z가-힣\s]+" 
                    title="이름은 한글 또는 영문만 입력해주세요.">
                </div>
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="text" id="phone" name="phone" required
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
                        <option value="">시간을 선택해주세요</option>
                    </select>
              </div>
                <button type="submit" id="submitBtn">예약하기</button>
            </form>
            
            <!-- 예약 조회 링크 추가 -->
            <div class="navigation-links" style="margin-top: 20px; text-align: center;">
                <a href="<c:url value='/reservation/check'/>">예약 조회</a>
            </div>
        </div>
        </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
    <script>
        flatpickr("#datePicker", {
            locale: "ko",
            dateFormat: "Y-m-d",
            minDate: "today",
            disable: [
                function(date) {
                    // 주말 비활성화 (0: 일요일, 6: 토요일)
                    return (date.getDay() === 0 || date.getDay() === 6);
                }
            ],
            onChange: function(selectedDates, dateStr, instance) {
                // 날짜가 변경되면 예약된 시간 확인
                if (dateStr) {
                    checkBookedTimes(dateStr);
                }
            }
        });

        const allTimes = [
            "09:00", "09:30", "10:00", "10:30",
            "11:00", "11:30", "12:00", "12:30",
            "13:00", "13:30", "14:00", "14:30",
            "15:00", "15:30", "16:00", "16:30",
            "17:00", "17:30", "18:00"
        ];

        document.addEventListener("DOMContentLoaded", function () {
            const select = document.getElementById("time");
            
            // 기본 옵션 추가
            const defaultOption = document.createElement("option");
            defaultOption.value = "";
            defaultOption.textContent = "시간을 선택해주세요";
            select.appendChild(defaultOption);
            
            // 시간 옵션들 추가
            allTimes.forEach(time => {
                const option = document.createElement("option");
                option.value = time;
                option.textContent = time;
                select.appendChild(option);
            });
            console.log("✅ 시간 옵션 추가 완료");
        });

        // 예약된 시간 확인 함수
        function checkBookedTimes(selectedDate) {
            fetch('<c:url value="/reservation/check-booked-times"/>', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'date=' + encodeURIComponent(selectedDate)
            })
            .then(response => response.json())
            .then(data => {
                const timeSelect = document.getElementById("time");
                const options = timeSelect.querySelectorAll("option");
                
                // 모든 옵션 초기화
                options.forEach(option => {
                    if (option.value !== "") {
                        option.disabled = false;
                        option.textContent = option.value;
                    }
                });
                
                // 예약된 시간들 비활성화
                if (data.bookedTimes && data.bookedTimes.length > 0) {
                    data.bookedTimes.forEach(bookedTime => {
                        const option = timeSelect.querySelector(`option[value="${bookedTime}"]`);
                        if (option) {
                            option.disabled = true;
                            option.textContent = bookedTime + " (예약됨)";
                        }
                    });
                }
                
                // 현재 선택된 시간이 예약된 시간이면 초기화
                if (data.bookedTimes && data.bookedTimes.includes(timeSelect.value)) {
                    timeSelect.value = "";
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }

        // 폼 제출 전 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const email = document.getElementById('email').value.trim();
            const date = document.getElementById('datePicker').value;
            const time = document.getElementById('time').value;
            
            if (!username || !phone || !email || !date || !time) {
                e.preventDefault();
                alert('모든 필드를 입력해주세요.');
                return false;
            }
            
            // 전화번호 형식 검사
            const phoneRegex = /^[0-9]{9,11}$/;
            if (!phoneRegex.test(phone)) {
                e.preventDefault();
                alert('전화번호는 숫자만 9~11자리로 입력해주세요.');
                return false;
            }
            
            // 예약 확인
            if (!confirm(`${date} ${time}에 예약하시겠습니까?`)) {
                e.preventDefault();
                return false;
            }
        });
    </script>
</body>
</html>