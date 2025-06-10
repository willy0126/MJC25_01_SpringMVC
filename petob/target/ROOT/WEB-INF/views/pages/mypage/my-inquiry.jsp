<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>나의 문의</title>
                    <%-- 공통 스타일 및 라이브러리 --%>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
                            rel="stylesheet">
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
                        <link rel="stylesheet"
                            href="${pageContext.request.contextPath}/resources/css/mypagestyle.css">
                        <style>
                            /* 마이페이지 공통 스타일 */
                            .mypage-sidebar .sidebar-nav .nav-item.active a {
                                background-color: #0d6efd;
                                color: white;
                                font-weight: bold;
                            }

                            .flash-message {
                                margin-bottom: 1rem;
                            }

                            /* 문의 테이블 스타일 */
                            .inquiry-table {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    width: 100%; /* 테이블 폭을 100%로 설정 */
    min-width: 1000px; /* 최소 폭 설정으로 테이블 늘리기 */
    table-layout: fixed; /* 열 폭 고정으로 일정하게 늘리기 */
}

                            .inquiry-table th {
                                background-color: #f8f9fa;
                                border-bottom: 2px solid #dee2e6;
                                font-weight: 600;
                                color: #495057;
                                text-align: center;
                                vertical-align: middle;
                                padding: 1rem 0.75rem;
                            }

                            .inquiry-table td {
                                padding: 1rem 0.75rem;
                                vertical-align: middle;
                                border-bottom: 1px solid #dee2e6;
                                text-align: center;
                            }

                            .inquiry-table tbody tr:hover {
                                background-color: #f8f9fa;
                                transition: background-color 0.2s;
                            }

                            .inquiry-table tbody tr:last-child td {
                                border-bottom: none;
                            }

                            /* 제목 열 스타일 */
                            .title-cell {
                                text-align: left !important;
                                max-width: 300px;
                            }

                            .title-link {
                                color: #212529;
                                text-decoration: none;
                                font-weight: 500;
                                cursor: pointer;
                            }

                            .title-link:hover {
                                color: #0d6efd;
                                text-decoration: underline;
                            }

                            .secret-icon {
                                color: #6c757d;
                                margin-left: 0.5rem;
                            }

                            /* 상태 배지 스타일 */
                            .status-waiting {
                                background-color: #fff3cd;
                                color: #856404;
                                border: 1px solid #ffeaa7;
                                padding: 0.25rem 0.5rem;
                                border-radius: 4px;
                                font-size: 0.85em;
                                font-weight: 500;
                            }

                            .status-processing {
                                background-color: #cce5ff;
                                color: #004085;
                                border: 1px solid #99d6ff;
                                padding: 0.25rem 0.5rem;
                                border-radius: 4px;
                                font-size: 0.85em;
                                font-weight: 500;
                            }

                            .status-completed {
                                background-color: #d1edff;
                                color: #0c5460;
                                border: 1px solid #bee5eb;
                                padding: 0.25rem 0.5rem;
                                border-radius: 4px;
                                font-size: 0.85em;
                                font-weight: 500;
                            }

                            /* 새 문의 작성 버튼 */
                            .write-inquiry-btn {
                                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                border: none;
                                color: white;
                                padding: 0.75rem 1.5rem;
                                border-radius: 8px;
                                font-weight: 600;
                                transition: all 0.3s ease;
                                text-decoration: none;
                                display: inline-flex;
                                align-items: center;
                                gap: 0.5rem;
                            }

                            .write-inquiry-btn:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                                color: white;
                                text-decoration: none;
                            }

                            /* 빈 상태 메시지 */
                            .no-data-message {
                                text-align: center;
                                padding: 4rem 2rem;
                                background: #f8f9fa;
                                border-radius: 8px;
                                margin: 2rem 0;
                            }

                            .no-data-message i {
                                color: #6c757d;
                                margin-bottom: 1.5rem;
                            }

                            /* 문의 요약 정보 */
                            .inquiry-summary {
                                background: white;
                                padding: 1rem 1.5rem;
                                border-radius: 6px;
                                border-left: 4px solid #007bff;
                                margin-bottom: 1.5rem;
                                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                            }

                            /* 액션 버튼들 */
                            .action-btn {
                                padding: 0.375rem 0.75rem;
                                font-size: 0.875rem;
                                border-radius: 4px;
                                margin: 0 0.25rem;
                                text-decoration: none;
                                display: inline-block;
                                transition: all 0.2s;
                            }

                            .btn-view {
                                background-color: #0d6efd;
                                color: white;
                                border: 1px solid #0d6efd;
                            }

                            .btn-view:hover {
                                background-color: #0b5ed7;
                                color: white;
                            }

                            /* 반응형 디자인 */
                            @media (max-width: 768px) {
                                .inquiry-table {
                                    font-size: 0.875rem;
                                }
                                
                                .inquiry-table th,
                                .inquiry-table td {
                                    padding: 0.5rem 0.25rem;
                                }
                                
                                .title-cell {
                                    max-width: 150px;
                                }
                                
                                .inquiry-summary {
                                    flex-direction: column;
                                    gap: 1rem;
                                    text-align: center;
                                }
                            }

                            /* 테이블 헤더 아이콘 */
                            .table-header-icon {
                                margin-right: 0.5rem;
                                color: #6c757d;
                            }
                        </style>
                </head>

                <body>
                    <div class="page-wrapper">
                        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

                        <div class="main-wrapper">
                            <div class="mypage-layout-container container mt-4 mb-4">
                                <%-- 왼쪽 사이드바 --%>
                                    <aside class="mypage-sidebar">
                                        <h3 class="sidebar-title">마이페이지</h3>
                                        <nav class="sidebar-nav">
                                            <ul>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/mypage">예약 확인</a>
                                                </li>
                                                <li class="nav-item active">
                                                    <a href="${pageContext.request.contextPath}/mypage/my-inquiry">나의 문의</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/mypage/edit">개인정보 수정</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/mypage/change-password">비밀번호 변경</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a href="${pageContext.request.contextPath}/mypage/withdraw">회원 탈퇴</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </aside>

                                    <%-- 오른쪽 콘텐츠 영역 --%>
                                        <main class="mypage-content">
                                            <%-- 성공/에러 메시지 표시 --%>
                                                <c:if test="${not empty successMessage}">
                                                    <div class="alert alert-success flash-message" role="alert">
                                                        <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty errorMessage}">
                                                    <div class="alert alert-danger flash-message" role="alert">
                                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                                                    </div>
                                                </c:if>

                                                <%-- 페이지 헤더 --%>
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <div>
                                                        <h2><i class="bi bi-question-circle-fill me-2"></i>나의 문의</h2>
                                                        <p class="sub-text mb-0">작성하신 문의 내역과 답변을 확인하실 수 있습니다.</p>
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}/inquiry/write" 
                                                       class="write-inquiry-btn">
                                                        <i class="bi bi-plus-circle"></i>
                                                        새 문의 작성
                                                    </a>
                                                </div>

                                                <hr class="title-divider mb-4">

                                                <%-- 문의 목록 --%>
                                                <div class="inquiry-container">
                                                    <c:choose>
                                                        <c:when test="${not empty myInquiryList}">
                                                            <%-- 문의 요약 정보 --%>
                                                            <div class="inquiry-summary">
                                                                <div>
                                                                    <i class="bi bi-chat-dots me-2"></i>
                                                                    총 <strong class="text-primary">${totalCount}</strong>건의 문의가 있습니다
                                                                </div>
                                                                <c:if test="${not empty currentPage and not empty totalPages}">
                                                                    <div class="text-muted">
                                                                        ${currentPage}/${totalPages} 페이지
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                            
                                                            <%-- 문의 테이블 --%>
                                                            <div class="table-responsive">
                                                                <table class="inquiry-table table table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="width: 80px;">
                                                                                <i class="bi bi-hash table-header-icon"></i>번호
                                                                            </th>
                                                                            <th style="width: 120px;">
                                                                                <i class="bi bi-tag table-header-icon"></i>카테고리
                                                                            </th>
                                                                            <th>
                                                                                <i class="bi bi-chat-text table-header-icon"></i>제목
                                                                            </th>
                                                                            <th style="width: 120px;">
                                                                                <i class="bi bi-flag table-header-icon"></i>처리상태
                                                                            </th>
                                                                            <th style="width: 130px;">
                                                                                <i class="bi bi-calendar3 table-header-icon"></i>작성일
                                                                            </th>
                                                                            <th style="width: 100px;">
                                                                                <i class="bi bi-gear table-header-icon"></i>관리
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:forEach var="inquiry" items="${myInquiryList}" varStatus="status">
                                                                            <tr>
                                                                                <td>${inquiry.inquiryId}</td>
                                                                                <td>
                                                                                    <span class="badge bg-light text-dark">
                                                                                        ${inquiry.categoryName != null ? inquiry.categoryName : '일반문의'}
                                                                                    </span>
                                                                                </td>
                                                                                <td class="title-cell">
                                                                                    <a href="${pageContext.request.contextPath}/inquiry/view/${inquiry.inquiryId}" 
                                                                                       class="title-link">
                                                                                        <c:out value="${inquiry.title}" />
                                                                                    </a>
                                                                                    <c:if test="${inquiry.isSecret}">
                                                                                        <i class="bi bi-lock-fill secret-icon" title="비밀글"></i>
                                                                                    </c:if>
                                                                                    <c:if test="${not empty inquiry.replyContent}">
                                                                                        <i class="bi bi-reply-fill text-success ms-1" title="답변완료"></i>
                                                                                    </c:if>
                                                                                </td>
                                                                                <td>
                                                                                    <c:choose>
                                                                                        <c:when test="${inquiry.status == 'WAITING' or inquiry.status == '답변대기'}">
                                                                                            <span class="status-waiting">답변대기</span>
                                                                                        </c:when>
                                                                                        <c:when test="${inquiry.status == 'PROCESSING' or inquiry.status == '처리중'}">
                                                                                            <span class="status-processing">처리중</span>
                                                                                        </c:when>
                                                                                        <c:when test="${inquiry.status == 'COMPLETED' or inquiry.status == '답변완료'}">
                                                                                            <span class="status-completed">답변완료</span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span class="status-waiting">답변대기</span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </td>
                                                                                <td>
                                                                                 ${fn:substring(inquiry.createdDate, 0, 10)}
                                                                               </td>
                                                                                <td>
                                                                                    <a href="${pageContext.request.contextPath}/inquiry/view/${inquiry.inquiryId}" 
                                                                                       class="action-btn btn-view" title="상세보기">
                                                                                        보기
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                            
                                                            <%-- 페이징 처리 --%>
                                                            <c:if test="${not empty totalPages and totalPages > 1}">
                                                                <nav aria-label="Page navigation" class="mt-4">
                                                                    <ul class="pagination justify-content-center">
                                                                        <c:if test="${currentPage > 1}">
                                                                            <li class="page-item">
                                                                                <a class="page-link" href="${pageContext.request.contextPath}/mypage/my-inquiry?page=${currentPage - 1}">
                                                                                    <i class="bi bi-chevron-left"></i> 이전
                                                                                </a>
                                                                            </li>
                                                                        </c:if>
                                                                        
                                                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                                                <a class="page-link" href="${pageContext.request.contextPath}/mypage/my-inquiry?page=${i}">${i}</a>
                                                                            </li>
                                                                        </c:forEach>
                                                                        
                                                                        <c:if test="${currentPage < totalPages}">
                                                                            <li class="page-item">
                                                                                <a class="page-link" href="${pageContext.request.contextPath}/mypage/my-inquiry?page=${currentPage + 1}">
                                                                                    다음 <i class="bi bi-chevron-right"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>
                                                                    </ul>
                                                                </nav>
                                                            </c:if>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="no-data-message">
                                                                <i class="bi bi-chat-square-text" style="font-size: 4rem;"></i>
                                                                <h4 class="mt-3 mb-2">작성하신 문의가 없습니다</h4>
                                                                <p class="text-muted mb-4">궁금한 사항이 있으시면 언제든지 문의해 주세요.<br>
                                                                빠르고 정확한 답변을 드리겠습니다.</p>
                                                                <a href="${pageContext.request.contextPath}/inquiry/write" 
                                                                   class="write-inquiry-btn">
                                                                    <i class="bi bi-plus-circle"></i>
                                                                    첫 문의 작성하기
                                                                </a>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                        </main>
                            </div>
                        </div>
                        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
                    </div>
                    
                    <%-- JavaScript --%>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        // 테이블 행 클릭 시 상세보기 이동
                        document.querySelectorAll('.inquiry-table tbody tr').forEach(row => {
                            row.addEventListener('click', function(e) {
                                // 버튼 클릭이 아닌 경우에만 상세보기 이동
                                if (!e.target.closest('.action-btn')) {
                                    const titleLink = this.querySelector('.title-link');
                                    if (titleLink) {
                                        window.location.href = titleLink.href;
                                    }
                                }
                            });
                            
                            // 호버 효과 강화
                            row.addEventListener('mouseenter', function() {
                                this.style.cursor = 'pointer';
                            });
                        });

                        // 페이지 로드 시 애니메이션
                        window.addEventListener('load', function() {
                            const table = document.querySelector('.inquiry-table');
                            if (table) {
                                table.style.opacity = '0';
                                table.style.transform = 'translateY(20px)';
                                setTimeout(() => {
                                    table.style.transition = 'all 0.5s ease';
                                    table.style.opacity = '1';
                                    table.style.transform = 'translateY(0)';
                                }, 100);
                            }
                        });
                    </script>
                </body>
                </html>