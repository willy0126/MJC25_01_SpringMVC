<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp" />
            <title>회원가입 - Star's Haven, 반려동물 장례식장</title>
            <link rel="stylesheet" href="<c:url value='/resources/css/loginstyle.css'/>" />
        </head>

        <body>
            <div class="page-wrapper">
                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                <main class="main-wrapper">
                    <div class="login-container">
                        <h2>회원가입</h2>
                        <%-- 회원 가입 --%>
                            <form id="registerForm" action="/register" method="POST">
                                <div class="card mb-3">
                                    <div class="card-header">
                                        회원 가입 (<span class="text-danger">*</span> 표시는 필수항목입니다.)
                                    </div>
                                    <div class="card-body">
                                        <%-- 아이디 --%>
                                            <div class="mb-3">
                                                <label for="userId" class="form-label">아이디<span
                                                        class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="userId" name="userId"
                                                    placeholder="아이디">
                                            </div>
                                            <%-- // 아이디 --%>

                                                <%-- 비밀번호 --%>
                                                    <div class="mb-3">
                                                        <label for="password" class="form-label">비밀번호<span
                                                                class="text-danger">*</span></label>
                                                        <input type="password" class="form-control" id="password"
                                                            name="password" placeholder="비밀번호">
                                                    </div>
                                                    <%-- // 비밀번호 --%>

                                                        <%-- 비밀번호 확인 --%>
                                                            <div class="mb-3">
                                                                <label for="password2" class="form-label">비밀번호 확인<span
                                                                        class="text-danger">*</span></label>
                                                                <input type="password" class="form-control"
                                                                    id="password2" name="password2"
                                                                    placeholder="비밀번호 확인">
                                                            </div>
                                                            <%-- // 비밀번호 확인 --%>

                                                                <%-- 이름 --%>
                                                                    <div class="mb-3">
                                                                        <label for="username" class="form-label">이름<span
                                                                                class="text-danger">*</span></label>
                                                                        <input type="text" class="form-control"
                                                                            id="username" name="username"
                                                                            placeholder="이름">
                                                                    </div>
                                                                    <%-- // 이름 --%>

                                                                        <%-- 전화번호 --%>
                                                                            <div class="mb-3">
                                                                                <label for="phone"
                                                                                    class="form-label">전화번호<span
                                                                                        class="text-danger">*</span></label>
                                                                                <input type="text" class="form-control"
                                                                                    id="phone" name="phone"
                                                                                    placeholder="전화번호">
                                                                            </div>
                                                                            <%-- // 전화번호 --%>

                                                                                <%-- 이메일 --%>
                                                                                    <div class="mb-3">
                                                                                        <label for="email"
                                                                                            class="form-label">이메일<span
                                                                                                class="text-danger">*</span></label>
                                                                                        <input type="email"
                                                                                            class="form-control"
                                                                                            id="email" name="email"
                                                                                            placeholder="이메일">
                                                                                    </div>
                                                                                    <%-- // 이메일 --%>
                                    </div>
                                    <div class="card-footer">
                                        <div>
                                            <button type="submit" class="btn btn-primary">회원가입</button>
                                            <a href="/auth/login" class="btn btn-secondary">로그인</a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <% String errorMessage=(String) request.getAttribute("errorMessage"); if (errorMessage
                                !=null && !errorMessage.isEmpty()) { %>
                                <div class="error-message">
                                    <%= errorMessage %>
                                </div>
                                <% } %>

                                    <div class="link-to-register">
                                        이미 계정이 있으신가요? <a href="login">로그인</a>
                                    </div>
                    </div>
                </main>

                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                <jsp:include page="/WEB-INF/views/common/script.jsp" />


            </div>
            <%-- 자바스크립트 --%>

                <script>
                    $(document).ready(function () {
                        // 전화번호 입력 제한 및 형식화
                        $('#phone').on('keypress', function (e) {
                            // 숫자 키(0-9)만 허용, 그 외 입력은 차단
                            if (!/[0-9]/.test(String.fromCharCode(e.which)) && e.which != 8 && e.which != 0) {
                                e.preventDefault();
                            }
                        }).on('input', function () {
                            // 숫자만 남기기
                            let phone = $(this).val().replace(/[^0-9]/g, '');

                            // 입력 값이 3자리 이상일 때 010으로 시작하는지 확인
                            if (phone.length >= 3 && !phone.startsWith('010')) {
                                phone = '010' + phone.substring(Math.min(3, phone.length));
                            }

                            // 형식화
                            if (phone.length <= 3) {
                                $(this).val(phone);
                            } else if (phone.length <= 7) {
                                $(this).val(phone.replace(/(\d{3})(\d{1,4})/, '$1-$2'));
                            } else {
                                $(this).val(phone.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3'));
                            }

                            // 최대 11자리로 제한
                            if (phone.length > 11) {
                                phone = phone.substring(0, 11);
                                $(this).val(phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
                            }
                        });

                        $.validator.addMethod("noAdmin", function (value, element) {
                            // 필드가 비어있으면 이 규칙은 통과 (required:true가 별도로 처리)
                            if (this.optional(element)) {
                                return true;
                            }
                            // "admin" 문자열을 대소문자 구분 없이 포함하는지 검사
                            // 포함하면 false (유효성 실패), 포함하지 않으면 true (유효성 통과)
                            return !/admin/i.test(value);
                        },
                        "아이디에는 'admin'이라는 단어를 사용할 수 없습니다."
                        );

                            // 회원가입 폼 검증
                            $('#registerForm').validate({
                                rules: {
                                    userId: {
                                        required: true,
                                        noAdmin: true,  // 관리자 계정 방지 (admin 포함 방지)
                                        minlength: 6,
                                        maxlength: 12,
                                        remote: {
                                            url: '/check-user-id',
                                            type: 'post',
                                            data: {
                                                userId: function () {
                                                    return $('#userId').val();
                                                },
                                            },
                                            dataFilter: function (response) {
                                                const data = JSON.parse(response);
                                                return !data.exists;
                                            }
                                        }
                                    },
                                    password: {
                                        required: true,
                                        minlength: 8,
                                        maxlength: 20
                                    },
                                    password2: {
                                        required: true,
                                        equalTo: '#password'
                                    },
                                    username: {
                                        required: true,
                                        minlength: 2,
                                        maxlength: 10
                                    },
                                    phone: {
                                        required: true,
                                        remote: {
                                            url: '/check-phone',
                                            type: 'post',
                                            data: {
                                                phone: function () {
                                                    return $('#phone').val();
                                                },
                                            },
                                            dataFilter: function (response) {
                                                const data = JSON.parse(response);
                                                return !data.exists;
                                            }
                                        }
                                    },
                                    email: {
                                        required: true,
                                        email: true,
                                        maxlength: 50,
                                        remote: {
                                            url: '/check-email',
                                            type: 'post',
                                            data: {
                                                email: function () {
                                                    return $('#email').val();
                                                },
                                            },
                                            dataFilter: function (response) {
                                                const data = JSON.parse(response);
                                                return !data.exists;
                                            }
                                        }
                                    }
                                },
                                messages: {
                                    userId: {
                                        required: '아이디를 입력하세요.',
                                        noAdmin: "아이디에는 'admin'이라는 단어를 사용할 수 없습니다.", // 관리자 계정 방지 (admin 포함 방지)
                                        minlength: '아이디는 6자 이상 12자 이하로 입력하세요.',
                                        maxlength: '아이디는 6자 이상 12자 이하로 입력하세요.',
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
                                        maxlength: '이름은 2자 이상 4자 이하로 입력하세요.'
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
                                errorClass: 'is-invalid',
                                validClass: 'is-valid',
                                errorPlacement: function (error, element) {
                                    error.addClass('invalid-feedback');
                                    element.closest('.mb-3').append(error);
                                },
                                submitHandler: function (form) {
                                    form.submit();
                                }
                            });
                    });
                </script>
        </body>

        </html>