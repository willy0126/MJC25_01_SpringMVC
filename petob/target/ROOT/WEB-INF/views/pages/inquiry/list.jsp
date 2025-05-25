<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>문의 게시판 - Star's Haven, 반려동물 장례식장</title>
    
    <!-- 문의 게시판 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/inquirystyle.css'/>" />
    
    <!-- 빈 상태 인라인 스타일 -->
    <style>
        .empty-state-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            margin: 40px 0;
            padding: 80px 20px;
            text-align: center;
        }
        
        .empty-state-content {
            max-width: 500px;
            margin: 0 auto;
        }
        
        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 30px;
            opacity: 0.7;
        }
        
        .empty-state-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .empty-state-message {
            color: #666;
            margin-bottom: 40px;
            font-size: 1rem;
            line-height: 1.5;
        }
        
        .empty-state-buttons {
            margin-bottom: 30px;
        }
        
        .empty-btn-primary {
            background: #4285f4;
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(66, 133, 244, 0.3);
        }
        
        .empty-btn-primary:hover {
            background: #3367d6;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(66, 133, 244, 0.4);
        }
        
        .empty-state-nav {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .empty-btn-secondary {
            background: transparent;
            color: #4285f4;
            border: 2px solid #4285f4;
            padding: 10px 20px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .empty-btn-secondary:hover {
            background: #4285f4;
            color: white;
            text-decoration: none;
            transform: translateY(-1px);
        }
        
        @media (max-width: 768px) {
            .empty-state-container {
                padding: 60px 15px;
                margin: 20px 0;
            }
            
            .empty-state-icon {
                font-size: 3rem;
            }
            
            .empty-state-title {
                font-size: 1.3rem;
            }
            
            .empty-state-nav {
                flex-direction: column;
                align-items: center;
            }
            
            .empty-btn-secondary {
                width: 200px;
                text-align: center;
            }
        }
    </style>
</head>

<body>
    <div class="page-wrapper">
        <!-- Navbar -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <div class="inquiry-container">
                <!-- 헤더 -->
                <div class="inquiry-header">
                    <h1 class="inquiry-title">문의 게시판</h1>
                    <p class="inquiry-subtitle">궁금한 사항이나 요청사항을 남겨주시면 성심껏 답변드리겠습니다.</p>
                </div>
                
                <!-- 검색 및 필터 영역 -->
                <div class="inquiry-search">
                    <form action="<c:url value='/inquiry'/>" method="get" class="search-form">
                        <div class="search-controls">
                            <select name="category" class="search-select">
                                <option value="">전체 카테고리</option>
                                <option value="SERVICE" ${param.category == 'SERVICE' ? 'selected' : ''}>서비스 문의</option>
                                <option value="RESERVATION" ${param.category == 'RESERVATION' ? 'selected' : ''}>예약 문의</option>
                                <option value="PRICE" ${param.category == 'PRICE' ? 'selected' : ''}>가격 문의</option>
                                <option value="LOCATION" ${param.category == 'LOCATION' ? 'selected' : ''}>지점 문의</option>
                                <option value="COMPLAINT" ${param.category == 'COMPLAINT' ? 'selected' : ''}>불만 접수</option>
                                <option value="SUGGESTION" ${param.category == 'SUGGESTION' ? 'selected' : ''}>개선 제안</option>
                                <option value="ETC" ${param.category == 'ETC' ? 'selected' : ''}>기타</option>
                            </select>
                            
                            <select name="searchType" class="search-select">
                                <option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
                                <option value="content" ${param.searchType == 'content' ? 'selected' : ''}>내용</option>
                                <option value="writer" ${param.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                                <option value="all" ${param.searchType == 'all' ? 'selected' : ''}>전체</option>
                            </select>
                            
                            <input type="text" name="keyword" value="${param.keyword}" 
                                   placeholder="검색어를 입력하세요" class="search-input">
                            
                            <button type="submit" class="btn btn-search">검색</button>
                            <a href="<c:url value='/inquiry'/>" class="btn btn-reset">초기화</a>
                        </div>
                    </form>
                </div>
                
                <!-- 액션 바 -->
                <div class="inquiry-actions">
                    <div class="inquiry-stats">
                        <span class="total-count">총 <strong>${totalCount}</strong>건</span>
                        <c:if test="${not empty param.keyword}">
                            <span class="search-result">| 검색결과 <strong>${searchResultCount}</strong>건</span>
                        </c:if>
                    </div>
                    <div class="action-buttons">
                        <button onclick="checkLoginAndWrite()" class="btn btn-write">
                            📝 문의 작성
                        </button>
                    </div>
                </div>
                
                <!-- 문의 목록 테이블 -->
                <c:choose>
                    <c:when test="${empty inquiryList and empty noticeList}">
                        <!-- 완전히 빈 상태 -->
                        <div class="empty-state-container">
                            <div class="empty-state-content">
                                <div class="empty-state-icon">
                                    📧
                                </div>
                                <h3 class="empty-state-title">등록된 문의가 없습니다.</h3>
                                <p class="empty-state-message">궁금한 것이 있으시면 언제든지 문의해 주세요.</p>
                                
                                <div class="empty-state-buttons">
                                    <button onclick="checkLoginAndWrite()" class="empty-btn-primary">
                                        ✏️ 문의 작성
                                    </button>
                                </div>
                                
                                <div class="empty-state-nav">
                                    <a href="javascript:checkLoginAndWrite()" class="empty-btn-secondary">
                                        📝 문의 작성
                                    </a>
                                    <a href="<c:url value='/'/>" class="empty-btn-secondary">
                                        🏠 메인으로
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 기존 테이블 -->
                        <div class="board-container">
                            <table class="board-table">
                                <thead>
                                    <tr>
                                        <th class="col-num">번호</th>
                                        <th class="col-category">분류</th>
                                        <th class="col-title">제목</th>
                                        <th class="col-writer">작성자</th>
                                        <th class="col-date">작성일</th>
                                        <th class="col-status">상태</th>
                                        <th class="col-views">조회</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- 공지사항 (고정) -->
                                    <c:forEach var="notice" items="${noticeList}">
                                        <tr class="notice-row">
                                            <td><span class="notice-badge">공지</span></td>
                                            <td>-</td>
                                            <td class="title-cell">
                                                <a href="<c:url value='/inquiry/notice/${notice.id}'/>" class="title-link">
                                                    <i class="fas fa-bullhorn notice-icon"></i>
                                                    ${notice.title}
                                                </a>
                                            </td>
                                            <td>관리자</td>
                                            <td><fmt:formatDate value="${notice.createdDate}" pattern="MM-dd"/></td>
                                            <td>-</td>
                                            <td>${notice.viewCount}</td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <!-- 일반 문의 -->
                                    <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
                                        <tr class="inquiry-row">
                                            <td>${totalCount - (currentPage - 1) * pageSize - status.index}</td>
                                            <td>
                                                <span class="category-badge category-${inquiry.category}">
                                                    <c:choose>
                                                        <c:when test="${inquiry.category == 'SERVICE'}">서비스</c:when>
                                                        <c:when test="${inquiry.category == 'RESERVATION'}">예약</c:when>
                                                        <c:when test="${inquiry.category == 'PRICE'}">가격</c:when>
                                                        <c:when test="${inquiry.category == 'LOCATION'}">지점</c:when>
                                                        <c:when test="${inquiry.category == 'COMPLAINT'}">불만</c:when>
                                                        <c:when test="${inquiry.category == 'SUGGESTION'}">제안</c:when>
                                                        <c:otherwise>기타</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="title-cell">
                                                <a href="<c:url value='/inquiry/view/${inquiry.id}'/>" class="title-link">
                                                    <c:if test="${inquiry.isPrivate}">
                                                        <i class="fas fa-lock private-icon"></i>
                                                    </c:if>
                                                    ${inquiry.title}
                                                    <c:if test="${inquiry.isHot}">
                                                        <span class="hot-badge">HOT</span>
                                                    </c:if>
                                                    <c:if test="${inquiry.replyCount > 0}">
                                                        <span class="reply-count">[${inquiry.replyCount}]</span>
                                                    </c:if>
                                                </a>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${inquiry.isPrivate and sessionScope.userId != inquiry.writerId and sessionScope.role != 'ADMIN'}">
                                                        <span class="private-writer">비공개</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="masked-name">
                                                            <c:choose>
                                                                <c:when test="${fn:length(inquiry.writer) == 2}">
                                                                    ${fn:substring(inquiry.writer, 0, 1)}*
                                                                </c:when>
                                                                <c:when test="${fn:length(inquiry.writer) == 3}">
                                                                    ${fn:substring(inquiry.writer, 0, 1)}**
                                                                </c:when>
                                                                <c:when test="${fn:length(inquiry.writer) >= 4}">
                                                                    ${fn:substring(inquiry.writer, 0, 1)}${fn:substring(inquiry.writer, 1, 2)}**
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${inquiry.writer}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${inquiry.isToday}">
                                                        <fmt:formatDate value="${inquiry.createdDate}" pattern="HH:mm"/>
                                                    </c:when>
                                                    <c:when test="${inquiry.isThisYear}">
                                                        <fmt:formatDate value="${inquiry.createdDate}" pattern="MM-dd"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatDate value="${inquiry.createdDate}" pattern="yy-MM-dd"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${inquiry.status == 'COMPLETED'}">
                                                        <span class="status-badge status-completed">
                                                            <i class="fas fa-check-circle"></i> 완료
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${inquiry.status == 'PROCESSING'}">
                                                        <span class="status-badge status-processing">
                                                            <i class="fas fa-clock"></i> 처리중
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-waiting">
                                                            <i class="fas fa-hourglass-half"></i> 대기
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${inquiry.viewCount}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <!-- 페이지네이션 -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination-container">
                        <nav class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="<c:url value='/inquiry?page=1${searchParams}'/>" class="page-link first">
                                    <i class="fas fa-angle-double-left"></i>
                                </a>
                                <a href="<c:url value='/inquiry?page=${currentPage - 1}${searchParams}'/>" class="page-link prev">
                                    <i class="fas fa-angle-left"></i>
                                </a>
                            </c:if>
                            
                            <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                                <c:choose>
                                    <c:when test="${pageNum == currentPage}">
                                        <span class="page-link current">${pageNum}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<c:url value='/inquiry?page=${pageNum}${searchParams}'/>" class="page-link">${pageNum}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <a href="<c:url value='/inquiry?page=${currentPage + 1}${searchParams}'/>" class="page-link next">
                                    <i class="fas fa-angle-right"></i>
                                </a>
                                <a href="<c:url value='/inquiry?page=${totalPages}${searchParams}'/>" class="page-link last">
                                    <i class="fas fa-angle-double-right"></i>
                                </a>
                            </c:if>
                        </nav>
                    </div>
                </c:if>
                
                <!-- 하단 정보 -->
                <div class="board-info">
                    <div class="board-guide">
                        <h4><i class="fas fa-info-circle"></i> 문의 게시판 이용안내</h4>
                        <ul>
                            <li>문의사항은 로그인 후 작성 가능합니다.</li>
                            <li>개인정보가 포함된 문의는 비밀글로 작성해 주세요.</li>
                            <li>답변은 영업일 기준 1-2일 내에 등록됩니다.</li>
                            <li>욕설, 비방, 광고성 글은 관리자에 의해 삭제될 수 있습니다.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </main>
        
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        
        <!-- 공통 스크립트 -->
        <jsp:include page="/WEB-INF/views/common/script.jsp" />
    </div>
    
    <script>
        // 로그인 상태 확인 후 문의 작성 페이지로 이동
        function checkLoginAndWrite() {
            <c:choose>
                <c:when test="${empty sessionScope.userId}">
                    alert('로그인 후 이용 가능합니다.');
                    location.href = '<c:url value="/login"/>';
                </c:when>
                <c:otherwise>
                    location.href = '<c:url value="/inquiry/write"/>';
                </c:otherwise>
            </c:choose>
        }
        
        // 검색 폼 엔터키 처리
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.querySelector('.search-input');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.closest('form').submit();
                    }
                });
            }
            
            // 검색어 하이라이트
            const keyword = '${param.keyword}';
            if (keyword) {
                highlightKeyword(keyword);
            }
        });
        
        // 검색어 하이라이트 함수
        function highlightKeyword(keyword) {
            const titleLinks = document.querySelectorAll('.title-link');
            titleLinks.forEach(function(link) {
                const text = link.textContent;
                if (text.includes(keyword)) {
                    const highlightedText = text.replace(
                        new RegExp(keyword, 'gi'), 
                        '<mark>$&</mark>'
                    );
                    link.innerHTML = highlightedText;
                }
            });
        }
        
        // 테이블 행 클릭 이벤트
        document.querySelectorAll('.inquiry-row').forEach(function(row) {
            row.addEventListener('click', function(e) {
                if (e.target.tagName !== 'A') {
                    const link = this.querySelector('.title-link');
                    if (link) {
                        window.location.href = link.href;
                    }
                }
            });
        });
    </script>
</body>
</html>

