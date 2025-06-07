<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>문의 작성 - Star's Haven, 반려동물 장례식장</title>
    
    <!-- 문의 게시판 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/inquiry/writestyle.css'/>" />
</head>

<body>
    <div class="page-wrapper">
        <!-- Navbar -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <div class="inquiry-container">
                <!-- 헤더 -->
                 <h2>${mode == 'edit' ? "문의 수정" : "문의 작성"}</h2>
                <!-- 성공/에러 메시지 표시 -->
                <c:if test="${not empty successMessage}">
                    <div class="success-message">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
                
                <!-- 로그인 확인 -->
                <c:choose>
                    <c:when test="${empty sessionScope.userId}">
                        <div class="login-required">
                            <div class="login-message">
                                <i class="fas fa-lock fa-3x"></i>
                                <h3>로그인이 필요합니다</h3>
                                <p>문의 작성은 로그인 후 이용하실 수 있습니다.</p>
                                <div class="button-group">
                                    <a href="<c:url value='/login'/>" class="login-btn">
                                        <i class="fas fa-sign-in-alt"></i> 로그인
                                    </a>
                                    <a href="<c:url value='/register'/>" class="register-btn">
                                        <i class="fas fa-user-plus"></i> 회원가입
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 문의 작성 폼 -->
                        <div class="write-form-container">
                            <!-- 수정 모드에 따라 form action 설정 -->
                            <c:choose>
                                <c:when test="${mode == 'edit'}">
                                    <form id="inquiryForm" action="<c:url value='/inquiry/edit/${inquiry.inquiryId}'/>" method="post">
                                </c:when>
                                <c:otherwise>
                                    <form id="inquiryForm" action="<c:url value='/inquiry/write'/>" method="post">
                                </c:otherwise>
                            </c:choose>
                            
                                <!-- 카테고리 -->
                                <div class="form-group">
                                    <label for="category">문의 카테고리 <span class="required">*</span></label>
                                    <select id="category" name="category" class="form-select" required>
                                        <option value="">카테고리를 선택해주세요</option>
                                        <option value="SERVICE" ${inquiry.category == 'SERVICE' ? 'selected' : ''}>서비스 문의</option>
                                        <option value="RESERVATION" ${inquiry.category == 'RESERVATION' ? 'selected' : ''}>예약 문의</option>
                                        <option value="PRICE" ${inquiry.category == 'PRICE' ? 'selected' : ''}>가격 문의</option>
                                        <option value="LOCATION" ${inquiry.category == 'LOCATION' ? 'selected' : ''}>지점 문의</option>
                                        <option value="COMPLAINT" ${inquiry.category == 'COMPLAINT' ? 'selected' : ''}>불만 접수</option>
                                        <option value="SUGGESTION" ${inquiry.category == 'SUGGESTION' ? 'selected' : ''}>개선 제안</option>
                                        <option value="ETC" ${inquiry.category == 'ETC' ? 'selected' : ''}>기타</option>
                                    </select>
                                    <span id="categoryError" class="error-text"></span>
                                </div>

                                <!-- 제목 -->
                                <div class="form-group">
                                    <label for="title">제목 <span class="required">*</span></label>
                                    <input type="text" id="title" name="title" class="form-input"
                                           value="${inquiry.title}" placeholder="문의 제목을 입력해주세요" maxlength="200" required />
                                    <span id="titleError" class="error-text"></span>
                                    <div class="char-count"><span id="titleCount">0</span>/200</div>
                                </div>

                                <!-- 내용 -->
                                <div class="form-group">
                                    <label for="content">문의 내용 <span class="required">*</span></label>
                                    <textarea id="content" name="content" class="form-textarea" rows="12"
                                              placeholder="문의하실 내용을 자세히 적어주세요"
                                              maxlength="2000" required>${inquiry.content}</textarea>
                                    <span id="contentError" class="error-text"></span>
                                    <div class="char-count"><span id="contentCount">0</span>/2000</div>
                                </div>

                                <!-- 이메일 -->
                                <div class="form-group">
                                    <label for="email">답변 받을 이메일</label>
                                    <input type="email" id="email" name="email" class="form-input"
                                           value="${inquiry.email}" placeholder="답변을 받을 이메일 주소 (선택사항)" maxlength="100" />
                                </div>

                                <!-- 비밀글 -->
                                <div class="form-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="isSecret" value="true"
                                               ${inquiry.isSecret ? 'checked' : ''} />
                                        비밀글로 설정
                                    </label>
                                </div>

                                <!-- 버튼 -->
                                <div class="button-group">
                                    <c:choose>
                                        <c:when test="${mode == 'edit'}">
                                            <button type="submit" class="btn btn-primary">✏️ 수정하기</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="submit" class="btn btn-primary">📝 등록하기</button>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="<c:url value='/inquiry/list'/>" class="btn btn-secondary">📋 목록으로</a>
                                </div>
                            </form>

                            <!-- 삭제는 별도의 form (form 중첩 방지) -->
                            <c:if test="${mode == 'edit'}">
                                <form action="<c:url value='/inquiry/delete/${inquiry.inquiryId}'/>" method="post"
                                      onsubmit="return confirm('정말 삭제하시겠습니까?');" style="margin-top: 15px;">
                                    <input type="hidden" name="returnUrl" value="/inquiry/list" />
                                    <div class="button-group">
                                        <button type="submit" class="btn btn-danger">🗑️ 삭제하기</button>
                                    </div>
                                </form>
                            </c:if>
                        </div>
                        
                        <!-- 도움말 -->
                        <div class="inquiry-guide">
                            <h3><i class="fas fa-info-circle"></i> 문의 작성 도움말</h3>
                            <div class="guide-content">
                                <div class="guide-section">
                                    <h4><i class="fas fa-lightbulb"></i> 효율적인 문의를 위한 팁</h4>
                                    <ul>
                                        <li><i class="fas fa-check"></i> 구체적이고 명확한 제목 작성</li>
                                        <li><i class="fas fa-check"></i> 문제 상황을 상세히 설명</li>
                                        <li><i class="fas fa-check"></i> 오류 메시지가 있다면 정확히 기재</li>
                                        <li><i class="fas fa-check"></i> 사용 환경 정보 포함 (브라우저, 기기 등)</li>
                                    </ul>
                                </div>
                                <div class="guide-section">
                                    <h4><i class="fas fa-clock"></i> 답변 처리 시간</h4>
                                    <ul>
                                        <li><strong>일반문의:</strong> 1-2 영업일</li>
                                        <li><strong>서비스문의:</strong> 2-3 영업일</li>
                                        <li><strong>예약문의:</strong> 1 영업일</li>
                                    </ul>
                                </div>
                                <div class="guide-section">
                                    <h4><i class="fas fa-phone"></i> 긴급 연락처</h4>
                                    <ul>
                                        <li><strong>고객센터:</strong> 02-1234-5678</li>
                                        <li><strong>운영시간:</strong> 평일 09:00-18:00</li>
                                        <li><strong>주말:</strong> 휴무</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
        
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        
        <!-- 공통 스크립트 -->
        <jsp:include page="/WEB-INF/views/common/script.jsp" />
    </div>
    
    <script>
        // 글자 수 카운터
        function updateCharCount(inputId, counterId, maxLength) {
            const input = document.getElementById(inputId);
            const counter = document.getElementById(counterId);
            
            if (!input || !counter) return;
            
            // 초기 카운트 설정
            counter.textContent = input.value.length;
            
            input.addEventListener('input', function() {
                const currentLength = this.value.length;
                counter.textContent = currentLength;
                
                if (currentLength > maxLength * 0.9) {
                    counter.style.color = '#e74c3c';
                } else if (currentLength > maxLength * 0.7) {
                    counter.style.color = '#f39c12';
                } else {
                    counter.style.color = '#666';
                }
            });
        }
        
        // 폼 유효성 검사
        function validateForm() {
            let isValid = true;
            
            // 카테고리 검사
            const category = document.getElementById('category');
            const categoryError = document.getElementById('categoryError');
            if (!category.value) {
                showError(categoryError, '카테고리를 선택해주세요.');
                if (isValid) category.focus();
                isValid = false;
            } else {
                hideError(categoryError);
            }
            
            // 제목 검사
            const title = document.getElementById('title');
            const titleError = document.getElementById('titleError');
            if (!title.value.trim()) {
                showError(titleError, '제목을 입력해주세요.');
                if (isValid) title.focus();
                isValid = false;
            } else if (title.value.trim().length < 2) {
                showError(titleError, '제목은 2글자 이상 입력해주세요.');
                if (isValid) title.focus();
                isValid = false;
            } else {
                hideError(titleError);
            }
            
            // 내용 검사
            const content = document.getElementById('content');
            const contentError = document.getElementById('contentError');
            if (!content.value.trim()) {
                showError(contentError, '문의 내용을 입력해주세요.');
                if (isValid) content.focus();
                isValid = false;
            } else if (content.value.trim().length < 10) {
                showError(contentError, '문의 내용은 10글자 이상 입력해주세요.');
                if (isValid) content.focus();
                isValid = false;
            } else {
                hideError(contentError);
            }
            
            if (isValid) {
                const mode = '${mode}';
                const message = mode === 'edit' ? '문의를 수정하시겠습니까?' : '문의를 등록하시겠습니까?';
                return confirm(message);
            }
            
            return isValid;
        }
        
        // 에러 표시
        function showError(errorElement, message) {
            if (!errorElement) return;
            errorElement.textContent = message;
            errorElement.style.display = 'block';
            errorElement.closest('.form-group').classList.add('has-error');
        }
        
        // 에러 숨김
        function hideError(errorElement) {
            if (!errorElement) return;
            errorElement.style.display = 'none';
            errorElement.closest('.form-group').classList.remove('has-error');
        }
        
        // 페이지 초기화
        document.addEventListener('DOMContentLoaded', function() {
            // 로그인 상태 확인
            const userId = '${sessionScope.userId}';
            const isLoggedIn = userId && userId !== '' && userId !== 'null';
            
            if (!isLoggedIn) {
                return; // 비로그인 상태면 폼 초기화 안함
            }
            
            // 글자 수 카운터 설정
            updateCharCount('title', 'titleCount', 200);
            updateCharCount('content', 'contentCount', 2000);
            
            // 폼 제출 이벤트
            const form = document.getElementById('inquiryForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        return false;
                    }
                });
            }
            
            // 실시간 유효성 검사
            const inputs = ['category', 'title', 'content'];
            inputs.forEach(function(inputId) {
                const input = document.getElementById(inputId);
                const errorElement = document.getElementById(inputId + 'Error');
                
                if (input && errorElement) {
                    input.addEventListener('blur', function() {
                        if (inputId === 'category' && !this.value) {
                            showError(errorElement, '카테고리를 선택해주세요.');
                        } else if (inputId === 'title' && !this.value.trim()) {
                            showError(errorElement, '제목을 입력해주세요.');
                        } else if (inputId === 'content' && !this.value.trim()) {
                            showError(errorElement, '문의 내용을 입력해주세요.');
                        } else {
                            hideError(errorElement);
                        }
                    });
                    
                    input.addEventListener('input', function() {
                        if (this.value.trim()) {
                            hideError(errorElement);
                        }
                    });
                }
            });
            
            // 알림 메시지 자동 숨김
            const alerts = document.querySelectorAll('.success-message, .error-message');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.animation = 'fadeOut 0.5s ease-out forwards';
                    setTimeout(function() {
                        alert.remove();
                    }, 500);
                }, 5000);
            });
        });
    </script>
</body>
</html>