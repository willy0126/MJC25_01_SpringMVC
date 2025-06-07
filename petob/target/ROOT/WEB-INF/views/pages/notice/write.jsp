<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>공지사항 작성 - Star's Haven, 반려동물 장례식장</title>
    
    <!-- 공지사항 작성 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/noticestyle.css'/>" />
    
    <style>
        .write-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
        }
        
        .page-header h1 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .page-header p {
            color: #6c757d;
            font-size: 1.1em;
        }
        
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 1.1em;
        }
        
        .required {
            color: #e74c3c;
            font-weight: bold;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .form-textarea {
            width: 100%;
            min-height: 300px;
            padding: 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1em;
            font-family: inherit;
            resize: vertical;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }
        
        .form-textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .char-count {
            text-align: right;
            font-size: 0.9em;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .error-text {
            color: #e74c3c;
            font-size: 0.9em;
            margin-top: 5px;
            display: none;
        }
        
        .has-error .form-input,
        .has-error .form-textarea {
            border-color: #e74c3c;
        }
        
        .button-group {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 0 10px;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
        
        .alert {
            padding: 15px;
            margin: 20px 0;
            border-radius: 8px;
            font-weight: 500;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .write-guide {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            border-left: 4px solid #3498db;
        }
        
        .write-guide h3 {
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .guide-list {
            list-style: none;
            padding: 0;
        }
        
        .guide-list li {
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .guide-list li:last-child {
            border-bottom: none;
        }
        
        .guide-list i {
            color: #3498db;
            margin-right: 10px;
        }
        
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
    </style>
</head>

<body>
    <div class="page-wrapper">
        <!-- Navbar -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <div class="write-container">
                <!-- 페이지 헤더 -->
                <div class="page-header">
                    <h1>
                        <c:choose>
                            <c:when test="${not empty notice.id}">
                                ✏️ 공지사항 수정
                            </c:when>
                            <c:otherwise>
                                📝 공지사항 작성
                            </c:otherwise>
                        </c:choose>
                    </h1>
                    <p>
                        <c:choose>
                            <c:when test="${not empty notice.id}">
                                공지사항을 수정해주세요
                            </c:when>
                            <c:otherwise>
                                중요한 공지사항을 작성해주세요
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                
                <!-- 알림 메시지 -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">${errorMessage}</div>
                </c:if>
                
                <!-- 작성 폼 -->
                <div class="form-container">
                    <c:choose>
                        <c:when test="${not empty notice.id}">
                            <!-- 수정 모드 -->
                            <form id="noticeForm" action="<c:url value='/notice/update/${notice.id}'/>" method="post">
                        </c:when>
                        <c:otherwise>
                            <!-- 작성 모드 -->
                            <form id="noticeForm" action="<c:url value='/notice/save'/>" method="post">
                        </c:otherwise>
                    </c:choose>
                    
                        <!-- 수정 모드일 때 기존 정보 표시 -->
                        <c:if test="${not empty notice.id}">
                            <div class="form-group">
                                <label>기존 정보</label>
                                <div style="padding: 15px; background: #f8f9fa; border-radius: 8px; border: 1px solid #e9ecef;">
                                    <c:if test="${notice.createdDate != null}">
                                        <div style="margin-bottom: 8px;">
                                            <strong>작성일:</strong> 
                                            ${notice.createdDate.toLocalDate()} ${notice.createdDate.toLocalTime()}
                                        </div>
                                    </c:if>
                                    <c:if test="${notice.updatedDate != null && !notice.updatedDate.equals(notice.createdDate)}">
                                        <div style="margin-bottom: 8px;">
                                            <strong>최종 수정일:</strong> 
                                            ${notice.updatedDate.toLocalDate()} ${notice.updatedDate.toLocalTime()}
                                        </div>
                                    </c:if>
                                    <div>
                                        <strong>작성자:</strong> 관리자
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- 제목 -->
                        <div class="form-group">
                            <label for="title">공지사항 제목 <span class="required">*</span></label>
                            <input type="text" id="title" name="title" class="form-input"
                                   value="${notice.title}" 
                                   placeholder="공지사항 제목을 입력해주세요" 
                                   maxlength="200" required />
                            <span id="titleError" class="error-text"></span>
                            <div class="char-count">
                                <span id="titleCount">0</span>/200
                            </div>
                        </div>

                        <!-- 내용 -->
                        <div class="form-group">
                            <label for="content">공지사항 내용 <span class="required">*</span></label>
                            <textarea id="content" name="content" class="form-textarea"
                                      placeholder="공지사항 내용을 상세히 작성해주세요&#10;&#10;• 명확하고 이해하기 쉬운 내용으로 작성&#10;• 중요한 정보는 굵은 글씨나 색상으로 강조&#10;• 문의사항이 있을 경우 연락처 포함"
                                      maxlength="5000" required>${notice.content}</textarea>
                            <span id="contentError" class="error-text"></span>
                            <div class="char-count">
                                <span id="contentCount">0</span>/5000
                            </div>
                        </div>

                        <!-- 작성자 정보 (자동 설정) -->
                        <div class="form-group">
                            <label>
                                <c:choose>
                                    <c:when test="${not empty notice.id}">수정자</c:when>
                                    <c:otherwise>작성자</c:otherwise>
                                </c:choose>
                            </label>
                            <div style="padding: 12px 15px; background: #f8f9fa; border-radius: 8px; color: #6c757d;">
                                <i class="fas fa-user"></i> 관리자 (${sessionScope.userId})
                            </div>
                        </div>

                        <!-- 버튼 그룹 -->
                        <div class="button-group">
                            <c:choose>
                                <c:when test="${not empty notice.id}">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> 공지사항 수정
                                    </button>
                                    <a href="<c:url value='/notice/detail/${notice.id}'/>" class="btn btn-secondary">
                                        <i class="fas fa-eye"></i> 상세보기로 돌아가기
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i> 공지사항 등록
                                    </button>
                                </c:otherwise>
                            </c:choose>
                            <a href="<c:url value='/notice/list'/>" class="btn btn-secondary">
                                <i class="fas fa-list"></i> 목록으로 돌아가기
                            </a>
                        </div>
                    </form>
                </div>
                
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
                
                // 글자 수에 따른 색상 변경
                if (currentLength > maxLength * 0.9) {
                    counter.style.color = '#e74c3c';
                } else if (currentLength > maxLength * 0.7) {
                    counter.style.color = '#f39c12';
                } else {
                    counter.style.color = '#6c757d';
                }
            });
        }
        
        // 폼 유효성 검사
        function validateForm() {
            let isValid = true;
            
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
                showError(contentError, '공지사항 내용을 입력해주세요.');
                if (isValid) content.focus();
                isValid = false;
            } else if (content.value.trim().length < 10) {
                showError(contentError, '공지사항 내용은 10글자 이상 입력해주세요.');
                if (isValid) content.focus();
                isValid = false;
            } else {
                hideError(contentError);
            }
            
            if (isValid) {
                const mode = '${not empty notice.id ? "edit" : "write"}';
                const message = mode === 'edit' ? '공지사항을 수정하시겠습니까?' : '공지사항을 등록하시겠습니까?';
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
            // 글자 수 카운터 설정
            updateCharCount('title', 'titleCount', 200);
            updateCharCount('content', 'contentCount', 5000);
            
            // 폼 제출 이벤트
            const form = document.getElementById('noticeForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    if (!validateForm()) {
                        e.preventDefault();
                        return false;
                    }
                });
            }
            
            // 실시간 유효성 검사
            const inputs = ['title', 'content'];
            inputs.forEach(function(inputId) {
                const input = document.getElementById(inputId);
                const errorElement = document.getElementById(inputId + 'Error');
                
                if (input && errorElement) {
                    input.addEventListener('blur', function() {
                        if (inputId === 'title' && !this.value.trim()) {
                            showError(errorElement, '제목을 입력해주세요.');
                        } else if (inputId === 'content' && !this.value.trim()) {
                            showError(errorElement, '공지사항 내용을 입력해주세요.');
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
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.animation = 'fadeOut 0.5s ease-out forwards';
                    setTimeout(function() {
                        alert.remove();
                    }, 500);
                }, 5000);
            });
            
            // 제목 입력 시 자동 포커스 이동
            const titleInput = document.getElementById('title');
            const contentInput = document.getElementById('content');
            
            if (titleInput && contentInput) {
                titleInput.addEventListener('keydown', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        contentInput.focus();
                    }
                });
            }
        });
    </script>
</body>
</html>