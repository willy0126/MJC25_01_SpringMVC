<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>회원가입 - Petob</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/loginstyle.css'/>" />
    <style>
        /* jQuery Validate 에러 메시지 스타일 */
        .error-message { color: #dc3545; font-size: 0.875em; margin-top: 0.25rem; }
        .form-control.error { border-color: #dc3545; }
    </style>
</head>
<body>
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
<div class="page-wrapper">
    <main class="main-wrapper">
        <div class="auth-container">
            <h2>회원가입</h2>
            <p class="text-center text-muted mb-4" style="font-size: 0.9rem;">
                <span class="text-danger">*</span> 표시는 필수항목입니다.
            </p>

            <form id="registerForm" action="<c:url value='/register'/>" method="POST">
                <div class="form-group">
                    <label for="userId" class="form-label">아이디 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="userId" name="userId" placeholder="영문, 숫자 5~12자">
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="8~20자">
                </div>

                <div class="form-group">
                    <label for="password2" class="form-label">비밀번호 확인 <span class="text-danger">*</span></label>
                    <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 재입력">
                </div>

                <div class="form-group">
                    <label for="username" class="form-label">이름 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="2~10자">
                </div>
                
                <div class="form-group">
                    <label for="phone" class="form-label">전화번호 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="'-' 없이 숫자만 입력">
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="example@email.com">
                </div>
                
                <div class="d-grid gap-2 mt-4">
                     <button type="submit" class="btn btn-primary">회원가입</button>
                </div>
            </form>
            
            <c:if test="${not empty errorMessage}">
                <div class="flash-message error">${errorMessage}</div>
            </c:if>

            <div class="auth-helpers">
                이미 계정이 있으신가요? <a href="<c:url value='/login'/>">로그인</a>
            </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<jsp:include page="/WEB-INF/views/common/script.jsp" />
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script>
$(document).ready(function () {
    // 전화번호 입력 필터링 및 자동 하이픈
    $('#phone').on('input', function () {
        let phone = $(this).val().replace(/[^0-9]/g, '');
        let formattedPhone = '';
        if (phone.length > 11) {
            phone = phone.substring(0, 11);
        }
        if (phone.length < 4) {
            formattedPhone = phone;
        } else if (phone.length < 8) {
            formattedPhone = phone.substr(0, 3) + '-' + phone.substr(3);
        } else {
            formattedPhone = phone.substr(0, 3) + '-' + phone.substr(3, 4) + '-' + phone.substr(7);
        }
        $(this).val(formattedPhone);
    });

    // jQuery Validate 설정
    $('#registerForm').validate({
        rules: {
            userId: {
                required: true,
                minlength: 5,
                maxlength: 12,
                remote: {
                    url: '<c:url value="/check-user-id"/>',
                    type: 'post',
                    data: {
                        userId: function () { return $('#userId').val(); }
                    },
                    dataFilter: function (response) {
                        return !JSON.parse(response).exists;
                    }
                }
            },
            password: { required: true, minlength: 8, maxlength: 20 },
            password2: { required: true, equalTo: '#password' },
            username: { required: true, minlength: 2, maxlength: 10 },
            phone: {
                required: true,
                remote: {
                    url: '<c:url value="/check-phone"/>',
                    type: 'post',
                    data: {
                        phone: function () { return $('#phone').val(); }
                    },
                    dataFilter: function (response) {
                        return !JSON.parse(response).exists;
                    }
                }
            },
            email: {
                required: true,
                email: true,
                maxlength: 50,
                remote: {
                    url: '<c:url value="/check-email"/>',
                    type: 'post',
                    data: {
                        email: function () { return $('#email').val(); }
                    },
                    dataFilter: function (response) {
                        return !JSON.parse(response).exists;
                    }
                }
            }
        },
        messages: {
            userId: {
                required: '아이디를 입력하세요.',
                minlength: '아이디는 5자 이상 12자 이하로 입력하세요.',
                maxlength: '아이디는 5자 이상 12자 이하로 입력하세요.',
                remote: '이미 사용중인 아이디입니다.'
            },
            password: {
                required: '비밀번호를 입력하세요.',
                minlength: '비밀번호는 8자 이상 20자 이하로 입력하세요.',
                maxlength: '비밀번호는 8자 이상 20자 이하로 입력하세요.'
            },
            password2: {
                required: '비밀번호 확인을 입력하세요.',
                equalTo: '비밀번호가 일치하지 않습니다.'
            },
            username: {
                required: '이름을 입력하세요.',
                minlength: '이름은 2자 이상 입력하세요.',
                maxlength: '이름은 10자 이하로 입력하세요.'
            },
            phone: {
                required: '전화번호를 입력하세요.',
                remote: '이미 사용중인 전화번호입니다.'
            },
            email: {
                required: '이메일을 입력하세요.',
                email: '올바른 이메일 형식이 아닙니다.',
                maxlength: '이메일은 최대 50자까지 가능합니다.',
                remote: '이미 사용중인 이메일입니다.'
            }
        },
        errorElement: 'div',
        errorClass: 'error-message',
        errorPlacement: function (error, element) {
            error.insertAfter(element);
        },
        submitHandler: function (form) {
            form.submit();
        }
    });
});
</script>
</body>
</html>