<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
                <div class="row">
                    <div class="col-12">
                        <%-- 게시글 수정 --%>
                            <c:if test="${not empty post}">
                                <%-- action 경로 수정 --%>
                                    <form id="updateForm"
                                        action="${pageContext.request.contextPath}/funeral-reviews/${post.id}/update"
                                        method="POST" enctype="multipart/form-data">
                                        <div class="card mb-3">
                                            <div class="card-header">
                                                게시글 수정 (<span class="text-danger">*</span> 표시는 필수항목입니다.)
                                            </div>
                                            <div class="card-body">
                                                <%-- DTO의 필드명과 일치하도록 name 속성 변경 (FuneralReviewDTO 기준) --%>
                                                    <%-- 제목 --%>
                                                        <div class="mb-3">
                                                            <label for="reviewTitle" class="form-label">제목<span
                                                                    class="text-danger">*</span></label>
                                                            <input type="text" class="form-control" id="reviewTitle"
                                                                name="reviewTitle" placeholder="제목을 입력하세요"
                                                                value="${post.reviewTitle}">
                                                        </div>
                                                        <%-- // 제목 --%>

                                                            <%-- 내용 --%>
                                                                <div class="mb-3">
                                                                    <label for="reviewContent"
                                                                        class="form-label">내용<span
                                                                            class="text-danger">*</span></label>
                                                                    <textarea class="form-control" id="reviewContent"
                                                                        name="reviewContent" rows="5"
                                                                        placeholder="내용을 입력하세요">${post.reviewContent}</textarea>
                                                                </div>
                                                                <%-- // 내용 --%>

                                                                    <%-- 장례 날짜 --%>
                                                                        <div class="mb-3">
                                                                            <label for="funeralDate"
                                                                                class="form-label">장례 날짜</label>
                                                                            <%-- 날짜 형식을 yyyy-MM-dd로 포맷팅해야 input
                                                                                type="date" 에 올바르게 표시됨 --%>
                                                                                <fmt:formatDate
                                                                                    value="${post.funeralDate}"
                                                                                    pattern="yyyy-MM-dd"
                                                                                    var="formattedFuneralDate" />
                                                                                <input type="date" class="form-control"
                                                                                    id="funeralDate" name="funeralDate"
                                                                                    value="${formattedFuneralDate}">
                                                                        </div>
                                                                        <%-- // 장례 날짜 --%>

                                                                            <%-- 장소 --%>
                                                                                <div class="mb-3">
                                                                                    <label for="location"
                                                                                        class="form-label">장소</label>
                                                                                    <input type="text"
                                                                                        class="form-control"
                                                                                        id="location" name="location"
                                                                                        placeholder="장례식장 위치를 입력하세요"
                                                                                        value="${post.location}">
                                                                                </div>
                                                                                <%-- // 장소 --%>

                                                                                    <%-- 첨부파일 --%>
                                                                                        <c:if
                                                                                            test="${not empty post.fileName}">
                                                                                            <div class="mb-3">
                                                                                                <div class="mb-2">
                                                                                                    <%-- 다운로드 링크 경로 수정
                                                                                                        --%>
                                                                                                        <span>현재 파일: <a
                                                                                                                href="${pageContext.request.contextPath}/funeral-reviews/${post.id}/download"
                                                                                                                class="btn btn-sm btn-outline-primary">${post.originalFileName}</a></span>
                                                                                                </div>
                                                                                                <div class="form-check">
                                                                                                    <%-- deleteFile 체크박스
                                                                                                        value를
                                                                                                        true/false가 아닌,
                                                                                                        체크 시 true 값
                                                                                                        전송되도록 --%>
                                                                                                        <input
                                                                                                            class="form-check-input"
                                                                                                            type="checkbox"
                                                                                                            name="deleteFile"
                                                                                                            id="deleteFile"
                                                                                                            value="true">
                                                                                                        <label
                                                                                                            class="form-check-label text-danger"
                                                                                                            for="deleteFile">
                                                                                                            기존 파일 삭제
                                                                                                        </label>
                                                                                                </div>
                                                                                            </div>
                                                                                        </c:if>
                                                                                        <div class="mb-3">
                                                                                            <label for="uploadFile"
                                                                                                class="form-label">${not
                                                                                                empty post.fileName ? '새
                                                                                                파일로 변경' : '첨부
                                                                                                파일'}</label>
                                                                                            <input type="file"
                                                                                                class="form-control"
                                                                                                id="uploadFile"
                                                                                                name="uploadFile"
                                                                                                accept="*/*">
                                                                                            <small
                                                                                                class="form-text text-muted">
                                                                                                <c:if
                                                                                                    test="${not empty post.fileName}">
                                                                                                    새 파일을 선택하면 기존 파일은
                                                                                                    교체됩니다. </c:if>
                                                                                                파일 크기는 10MB 이하만 가능합니다.
                                                                                            </small>
                                                                                        </div>
                                                                                        <%-- // 첨부파일 --%>
                                            </div>
                                            <div class="card-footer">
                                                <div>
                                                    <button type="submit" class="btn btn-primary">수정</button>
                                                    <%-- 취소 버튼 경로 수정 --%>
                                                        <a href="${pageContext.request.contextPath}/funeral-reviews/${post.id}"
                                                            class="btn btn-secondary">취소</a>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                            </c:if>
                            <c:if test="${empty post}">
                                <p class="text-center">해당 게시글을 찾을 수 없거나 수정 권한이 없습니다.</p>
                                <div class="text-center">
                                    <a href="${pageContext.request.contextPath}/funeral-reviews"
                                        class="btn btn-primary">목록으로</a>
                                </div>
                            </c:if>
                            <%-- // 게시글 수정 --%>
                    </div>
                </div>
                <%-- // 페이지 내용 --%>
            </div>

            <%-- 자바스크립트 --%>
                <%@ include file="../../common/script.jsp" %>
                    <script>
                        $(document).ready(function () {
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

                            $('#updateForm').validate({
                                rules: {
                                    reviewTitle: { // name 속성과 일치시킴
                                        required: true,
                                        minlength: 2,
                                        maxlength: 100
                                    }
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
                                        // 파일 삭제 체크박스의 값을 true로 설정 (체크되었을 경우)
                                        if ($('#deleteFile').is(':checked')) {
                                            // 이미 form 전송 시 value="true"로 설정되므로 별도 처리 불필요할 수 있으나,
                                            // 명시적으로 hidden input을 추가하거나 JavaScript로 값을 설정할 수도 있음.
                                            // 현재는 Controller에서 boolean isDeleteFile()로 받으므로 value="true"면 true로 변환됨.
                                        }
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