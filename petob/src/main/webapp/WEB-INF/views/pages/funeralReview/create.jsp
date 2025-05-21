<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="../../common/head.jsp" %>
<body>
    <div class="container">
        <%-- 네비게이션 --%>
        <%@ include file="../../common/navbar.jsp" %>
        <%--// 네비게이션 --%>

        <%-- 페이지 제목 --%>
        <%@ include file="../../common/title.jsp" %>
        <%--// 페이지 제목 --%>

        <%-- 메시지 --%>
        <%@ include file="../../common/message.jsp" %>
        <%--// 메시지 --%>

        <%-- 페이지 내용 --%>
        <div class="row">
            <div class="col-12">
                <%-- 게시글 등록 --%>
                <form id="createForm" action="/FuneralReview-posts/create" method="POST" enctype="multipart/form-data">
                    <div class="card mb-3">
                        <div class="card-header">
                            게시글 등록 (<span class="text-danger">*</span> 표시는 필수항목입니다.)
                        </div>
                        <div class="card-body">
                            <%-- 제목 --%>
                            <div class="mb-3">
                                <label for="title" class="form-label">제목<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요">
                            </div>
                            <%--// 제목 --%>

                            <%-- 내용 --%>
                            <div class="mb-3">
                                <label for="content" class="form-label">내용<span class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="5" placeholder="내용을 입력하세요"></textarea>
                            </div>
                            <%--// 내용 --%>

                            <%-- 첨부파일 --%>
                            <div class="mb-3">
                                <label for="uploadFile" class="form-label">첨부 파일</label>
                                <input type="file" class="form-control" id="uploadFile" name="uploadFile" accept="*/*">
                                <small class="form-text text-muted">파일 크기는 10MB 이하만 가능합니다.</small>
                            </div>
                            <%--// 첨부파일 --%>
                        </div>
                        <div class="card-footer">
                            <div>
                                <button type="submit" class="btn btn-primary">등록</button>
                                <a href="/FuneralReview-posts" class="btn btn-secondary">취소</a>
                            </div>
                        </div>
                    </div>
                </form>
                <%--// 게시글 등록 --%>
            </div>
        </div>
        <%--// 페이지 내용 --%>
    </div>

    <%-- 자바스크립트 --%>
    <%@ include file="../../common/script.jsp" %>
    <script>
        $(document).ready(function() {
            // TinyMCE 초기화
            tinymce.init({
                selector: '#content',
                language: 'ko_KR',
                // TinyMCE 필수 입력 설정
                setup: function(editor) {
                    editor.on('change', function() {
                        editor.save(); // 에디터 내용을 textarea에 반영
                        validateContent(); // 컨텐츠 유효성 검사
                    });
                }
            });

            // 컨텐츠 유효성 검사 함수
            function validateContent() {
                var content = tinymce.get('content').getContent();
                var textContent = $('<div>').html(content).text(); // HTML 태그 제거

                if (textContent.length < 2) {
                    $('#content').addClass('is-invalid');
                    $('#content-error').remove();
                    $('#content').closest('.mb-3').append('<div id="content-error" class="invalid-feedback">내용은 최소 2자 이상 입력하세요.</div>');
                    return false;
                } else if (textContent.length > 1000) {
                    $('#content').addClass('is-invalid');
                    $('#content-error').remove();
                    $('#content').closest('.mb-3').append('<div id="content-error" class="invalid-feedback">내용은 최대 1000자 이하로 입력하세요.</div>');
                    return false;
                } else {
                    $('#content').removeClass('is-invalid').addClass('is-valid');
                    $('#content-error').remove();
                    return true;
                }
            }

            // 게시글 폼 검증
            $('#createForm').validate({
                rules: {
                    title: {
                        required: true,
                        minlength: 2,
                        maxlength: 100
                    }
                },
                messages: {
                    title: {
                        required: '제목을 입력하세요.',
                        minlength: '제목은 최소 2자 이상 입력하세요.',
                        maxlength: '제목은 최대 100자 이하로 입력하세요.'
                    }
                },
                errorClass: 'is-invalid',
                validClass: 'is-valid',
                errorPlacement: function(error, element) {
                    error.addClass('invalid-feedback');
                    element.closest('.mb-3').append(error);
                },
                submitHandler: function(form) {
                    // 폼 제출 전 내용 검증
                    if (validateContent()) {
                        form.submit();
                    }
                    return false;
                }
            });
        });
    </script>
    <%--// 자바스크립트 --%>
</body>
</html>
