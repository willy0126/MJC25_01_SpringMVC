<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장례 예약 신청 - Star's Haven, 반려동물 장례식장</title>
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
                        <label for="branchSelect">지점</label>
                        <select name="branch" id="branchSelect" class="form-control" required>
                            <option value="">지점을 선택해주세요</option>
                            <option value="main" <c:if test="${selectedBranch == 'main'}">selected</c:if>>본점</option>
                            <option value="hongdae" <c:if test="${selectedBranch == 'hongdae'}">selected</c:if>>홍대입구점</option>
                            <option value="seodaemun" <c:if test="${selectedBranch == 'seodaemun'}">selected</c:if>>서대문점</option>
                            <c:if test="${not empty selectedBranch and selectedBranch != 'main' and selectedBranch != 'hongdae' and selectedBranch != 'seodaemun'}">
                                <option value="${selectedBranch}" selected>${selectedBranch} (직접 지정)</option>
                            </c:if>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="petName">반려동물 이름</label>
                        <input type="text" id="petName" name="petName" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="petWeight">반려동물 체중 (kg)</label>
                        <input type="number" id="petWeight" name="petWeight" class="form-control" step="0.1" placeholder="예: 5.3" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="applicantName">보호자(신청자) 성함</label>
                        <input type="text" id="applicantName" name="applicantName" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="applicantPhone">신청자 전화번호</label>
                        <input type="tel" id="applicantPhone" name="applicantPhone" class="form-control" placeholder="예: 01012345678 (- 없이 입력)" required>
                    </div>

                    <div class="form-group">
                        <label for="funeralDate">장례 희망 날짜</label>
                        <%-- Flatpickr가 적용될 input. 기존 type="date"에서 text로 변경하거나 그대로 두고 Flatpickr가 덮어쓰도록 할 수 있음 --%>
                        <input type="text" id="funeralDate" name="funeralDate" class="form-control" placeholder="날짜를 선택해주세요" readonly required>
                    </div>

                    <div class="form-group">
                        <label for="funeralTime">장례 희망 시간</label>
                        <%-- 기존 input type="time"을 select로 변경 --%>
                        <select id="funeralTime" name="funeralTime" class="form-control" required>
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

    <%-- Flatpickr JS --%>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script> <%-- 한국어 지원 --%>

    <script>
        // Flatpickr 초기화 (장례 희망 날짜 필드에 적용)
        flatpickr("#funeralDate", {
            locale: "ko", // 한국어
            dateFormat: "Y-m-d",
            minDate: "today", // 오늘 이전 날짜 선택 불가
            disable: [
                function(date) {
                    //주말(토:6, 일:0) 비활성화 (필요에 따라 주석 해제 또는 로직 변경)
                    return (date.getDay() === 0 || date.getDay() === 6);
                }
            ],
            onChange: function(selectedDates, dateStr, instance) {
                // 날짜가 변경되면 해당 날짜의 예약된 시간 확인
                if (dateStr) {
                    checkObituaryBookedTimes(dateStr);
                } else {
                    // 날짜 선택이 해제되면 시간 옵션 초기화
                    const timeSelect = document.getElementById("funeralTime");
                    timeSelect.value = ""; // 선택된 시간 초기화
                    const options = timeSelect.querySelectorAll("option");
                    options.forEach(option => {
                        if (option.value !== "") {
                            option.disabled = false;
                            option.textContent = option.value;
                        }
                    });
                }
            }
        });

        // 예약 가능한 전체 시간 목록 (필요에 따라 수정)
        const allObituaryTimes = [
            "09:00", "10:00", "11:00", "12:00", 
            "13:00", "14:00", "15:00", "16:00", 
            "17:00", "18:00"
        ];

        // DOM 로드 후 장례 희망 시간 select 태그에 옵션 추가
        document.addEventListener("DOMContentLoaded", function () {
            const timeSelect = document.getElementById("funeralTime");
            
            // 기본 "시간을 선택해주세요" 옵션은 JSP에 이미 있으므로 여기서는 생략하거나,
            // JSP에서 제거하고 여기서 추가할 수 있습니다. 여기서는 JSP에 있는 것을 유지합니다.
            
            allObituaryTimes.forEach(time => {
                const option = document.createElement("option");
                option.value = time;
                option.textContent = time;
                timeSelect.appendChild(option);
            });
            console.log("✅ 장례 희망 시간 옵션 추가 완료");
        });

        // 선택된 날짜의 예약된 시간 확인 및 비활성화 함수
        function checkObituaryBookedTimes(selectedDate) {
            const checkUrl = "${pageContext.request.contextPath}/obituary-reservation/check-booked-times";
            
            fetch(checkUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    // CSRF 토큰이 필요하다면 헤더에 추가해야 합니다. (예: Spring Security 사용 시)
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
                const options = timeSelect.querySelectorAll("option");
                
                // 모든 시간 옵션 활성화 및 기본 텍스트로 초기화
                options.forEach(option => {
                    if (option.value !== "") { // "시간을 선택해주세요" 옵션 제외
                        option.disabled = false;
                        option.textContent = option.value;
                    }
                });
                
                // 서버로부터 받은 예약된 시간들 비활성화
                if (data.bookedTimes && data.bookedTimes.length > 0) {
                    data.bookedTimes.forEach(bookedTime => {
                        const option = timeSelect.querySelector(`option[value="${bookedTime}"]`);
                        if (option) {
                            option.disabled = true;
                            option.textContent = bookedTime + " (예약마감)";
                        }
                    });
                }
                
                // 만약 현재 선택된 시간이 예약된 시간 목록에 포함된다면, 선택을 초기화
                if (timeSelect.value && data.bookedTimes && data.bookedTimes.includes(timeSelect.value)) {
                    timeSelect.value = ""; // "시간을 선택해주세요"로 변경
                }
            })
            .catch(error => {
                console.error('예약된 시간 확인 중 오류 발생:', error);
                alert("예약된 시간을 가져오는 데 실패했습니다. 잠시 후 다시 시도해주세요.");
            });
        }

        // 폼 제출 전 유효성 검사
        document.getElementById('obituaryReservationForm').addEventListener('submit', function(event) {
            const branch = document.getElementById('branchSelect').value;
            const petName = document.getElementById('petName').value.trim();
            const petWeight = document.getElementById('petWeight').value.trim();
            const applicantName = document.getElementById('applicantName').value.trim();
            const applicantPhone = document.getElementById('applicantPhone').value.trim();
            const funeralDate = document.getElementById('funeralDate').value;
            const funeralTime = document.getElementById('funeralTime').value;

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
            
            // 전화번호 형식 검사 (숫자, - 제외하고 9~11자리)
            const phoneCleaned = applicantPhone.replace(/-/g, "");
            const phoneRegex = /^[0-9]{9,11}$/;
            if (!phoneRegex.test(phoneCleaned)) {
                event.preventDefault();
                alert('신청자 전화번호는 숫자만 9~11자리로 입력해주세요. (예: 01012345678 또는 010-1234-5678)');
                document.getElementById('applicantPhone').focus();
                return false;
            }
            
            // 반려동물 체중 양수 검사
            if (parseFloat(petWeight) <= 0) {
                event.preventDefault();
                alert('반려동물 체중은 0보다 큰 값을 입력해주세요.');
                document.getElementById('petWeight').focus();
                return false;
            }
            
            // 최종 예약 확인
            if (!confirm(`${funeralDate} ${funeralTime}에 ${applicantName}님 성함으로 장례 예약을 진행하시겠습니까?`)) {
                event.preventDefault(); // 폼 제출 방지
                return false;
            }
        });
    </script>
</body>
</html>