<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장례 예약 신청 - Star's Haven, 반려동물 장례식장</title>
    <%-- 공통 스타일 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <%-- Flatpickr CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <%-- 이 페이지 전용 CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/obituaryreservationstyle.css">
    <style>
        /* flatpickr 입력 필드와 다른 form-control 요소 높이 맞춤용 */
        .flatpickr-input {
            height: calc(1.6em + 1.7rem + 4px); /* .form-control padding + border 와 유사하게 */
        }
        .required { /* 필수 항목 별표 스타일 */
            color: red;
            margin-left: 2px;
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        <div class="main-wrapper">
            <div class="container obituary-reservation-container">
                <h2>장례 예약 신청</h2>

                <c:if test="${not empty successMessage}">
                    <div class="form-message success-message">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="form-message error-message">${errorMessage}</div>
                </c:if>

                <form id="obituaryReservationForm" action="${pageContext.request.contextPath}/obituary-reservation/create" method="post">

                    <div class="form-group">
                        <label for="branchSelect">지점<span class="required">*</span></label>
                        <select name="branch" id="branchSelect" class="form-control" required>
                            <option value="">지점을 선택해주세요</option>
                            <option value="본점" <c:if test="${selectedBranch == '본점' or selectedBranch == 'main'}">selected</c:if>>본점</option>
                            <option value="홍대입구점" <c:if test="${selectedBranch == '홍대입구점' or selectedBranch == 'hongdae'}">selected</c:if>>홍대입구점</option>
                            <option value="서대문점" <c:if test="${selectedBranch == '서대문점' or selectedBranch == 'seodaemun'}">selected</c:if>>서대문점</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="petName">반려동물 이름<span class="required">*</span></label>
                        <input type="text" id="petName" name="petName" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="petWeight">반려동물 체중 (kg)<span class="required">*</span></label>
                        <input type="number" id="petWeight" name="petWeight" class="form-control" step="0.1" placeholder="예: 5.3" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="applicantName">보호자(신청자) 성함<span class="required">*</span></label>
                        <input type="text" id="applicantName" name="applicantName" class="form-control" value="${loginUserName}" required>
                    </div>

                    <div class="form-group">
                        <label for="applicantPhone">신청자 전화번호<span class="required">*</span></label>
                        <input type="tel" id="applicantPhone" name="applicantPhone" class="form-control" value="${loginUserPhone}" placeholder="예: 01012345678 (- 없이 입력)" required>
                    </div>

                    <div class="form-group">
                        <label for="funeralDate">장례 희망 날짜<span class="required">*</span></label>
                        <input type="text" id="funeralDate" name="obDate" class="form-control" placeholder="날짜를 선택해주세요" readonly required>
                    </div>

                    <div class="form-group">
                        <label for="funeralTime">장례 희망 시간<span class="required">*</span></label>
                        <select id="funeralTime" name="obTime" class="form-control" required>
                            <option value="">시간을 선택해주세요</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="notes">기타 요청사항 (선택)</label>
                        <textarea id="notes" name="notes" class="form-control" rows="4"></textarea>
                    </div>

                    <button type="submit" class="btn-submit">예약 신청하기</button>
                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>

   <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>

    <script>
        flatpickr("#funeralDate", {
            locale: "ko",
            dateFormat: "Y-m-d",
            minDate: "today",
            disable: [
                function(date) {
                    // return (date.getDay() === 0 || date.getDay() === 6);
                }
            ],
            onChange: function(selectedDates, dateStr, instance) {
                if (dateStr) {
                    checkObituaryBookedTimes(dateStr);
                } else {
                    resetTimeOptions();
                }
            }
        });

        const allObituaryTimes = [
            "09:00", "10:00", "11:00", "12:00", 
            "13:00", "14:00", "15:00", "16:00", 
            "17:00", "18:00"
        ];

        document.addEventListener("DOMContentLoaded", function () {
            const timeSelect = document.getElementById("funeralTime");
            timeSelect.innerHTML = '<option value="">시간을 선택해주세요</option>'; 
            
            allObituaryTimes.forEach(time => {
                const option = document.createElement("option");
                option.value = time;
                option.textContent = time;
                timeSelect.appendChild(option);
            });

            const funeralDateElement = document.getElementById("funeralDate");
            if (funeralDateElement && funeralDateElement._flatpickr) {
                const initialDate = funeralDateElement._flatpickr.input.value;
                if (initialDate) {
                    checkObituaryBookedTimes(initialDate);
                }
            }
        });
        
        function resetTimeOptions() {
            const timeSelect = document.getElementById("funeralTime");
            timeSelect.value = ""; 
            const options = timeSelect.querySelectorAll("option");
            options.forEach(option => {
                if (option.value !== "") {
                    option.disabled = false;
                    option.textContent = option.value;
                }
            });
        }

        function checkObituaryBookedTimes(selectedDate) {
            const checkUrl = "${pageContext.request.contextPath}/obituary-reservation/check-booked-times";
            
            fetch(checkUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'date=' + encodeURIComponent(selectedDate)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok: ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                const timeSelect = document.getElementById("funeralTime");
                const previouslySelectedTime = timeSelect.value; 
                resetTimeOptions(); 

                if (data.success && data.bookedTimes && data.bookedTimes.length > 0) {
                    data.bookedTimes.forEach(bookedTime => {
                        const option = timeSelect.querySelector(`option[value="${bookedTime}"]`);
                        if (option) {
                            option.disabled = true;
                            option.textContent = bookedTime + " (예약마감)";
                        }
                    });
                } else if (!data.success) {
                     console.error('서버에서 예약된 시간 조회 실패:', data.message);
                }
                
                const stillAvailableOption = timeSelect.querySelector(`option[value="${previouslySelectedTime}"]:not(:disabled)`);
                if (stillAvailableOption) {
                    timeSelect.value = previouslySelectedTime;
                } else {
                    if (timeSelect.options[timeSelect.selectedIndex] && timeSelect.options[timeSelect.selectedIndex].disabled) {
                         timeSelect.value = "";
                    }
                }
            })
            .catch(error => {
                console.error('예약된 시간 확인 중 오류 발생:', error);
                resetTimeOptions(); 
            });
        }

        document.getElementById('obituaryReservationForm').addEventListener('submit', function(event) {
            event.preventDefault(); 

            const form = this; 

            const branchElement = document.getElementById('branchSelect');
            const branchValue = branchElement.value; 
            let branchName = ""; 
            if (branchValue && branchElement.selectedIndex >= 0) { // selectedIndex가 유효한지 확인
                // "지점을 선택해주세요" (value="")의 textContent도 가져올 수 있도록 조건 변경
                branchName = branchElement.options[branchElement.selectedIndex].text;

            let missingFields = [];
            if (!branch) missingFields.push("지점");
            if (!petName) missingFields.push("반려동물 이름");
            if (!petWeight) missingFields.push("반려동물 체중");
            if (!applicantName) missingFields.push("보호자(신청자) 성함");
            if (!applicantPhone) missingFields.push("신청자 전화번호");
            if (!funeralDate) missingFields.push("장례 희망 날짜");
            if (!funeralTime) missingFields.push("장례 희망 시간");
            if (missingFields.length > 0) {
                event.preventDefault(); // 폼 제출 방지
                alert(missingFields.join(", ") + " 항목을 입력(선택)해주세요.");
                return false;
            }

            const applicantNameElement = document.getElementById('applicantName');
            const applicantName = applicantNameElement.value.trim();
            
            const petNameElement = document.getElementById('petName');
            const petName = petNameElement.value.trim();

            const petWeightElement = document.getElementById('petWeight');
            const petWeight = petWeightElement.value.trim();
            
            const applicantPhoneElement = document.getElementById('applicantPhone');
            const applicantPhone = applicantPhoneElement.value.trim();

            const funeralDateElement = document.getElementById('funeralDate');
            let funeralDate = '';
            if (funeralDateElement && funeralDateElement._flatpickr && funeralDateElement._flatpickr.input && funeralDateElement._flatpickr.input.value) {
                funeralDate = funeralDateElement._flatpickr.input.value;
            } else if (funeralDateElement) { 
                funeralDate = funeralDateElement.value;
            }

            const funeralTimeElement = document.getElementById('funeralTime');
            const funeralTime = funeralTimeElement.value;

            // --- 유효성 검사 전 변수 값 확인 ---
            console.log("--- 값 할당 직후 ---");
            console.log("지점 value (branchValue):", branchValue);
            console.log("지점 텍스트 (branchName 초기 할당):", branchName); // .text 로 가져온 값
            console.log("신청자 성함 (applicantName):", applicantName);

            // 유효성 검사
            if (!branchValue || branchElement.selectedIndex === 0) { 
                alert("지점을 선택해주세요.");
                branchElement.focus();
                return;
            }
            // branchName이 실제로 유효한 지점명인지 다시 확인 (placeholder 텍스트 제외)
            if (branchName === "지점을 선택해주세요" || !branchName) { // !branchName 추가
                alert("유효한 지점을 선택해주세요.");
                branchElement.focus();
                return;
            }
            if (!petName) {
                alert("반려동물 이름을 입력해주세요.");
                petNameElement.focus();
                return;
            }
            if (!petWeight) {
                alert("반려동물 체중을 입력해주세요.");
                petWeightElement.focus();
                return;
            }
            if (parseFloat(petWeight) <= 0 || isNaN(parseFloat(petWeight))) {
                alert('반려동물 체중은 0보다 큰 숫자로 입력해주세요.');
                petWeightElement.focus();
                return;
            }
            if (!applicantName) { 
                alert("보호자(신청자) 성함을 입력해주세요.");
                applicantNameElement.focus();
                return;
            }
            if (!applicantPhone) {
                alert("신청자 전화번호를 입력해주세요."); 
                applicantPhoneElement.focus();
                return;
            }
            const phoneCleaned = applicantPhone.replace(/-/g, "");
            const phoneRegex = /^01[016789]\d{3,4}\d{4}$/;
            if (!phoneRegex.test(phoneCleaned)) {
                alert('올바른 형식의 전화번호를 입력해주세요. (예: 01012345678 또는 010-1234-5678)');
                applicantPhoneElement.focus();
                return;
            }
            if (!funeralDate) {
                alert("장례 희망 날짜를 선택해주세요.");
                return;
            }
            if (!funeralTime) {
                alert("장례 희망 시간을 선택해주세요.");
                funeralTimeElement.focus();
                return;
            }

            // --- confirmMessage 생성 직전 값 확인 ---
            console.log("--- Confirm 메시지 생성 직전 ---");
            console.log("branchName:", branchName);
            console.log("applicantName:", applicantName);

            // === 문자열 더하기 방식으로 변경 ===
            const confirmMessage = branchName + "에서 " + applicantName + "님 성함으로 장례 예약을 진행하시겠습니까?";
            
            console.log("생성된 Confirm 메시지 (문자열 더하기 사용):", confirmMessage);

            if (confirm(confirmMessage)) {
                form.submit(); 
            
            // 최종 예약 확인
            if (!confirm(`${funeralDate} ${funeralTime}에 ${applicantName}님 성함으로 장례 예약을 진행하시겠습니까?`)) {
                event.preventDefault(); // 폼 제출 방지
                return false;

            }
        });
    </script>
</body>
</html>