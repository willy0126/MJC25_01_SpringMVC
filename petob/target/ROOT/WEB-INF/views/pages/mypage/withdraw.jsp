<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>회원 탈퇴</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
            <link rel="stylesheet" href="<c:url value='/resources/css/mypagestyle.css'/>">
        </head>

        <body>
            <div class="page-wrapper">
                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
                <div class="main-wrapper">
                    <div class="mypage-layout-container">
                        <aside class="mypage-sidebar">
                            <h3 class="sidebar-title">마이페이지</h3>
                            <nav class="sidebar-nav">
                                <ul>
                                    <li class="nav-item"><a href="<c:url value='/mypage'/>">예약 내역</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/my-inquiry'/>">나의 문의</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/edit'/>">개인정보 수정</a></li>
                                    <li class="nav-item"><a href="<c:url value='/mypage/change-password'/>">비밀번호 변경</a>
                                    </li>
                                    <li class="nav-item active"><a href="<c:url value='/mypage/withdraw'/>">회원 탈퇴</a>
                                    </li>
                                </ul>
                            </nav>
                        </aside>

                        <main class="mypage-content">
                            <h2>회원 탈퇴</h2>
                            <p class="sub-text">회원 탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다. 신중히 결정해주세요.</p>
                            <hr class="title-divider">

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success" role="alert">${successMessage}</div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger" role="alert">${errorMessage}</div>
                            </c:if>

                            <section class="withdrawal-container">
                                <div class="alert alert-warning" role="alert">
                                    <h4 class="alert-heading"><i class="fas fa-exclamation-triangle"></i> 주의사항</h4>
                                    <p>회원 탈퇴를 진행하시면 다음 사항에 동의하는 것으로 간주합니다:</p>
                                    <ul>
                                        <li>모든 개인 정보가 영구적으로 삭제됩니다.</li>
                                        <li>예약 내역, 문의 내역 등 모든 활동 기록이 삭제됩니다.</li>
                                        <li>삭제된 정보는 어떠한 경우에도 복구할 수 없습니다.</li>
                                        <li>동일한 아이디로 재가입 시 이전 정보를 이용할 수 없습니다.</li>
                                    </ul>
                                    <hr>
                                    <p class="mb-0">정말로 탈퇴하시겠습니까?</p>
                                </div>

                                <%-- 비밀번호 확인 후 탈퇴 진행을 위해, 여기서 비밀번호를 다시 한번 입력받는 것이 좋습니다. --%>
                                    <form action="<c:url value='/mypage/withdraw'/>" method="post" id="withdrawForm">
                                        <div class="mb-3">
                                            <label for="password" class="form-label"><strong>비밀번호 재확인</strong></label>
                                            <input type="password" class="form-control" id="password" name="password"
                                                placeholder="계정 비밀번호를 다시 입력해주세요." required>
                                            <div class="form-text">회원 탈퇴를 위해 비밀번호를 다시 한번 입력해주세요.</div>
                                        </div>
                                        <div class="form-check mb-3">
                                            <input class="form-check-input" type="checkbox" value="true"
                                                id="confirmWithdrawCheck" name="confirmWithdraw" required>
                                            <label class="form-check-label" for="confirmWithdrawCheck">
                                                위 주의사항을 모두 확인했으며, 회원 탈퇴에 동의합니다.
                                            </label>
                                        </div>
                                        <button type="submit" class="btn btn-danger">회원 탈퇴</button>
                                        <a href="<c:url value='/mypage'/>" class="btn btn-secondary">취소</a>
                                    </form>
                            </section>
                        </main>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            </div>

            <script>
                // 간단한 클라이언트 측 유효성 검사 (체크박스)
                const withdrawForm = document.getElementById('withdrawForm');
                if (withdrawForm) {
                    withdrawForm.addEventListener('submit', function (event) {
                        const confirmCheck = document.getElementById('confirmWithdrawCheck');
                        if (!confirmCheck.checked) {
                            alert('회원 탈퇴 동의 항목에 체크해주세요.');
                            event.preventDefault(); // 폼 제출 중단
                        }
                    });
                }
            </script>
        </body>

        </html>