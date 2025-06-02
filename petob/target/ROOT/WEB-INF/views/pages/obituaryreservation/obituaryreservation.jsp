<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장례 예약 신청 - Star's Haven, 반려동물 장례식장</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/obituaryreservationstyle.css">
    <style>
        .flatpickr-input { height: calc(1.6em + 1.7rem + 4px); }
        .required { color: red; margin-left: 2px; }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        <div class="main-wrapper">
            <div class="container obituary-reservation-container">
                <h2>장례 예약 신청</h2>

                <c:if test="${not empty successMessage}"><div class="form-message success-message">${successMessage}</div></c:if>
                <c:if test="${not empty errorMessage}"><div class="form-message error-message">${errorMessage}</div></c:if>

                <form id="obituaryReservationForm" action="${pageContext.request.contextPath}/obituary-reservation/create" method="post" autocomplete="off">
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
                        <input type="text" id="petName" name="petName" class="form-control" required autocomplete="off">
                    </div>
                    <div class="form-group">
                        <label for="petWeight">반려동물 체중 (kg)<span class="required">*</span></label>
                        <input type="number" id="petWeight" name="petWeight" class="form-control" step="0.1" placeholder="예: 5.3" required autocomplete="off">
                    </div>
                    <div class="form-group">
                        <label for="applicantName">보호자(신청자) 성함<span class="required">*</span></label>
                        <input type="text" id="applicantName" name="applicantName" class="form-control" value="${loginUserName}" required autocomplete="off">
                    </div>
                    <div class="form-group">
                        <label for="applicantPhone">신청자 전화번호<span class="required">*</span></label>
                        <input type="tel" id="applicantPhone" name="applicantPhone" class="form-control" value="${loginUserPhone}" placeholder="예: 01012345678 (- 없이 입력)" required autocomplete="off">
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
                        <textarea id="notes" name="notes" class="form-control" rows="4" autocomplete="off"></textarea>
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
        document.addEventListener("DOMContentLoaded", function () {
            console.log("LOG: DOMContentLoaded - 스크립트 실행 시작");

            const funeralDateInput = document.getElementById("funeralDate");
            const branchSelectElement = document.getElementById("branchSelect"); // 지점 선택 요소
            const timeSelectElement = document.getElementById("funeralTime"); // 시간 선택 요소

            if (funeralDateInput) {
                flatpickr(funeralDateInput, {
                    locale: "ko",
                    dateFormat: "Y-m-d",
                    minDate: "today",
                    disable: [
                        function(date) {
                            // 주말(토요일:6, 일요일:0) 비활성화 (원하시면 주석 해제)
                            return (date.getDay() === 0 || date.getDay() === 6);
                        }
                    ],
                    onChange: function(selectedDates, dateStr, instance) {
                        const currentBranch = branchSelectElement ? branchSelectElement.value : "";
                        // console.log("LOG: Flatpickr onChange - 날짜:", dateStr, "현재 선택된 지점:", currentBranch);
                        if (dateStr && currentBranch) {
                            checkObituaryBookedTimes(dateStr, currentBranch);
                        } else {
                            resetTimeOptions();
                        }
                    }
                });
            } else {
                console.error("ERROR: funeralDate input 요소를 찾을 수 없습니다.");
            }

            const allObituaryTimes = [
                "09:00", "10:00", "11:00", "12:00",
                "13:00", "14:00", "15:00", "16:00",
                "17:00", "18:00"
            ];

            if (timeSelectElement) {
                timeSelectElement.innerHTML = '<option value="">시간을 선택해주세요</option>';
                allObituaryTimes.forEach(time => {
                    const option = document.createElement("option");
                    option.value = time;
                    option.textContent = time;
                    timeSelectElement.appendChild(option);
                });
            } else {
                console.error("ERROR: funeralTime select 요소를 찾을 수 없습니다.");
            }

            // 지점 선택 변경 시 이벤트 리스너 추가
            if (branchSelectElement) {
                branchSelectElement.addEventListener('change', function() {
                    const currentDate = funeralDateInput ? funeralDateInput.value : "";
                    const currentBranch = this.value;
                    // console.log("LOG: 지점 변경 - 선택된 지점:", currentBranch, "현재 선택된 날짜:", currentDate);
                    if (currentDate && currentBranch) {
                        checkObituaryBookedTimes(currentDate, currentBranch);
                    } else {
                        resetTimeOptions();
                    }
                });
            }


            // 페이지 로드 시 초기 날짜와 지점에 대한 예약 시간 확인
            if (funeralDateInput && funeralDateInput._flatpickr && branchSelectElement) {
                const initialDate = funeralDateInput._flatpickr.input.value;
                const initialBranch = branchSelectElement.value;
                if (initialDate && initialBranch) { // 초기 지점 값도 있는지 확인
                    // console.log("LOG: 초기 날짜:", initialDate, "초기 지점:", initialBranch, "-> 예약된 시간 확인 실행.");
                    checkObituaryBookedTimes(initialDate, initialBranch);
                }
            }

            const obituaryForm = document.getElementById('obituaryReservationForm');
            if (obituaryForm) {
                // console.log("LOG: obituaryReservationForm 요소 발견, submit 이벤트 리스너 등록.");
                obituaryForm.addEventListener('submit', function(event) {
                    event.preventDefault();
                    // console.log("LOG: --- Submit Handler 시작 ---");

                    const branchEl = document.getElementById('branchSelect');
                    const petNameEl = document.getElementById('petName');
                    const petWeightEl = document.getElementById('petWeight');
                    const applicantNameEl = document.getElementById('applicantName');
                    const applicantPhoneEl = document.getElementById('applicantPhone');
                    const funeralDateEl = document.getElementById('funeralDate');
                    const funeralTimeEl = document.getElementById('funeralTime');

                    let valBranchName = "";
                    let valBranchValue = "";
                    if (branchEl) {
                        valBranchValue = branchEl.value;
                        if (branchEl.selectedIndex >= 0 && branchEl.options[branchEl.selectedIndex]) {
                            valBranchName = branchEl.options[branchEl.selectedIndex].text;
                        }
                    }

                    const valPetName = petNameEl ? petNameEl.value.trim() : "";
                    const valPetWeight = petWeightEl ? petWeightEl.value.trim() : "";
                    const valApplicantName = applicantNameEl ? applicantNameEl.value.trim() : "";
                    const valApplicantPhone = applicantPhoneEl ? applicantPhoneEl.value.trim() : "";
                    const valFuneralDate = funeralDateEl ? funeralDateEl.value : "";
                    const valFuneralTime = funeralTimeEl ? funeralTimeEl.value : "";

                    // console.log("LOG: --- [Submit Handler] 값 추출 직후 ---");
                    // console.log("LOG: 지점 Value: \"" + valBranchValue + "\"");
                    // console.log("LOG: 지점 Text: \"" + valBranchName + "\"");
                    // console.log("LOG: 펫 이름: \"" + valPetName + "\"");
                    // console.log("LOG: 신청자명: \"" + valApplicantName + "\"");
                    // console.log("LOG: 장례날짜: \"" + valFuneralDate + "\"");
                    // console.log("LOG: 장례시간: \"" + valFuneralTime + "\"");

                    // 유효성 검사
                    if (!valBranchValue || valBranchName === "지점을 선택해주세요" || valBranchName === "") { alert("지점을 선택해주세요."); if(branchEl) branchEl.focus(); return; }
                    if (!valPetName) { alert("반려동물 이름을 입력해주세요."); if(petNameEl) petNameEl.focus(); return; }
                    if (!valPetWeight) { alert("반려동물 체중을 입력해주세요."); if(petWeightEl) petWeightEl.focus(); return; }
                    if (parseFloat(valPetWeight) <= 0 || isNaN(parseFloat(valPetWeight))) { alert('반려동물 체중은 0보다 큰 숫자로 입력해주세요.'); if(petWeightEl) petWeightEl.focus(); return; }
                    if (!valApplicantName) { alert("보호자(신청자) 성함을 입력해주세요."); if(applicantNameEl) applicantNameEl.focus(); return; }
                    if (!valApplicantPhone) { alert("신청자 전화번호를 입력해주세요."); if(applicantPhoneEl) applicantPhoneEl.focus(); return; }
                    const phoneCleaned = valApplicantPhone.replace(/-/g, "");
                    const phoneRegex = /^01[016789]\d{3,4}\d{4}$/;
                    if (!phoneRegex.test(phoneCleaned)) { alert('올바른 형식의 전화번호(01012345678 또는 010-1234-5678)'); if(applicantPhoneEl) applicantPhoneEl.focus(); return; }
                    if (!valFuneralDate) { alert("장례 희망 날짜를 선택해주세요."); if(funeralDateEl) funeralDateEl.focus(); return; }
                    if (!valFuneralTime) { alert("장례 희망 시간을 선택해주세요."); if(funeralTimeEl) funeralTimeEl.focus(); return; }

                    // Confirm 메시지 생성 (문자열 결합 방식 사용)
                    const confirmMessage = valBranchName + "에서 " + valApplicantName + "님 성함으로 " +
                                           valFuneralDate + " " + valFuneralTime + "에 반려동물(" + valPetName + ")의 " +
                                           "장례 예약을 진행하시겠습니까?";
                    // console.log("LOG: 생성된 최종 Confirm 메시지: \"" + confirmMessage + "\"");

                    if (confirm(confirmMessage)) {
                        // console.log("LOG: 사용자가 확인을 눌렀습니다. 폼을 제출합니다.");
                        this.submit(); // 여기서 this는 obituaryForm을 가리킵니다.
                    } else {
                        // console.log("LOG: 사용자가 취소를 눌렀습니다.");
                    }
                });
            } else {
                console.error("ERROR: obituaryReservationForm 요소를 찾을 수 없습니다.");
            }
            // console.log("LOG: DOMContentLoaded - 모든 설정 완료");
        }); // End of DOMContentLoaded

        function resetTimeOptions() {
            const timeSelect = document.getElementById("funeralTime");
            if (timeSelect) {
                timeSelect.value = "";
                const options = timeSelect.querySelectorAll("option");
                options.forEach(option => {
                    if (option.value !== "") {
                        option.disabled = false;
                        option.textContent = option.value;
                    }
                });
            }
        }

        function checkObituaryBookedTimes(selectedDate, selectedBranch) { // selectedBranch 파라미터 추가
            // console.log("LOG: checkObituaryBookedTimes 호출됨 - 날짜:", selectedDate, "지점:", selectedBranch);
            if (!selectedDate || !selectedBranch) { // 지점 정보도 확인
                // console.log("LOG: checkObituaryBookedTimes - 날짜 또는 지점 정보 누락, 실행 중단.");
                resetTimeOptions();
                return;
            }

            const checkUrl = "${pageContext.request.contextPath}/obituary-reservation/check-booked-times";
            const params = new URLSearchParams();
            params.append('date', selectedDate);
            params.append('branch', selectedBranch); // branch 파라미터 추가

            fetch(checkUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', },
                body: params.toString()
            })
            .then(response => {
                if (!response.ok) {
                    console.error("ERROR: checkObituaryBookedTimes - Network response error: " + response.status + " " + response.statusText + " (URL: " + checkUrl + ")");
                    return response.text().then(text => {
                        console.error("ERROR: checkObituaryBookedTimes - Error response body:", text);
                        throw new Error('Network error, status: ' + response.status);
                    });
                }
                return response.json();
            })
            .then(data => {
                // console.log("LOG: checkObituaryBookedTimes - Response Data:", data);
                const timeSelect = document.getElementById("funeralTime");
                if (!timeSelect) {
                    console.error("ERROR: funeralTime select 요소를 찾을 수 없습니다 (checkObituaryBookedTimes).");
                    return;
                }
                const previouslySelectedTime = timeSelect.value;
                resetTimeOptions();
                if (data.success && data.bookedTimes && data.bookedTimes.length > 0) {
                    data.bookedTimes.forEach(bookedTime => {
                        const option = timeSelect.querySelector("option[value='" + bookedTime + "']");
                        if (option) {
                            option.disabled = true;
                            option.textContent = bookedTime + " (예약마감)";
                        }
                    });
                } else if (!data.success) {
                    console.error('ERROR: checkObituaryBookedTimes - 서버에서 예약된 시간 조회 실패:', data.message);
                }
                const stillAvailableOption = timeSelect.querySelector("option[value='" + previouslySelectedTime + "']:not(:disabled)");
                if (stillAvailableOption) {
                    timeSelect.value = previouslySelectedTime;
                } else {
                    if (timeSelect.selectedIndex >=0 && timeSelect.options[timeSelect.selectedIndex] && timeSelect.options[timeSelect.selectedIndex].disabled) {
                         timeSelect.value = "";
                    }
                }
            })
            .catch(error => {
                console.error('ERROR: checkObituaryBookedTimes - fetch 실행 중 오류 발생:', error);
                resetTimeOptions();
            });
        }
    </script>
</body>
</html>