<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ page import="java.time.format.DateTimeFormatter" %>

                    <!DOCTYPE html>
                    <html lang="ko">

                    <head>
                        <jsp:include page="/WEB-INF/views/common/head.jsp" />
                        <title>공지사항 상세보기 - Star's Haven, 반려동물 장례식장</title>

                        <!-- 공지사항 상세보기 전용 CSS -->
                        <link rel="stylesheet" href="<c:url value='/resources/css/noticestyle.css'/>" />

                        <style>
                            .detail-container {
                                max-width: 900px;
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

                            .notice-detail {
                                background: white;
                                border-radius: 10px;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                                overflow: hidden;
                            }

                            .notice-header {
                                background: white;
                                color: black;
                                padding: 30px;
                                position: relative;
                            }

                            .notice-header::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: 0;
                                right: 0;
                                bottom: 0;
                                background: rgba(0, 0, 0, 0.1);
                            }

                            .notice-header-content {
                                position: relative;
                                z-index: 1;
                            }

                            .notice-title {
                                font-size: 1.8em;
                                font-weight: 700;
                                margin-bottom: 15px;
                                line-height: 1.3;
                            }

                            .notice-meta {
                                display: flex;
                                flex-wrap: wrap;
                                gap: 20px;
                                font-size: 0.95em;
                                opacity: 0.9;
                            }

                            .meta-item {
                                display: flex;
                                align-items: center;
                                gap: 8px;
                            }

                            .meta-item i {
                                font-size: 1.1em;
                            }

                            .notice-content {
                                padding: 40px;
                            }

                            .content-text {
                                font-size: 1.1em;
                                line-height: 1.8;
                                color: #333;
                                word-break: break-word;
                                white-space: pre-wrap;
                            }

                            .notice-actions {
                                padding: 30px 40px;
                                background: #f8f9fa;
                                border-top: 1px solid #e9ecef;
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                flex-wrap: wrap;
                                gap: 15px;
                            }

                            .action-group {
                                display: flex;
                                gap: 10px;
                                flex-wrap: wrap;
                            }

                            .btn {
                                display: inline-block;
                                padding: 10px 20px;
                                border: none;
                                border-radius: 6px;
                                font-size: 1em;
                                font-weight: 600;
                                text-decoration: none;
                                cursor: pointer;
                                transition: all 0.3s ease;
                                text-align: center;
                                min-width: 100px;
                            }

                            .btn-primary {
                                background: #3498db;
                                color: white;
                            }

                            .btn-primary:hover {
                                background: #2980b9;
                                transform: translateY(-2px);
                            }

                            .btn-warning {
                                background: #f39c12;
                                color: white;
                            }

                            .btn-warning:hover {
                                background: #e67e22;
                                transform: translateY(-2px);
                            }

                            .btn-danger {
                                background: #e74c3c;
                                color: white;
                            }

                            .btn-danger:hover {
                                background: #c0392b;
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

                            .notice-navigation {
                                margin-top: 30px;
                                padding: 20px;
                                background: white;
                                border-radius: 10px;
                                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            }

                            .nav-title {
                                font-size: 1.2em;
                                font-weight: 600;
                                color: #2c3e50;
                                margin-bottom: 15px;
                                text-align: center;
                            }

                            .nav-item {
                                padding: 12px 15px;
                                border-bottom: 1px solid #e9ecef;
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                            }

                            .nav-item:last-child {
                                border-bottom: none;
                            }

                            .nav-link {
                                color: #3498db;
                                text-decoration: none;
                                font-weight: 500;
                                flex: 1;
                                margin-right: 10px;
                            }

                            .nav-link:hover {
                                color: #2980b9;
                                text-decoration: underline;
                            }

                            .nav-date {
                                color: #6c757d;
                                font-size: 0.9em;
                                white-space: nowrap;
                            }

                            .no-notice {
                                color: #6c757d;
                                font-style: italic;
                            }

                            @media (max-width: 768px) {
                                .detail-container {
                                    padding: 10px;
                                }

                                .notice-header {
                                    padding: 20px;
                                }

                                .notice-title {
                                    font-size: 1.4em;
                                }

                                .notice-meta {
                                    flex-direction: column;
                                    gap: 10px;
                                }

                                .notice-content {
                                    padding: 20px;
                                }

                                .notice-actions {
                                    padding: 20px;
                                    flex-direction: column;
                                }

                                .action-group {
                                    width: 100%;
                                    justify-content: center;
                                }

                                .btn {
                                    flex: 1;
                                    min-width: auto;
                                }
                            }

                            @keyframes fadeOut {
                                from {
                                    opacity: 1;
                                }

                                to {
                                    opacity: 0;
                                }
                            }
                        </style>
                    </head>

                    <body>
                        <div class="page-wrapper">
                            <!-- Navbar -->
                            <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                            <main class="main-wrapper">
                                <div class="detail-container">
                                    <!-- 페이지 헤더 -->
                                    <div class="page-header">
                                        <h1>📋 공지사항 상세보기</h1>
                                        <p>중요한 공지사항을 확인하세요</p>
                                    </div>

                                    <!-- 알림 메시지 -->
                                    <c:if test="${not empty success}">
                                        <div class="alert alert-success">${success}</div>
                                    </c:if>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-error">${error}</div>
                                    </c:if>

                                    <!-- 공지사항이 존재하지 않는 경우 -->
                                    <c:if test="${empty notice}">
                                        <div class="notice-detail">
                                            <div class="notice-content" style="text-align: center; padding: 60px 40px;">
                                                <i class="fas fa-exclamation-triangle"
                                                    style="font-size: 3em; color: #f39c12; margin-bottom: 20px;"></i>
                                                <h2 style="color: #2c3e50; margin-bottom: 15px;">공지사항을 찾을 수 없습니다</h2>
                                                <p style="color: #6c757d; margin-bottom: 30px;">요청하신 공지사항이 삭제되었거나 존재하지
                                                    않습니다.</p>
                                                <a href="<c:url value='/notice/list'/>" class="btn btn-primary">
                                                    <i class="fas fa-list"></i> 공지사항 목록으로 돌아가기
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- 공지사항 상세 내용 -->
                                    <c:if test="${not empty notice}">
                                        <div class="notice-detail">
                                            <!-- 공지사항 헤더 -->
                                            <div class="notice-header">
                                                <div class="notice-header-content">
                                                    <h1 class="notice-title">${notice.title}</h1>
                                                    <div class="notice-meta">
                                                        <div class="meta-item">
                                                            <i class="fas fa-user"></i>
                                                            <span>
                                                                <c:choose>
                                                                    <c:when test="${not empty notice.author}">
                                                                        ${notice.author}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        관리자
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </div>
                                                        <div class="meta-item">
                                                            <i class="fas fa-calendar-alt"></i>
                                                            <span>
                                                                <c:choose>
                                                                    <c:when test="${notice.createdDate != null}">
                                                                        ${notice.createdDate.toString().substring(0,
                                                                        16).replace('T', ' ')}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        작성일 정보 없음
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </div>
                                                        <c:if
                                                            test="${notice.updatedDate != null && notice.updatedDate != notice.createdDate}">
                                                            <div class="meta-item">
                                                                <i class="fas fa-edit"></i>
                                                                <span>수정: ${notice.updatedDate.toString().substring(0,
                                                                    16).replace('T', ' ')}</span>
                                                            </div>
                                                        </c:if>
                                                        <div class="meta-item">
                                                            <i class="fas fa-bookmark"></i>
                                                            <span>공지사항</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- 공지사항 내용 -->
                                            <div class="notice-content">
                                                <div class="content-text">
                                                    <c:choose>
                                                        <c:when test="${not empty notice.content}">
                                                            ${notice.content}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p style="color: #6c757d; font-style: italic;">내용이 없습니다.</p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <!-- 액션 버튼들 -->
                                            <div class="notice-actions">
                                                <div class="action-group">
                                                    <a href="<c:url value='/notice/list'/>" class="btn btn-secondary">
                                                        <i class="fas fa-list"></i> 목록
                                                    </a>
                                                </div>

                                                <!-- 관리자 전용 버튼들 -->
                                                <c:set var="adminCheck"
                                                    value="${isAdmin || (sessionScope.userId == 'admin' && sessionScope.password == 'admin1234') || sessionScope.role == 'ADMIN'}" />
                                                <c:if test="${sessionScope.userId == 'admin' || adminCheck}">
                                                    <div class="action-group">
                                                        <a href="<c:url value='/notice/edit/${notice.id}'/>"
                                                            class="btn btn-warning">
                                                            <i class="fas fa-edit"></i> 수정
                                                        </a>
                                                        <form method="post"
                                                            action="<c:url value='/notice/delete/${notice.id}'/>"
                                                            style="display: inline;" onsubmit="return confirmDelete();">
                                                            <button type="submit" class="btn btn-danger">
                                                                <i class="fas fa-trash"></i> 삭제
                                                            </button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>

                                        <!-- 이전/다음 공지사항 네비게이션 -->
                                        <div class="notice-navigation">
                                            <div class="nav-title">
                                                <i class="fas fa-arrows-alt-v"></i> 다른 공지사항
                                            </div>

                                            <!-- 이전 공지사항 -->
                                            <div class="nav-item">
                                                <c:choose>
                                                    <c:when test="${not empty prevNotice}">
                                                        <a href="<c:url value='/notice/detail/${prevNotice.id}'/>"
                                                            class="nav-link">
                                                            <i class="fas fa-chevron-up"></i> 이전글: ${prevNotice.title}
                                                        </a>
                                                        <span class="nav-date">
                                                            <c:if test="${prevNotice.createdDate != null}">
                                                                <c:set var="prevDateStr"
                                                                    value="${prevNotice.createdDate.toString()}" />
                                                                <c:set var="prevDatePart"
                                                                    value="${fn:substring(prevDateStr, 0, 10)}" />
                                                                ${prevDatePart}
                                                            </c:if>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="no-notice">
                                                            <i class="fas fa-chevron-up"></i> 이전 공지사항이 없습니다
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- 다음 공지사항 -->
                                            <div class="nav-item">
                                                <c:choose>
                                                    <c:when test="${not empty nextNotice}">
                                                        <a href="<c:url value='/notice/detail/${nextNotice.id}'/>"
                                                            class="nav-link">
                                                            <i class="fas fa-chevron-down"></i> 다음글: ${nextNotice.title}
                                                        </a>
                                                        <span class="nav-date">
                                                            <c:if test="${nextNotice.createdDate != null}">
                                                                <c:set var="nextDateStr"
                                                                    value="${nextNotice.createdDate.toString()}" />
                                                                <c:set var="nextDatePart"
                                                                    value="${fn:substring(nextDateStr, 0, 10)}" />
                                                                ${nextDatePart}
                                                            </c:if>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="no-notice">
                                                            <i class="fas fa-chevron-down"></i> 다음 공지사항이 없습니다
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </main>

                            <!-- Footer -->
                            <jsp:include page="/WEB-INF/views/common/footer.jsp" />

                            <!-- 공통 스크립트 -->
                            <jsp:include page="/WEB-INF/views/common/script.jsp" />
                        </div>

                        <script>
                            // 삭제 확인 함수
                            function confirmDelete() {
                                return confirm('⚠️ 정말로 이 공지사항을 삭제하시겠습니까?\n\n삭제된 공지사항은 복구할 수 없습니다.\n확실하다면 "확인"을 클릭해주세요.');
                            }

                            // 페이지 초기화
                            document.addEventListener('DOMContentLoaded', function () {
                                // 알림 메시지 자동 숨김
                                const alerts = document.querySelectorAll('.alert');
                                alerts.forEach(function (alert) {
                                    setTimeout(function () {
                                        alert.style.animation = 'fadeOut 0.5s ease-out forwards';
                                        setTimeout(function () {
                                            alert.remove();
                                        }, 500);
                                    }, 5000);
                                });

                                // 키보드 단축키
                                document.addEventListener('keydown', function (e) {
                                    // ESC 키로 목록으로 돌아가기
                                    if (e.key === 'Escape') {
                                        window.location.href = '<c:url value="/notice/list"/>';
                                    }

                                    // E 키로 수정 (관리자만)
                                    if (e.key === 'e' || e.key === 'E') {
                                        const editButton = document.querySelector('a[href*="/edit/"]');
                                        if (editButton && !e.ctrlKey && !e.altKey && !e.shiftKey) {
                                            // 입력 필드에 포커스가 있지 않을 때만
                                            if (!document.activeElement ||
                                                (document.activeElement.tagName !== 'INPUT' &&
                                                    document.activeElement.tagName !== 'TEXTAREA')) {
                                                window.location.href = editButton.href;
                                            }
                                        }
                                    }
                                });

                                // 내용 영역의 링크들을 새 창에서 열기
                                const contentLinks = document.querySelectorAll('.content-text a');
                                contentLinks.forEach(function (link) {
                                    if (link.hostname !== window.location.hostname) {
                                        link.target = '_blank';
                                        link.rel = 'noopener noreferrer';
                                    }
                                });

                                // 스크롤 애니메이션
                                const observerOptions = {
                                    threshold: 0.1,
                                    rootMargin: '0px 0px -100px 0px'
                                };

                                const observer = new IntersectionObserver(function (entries) {
                                    entries.forEach(function (entry) {
                                        if (entry.isIntersecting) {
                                            entry.target.style.opacity = '1';
                                            entry.target.style.transform = 'translateY(0)';
                                        }
                                    });
                                }, observerOptions);

                                // 관찰할 요소들
                                const animateElements = document.querySelectorAll('.notice-detail, .notice-navigation');
                                animateElements.forEach(function (el) {
                                    el.style.opacity = '0';
                                    el.style.transform = 'translateY(20px)';
                                    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                                    observer.observe(el);
                                });
                            });
                        </script>
                    </body>

                    </html>