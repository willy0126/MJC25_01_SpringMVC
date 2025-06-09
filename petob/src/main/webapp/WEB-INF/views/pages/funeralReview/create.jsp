<%@ page language="java" contentType="text/html; charset=UTF-8" %>
    <%-- JSTL 태그 라이브러리 추가 (컨텍스트 경로 사용을 위해) --%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <jsp:include page="/WEB-INF/views/common/head.jsp" />
                <title>이용 후기 - Star's Haven, 반려동물 장례식장</title>
            </head>

            <body>
                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
                <div class="container">
                    <%-- 페이지 내용 --%>
                        <div class="row">
                            <div class="col-12">
                                <%-- 게시글 등록 --%>
                                    <%-- action 경로 수정 --%>
                                        <form id="createForm"
                                            action="${pageContext.request.contextPath}/funeral-reviews/create"
                                            method="POST" enctype="multipart/form-data">
                                            <div class="card mb-3">
                                                <div class="card-header">
                                                    게시글 등록 (<span class="text-danger">*</span> 표시는 필수항목입니다.)
                                                </div>
                                                <div class="card-body">
                                                    <%-- 제목 --%>
                                                        <div class="mb-3">
                                                            <label for="reviewTitle" class="form-label">제목<span
                                                                    class="text-danger">*</span></label>
                                                            <input type="text" class="form-control" id="reviewTitle"
                                                                name="reviewTitle" placeholder="제목을 입력하세요">
                                                        </div>
                                                        <%-- // 제목 --%>

                                                            <%-- 내용 --%>
                                                                <div class="mb-3">
                                                                    <label for="reviewContent"
                                                                        class="form-label">내용<span
                                                                            class="text-danger">*</span></label>
                                                                    <textarea class="form-control" id="reviewContent"
                                                                        name="reviewContent" rows="5"
                                                                        placeholder="내용을 입력하세요"></textarea>
                                                                </div>
                                                                <%-- // 내용 --%>

                                                                    <%-- 장례 날짜 (추가된 필드 예시 - FuneralReviewDTO에
                                                                        funeralDate가 Date 타입으로 있음) --%>
                                                                        <div class="mb-3">
                                                                            <label for="funeralDate"
                                                                                class="form-label">장례 날짜</label>
                                                                            <input type="date" class="form-control"
                                                                                id="funeralDate" name="funeralDate">
                                                                        </div>
                                                                        <%-- // 장례 날짜 --%>

                                                                            <%-- 장소 (추가된 필드 예시 - FuneralReviewDTO에
                                                                                location이 String 타입으로 있음) --%>
                                                                                <div class="mb-3">
                                                                                    <label for="location"
                                                                                        class="form-label">장소</label>
                                                                                    <input type="text"
                                                                                        class="form-control"
                                                                                        id="location" name="location"
                                                                                        placeholder="장례식장 위치를 입력하세요">
                                                                                </div>
                                                                                <%-- // 장소 --%>

                                                                                    <%-- 첨부파일 --%>
                                                                                        <div class="mb-3">
                                                                                            <label for="uploadFile"
                                                                                                class="form-label">첨부
                                                                                                파일</label>
                                                                                            <input type="file"
                                                                                                class="form-control"
                                                                                                id="uploadFile"
                                                                                                name="uploadFile"
                                                                                                accept="*/*">
                                                                                            <small
                                                                                                class="form-text text-muted">파일
                                                                                                크기는 10MB 이하만
                                                                                                가능합니다.</small>
                                                                                        </div>
                                                                                        <%-- // 첨부파일 --%>
                                                </div>
                                                <div class="card-footer">
                                                    <div>
                                                        <button type="submit" class="btn btn-primary">등록</button>
                                                        <%-- 취소 버튼 경로 수정 --%>
                                                            <a href="${pageContext.request.contextPath}/funeral-reviews"
                                                                class="btn btn-secondary">취소</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                        <%-- // 게시글 등록 --%>
                            </div>
                        </div>
                        <%-- // 페이지 내용 --%>
                </div>

                <%-- 자바스크립트 --%>
                    <%@ include file="../../common/script.jsp" %>
                        <script>
                            $(document).ready(function () {
                                // TinyMCE 초기화
                                tinymce.init({
                                    selector: '#reviewContent', // name 속성과 일치시킴
                                    language: 'ko_KR',
                                    setup: function (editor) {
                                        editor.on('change', function () {
                                            editor.save();
                                            validateContent();
                                        });
                                    }
                                });

                                function validateContent() {
                                    var content = tinymce.get('reviewContent').getContent(); // id와 일치시킴
                                    var textContent = $('<div>').html(content).text();

                                    if (textContent.length < 2) {
                                        $('#reviewContent').addClass('is-invalid');
                                        $('#content-error').remove();
                                        $('#reviewContent').closest('.mb-3').append('<div id="content-error" class="invalid-feedback">내용은 최소 2자 이상 입력하세요.</div>');
                                        return false;
                                    } else if (textContent.length > 1000) { // 글자 수 제한은 필요에 따라 조정
                                        $('#reviewContent').addClass('is-invalid');
                                        $('#content-error').remove();
                                        $('#reviewContent').closest('.mb-3').append('<div id="content-error" class="invalid-feedback">내용은 최대 1000자 이하로 입력하세요.</div>');
                                        return false;
                                    } else {
                                        $('#reviewContent').removeClass('is-invalid').addClass('is-valid');
                                        $('#content-error').remove();
                                        return true;
                                    }
                                }

                                $('#createForm').validate({
                                    rules: {
                                        reviewTitle: { // name 속성과 일치시킴
                                            required: true,
                                            minlength: 2,
                                            maxlength: 100
                                        },
                                        // funeralDate, location 등의 다른 필드 유효성 검사 추가 가능
                                    },
                                    messages: {
                                        reviewTitle: { // name 속성과 일치시킴
                                            required: '제목을 입력하세요.',
                                            minlength: '제목은 최소 2자 이상 입력하세요.',
                                            maxlength: '제목은 최대 100자 이하로 입력하세요.'
                                        }
                                    },
                                    errorClass: 'is-invalid',
                                    validClass: 'is-valid',
                                    errorPlacement: function (error, element) {
                                        error.addClass('invalid-feedback');
                                        element.closest('.mb-3').append(error);
                                    },
                                    submitHandler: function (form) {
                                        if (validateContent()) {
                                            form.submit();
                                        }
                                        return false;
                                    }
                                });
                            });
                        </script>
                        <%-- // 자바스크립트 --%>
            </body>

            </html>