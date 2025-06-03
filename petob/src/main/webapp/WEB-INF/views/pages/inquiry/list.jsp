<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>문의 작성 - Star's Haven, 반려동물 장례식장</title>
    
    <!-- 문의 게시판 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/inquiry/inquirystyle.css'/>" />
  
</head>

<body>
    <div class="page-wrapper">
        <!-- Navbar -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        
        <main class="main-wrapper">
            <!-- 헤더 -->
            <div class="inquiry-header">
                <div class="container">
                    <h1><i class="fas fa-question-circle me-3"></i>문의 게시판</h1>
                    <p>궁금한 사항이나 문의사항을 남겨주세요.</p>
                </div>
            </div>

            <!-- 콘텐츠 -->
            <div class="inquiry-content">
              <!-- 🔍 검색 영역 -->
        <div class="search-section">
            <h5 class="search-title">
                <i class="fas fa-filter" name="search"></i>
                검색 조건
            </h5>
            
            <form id="searchForm" class="search-form" method="GET" action="<c:url value='/inquiry/list'/>">
                <!-- 키워드 검색 -->
                <div class="search-group">
                    <label for="keyword" class="search-label">키워드</label>
                    <input type="text" 
                           id="keyword" 
                           name="search" 
                           class="search-input" 
                           placeholder="제목이나 내용을 검색하세요"
                           value="${search}">
                </div>
                
                <!-- 카테고리 필터 -->
                <div class="search-group">
                    <label for="category" class="search-label">카테고리</label>
                    <select id="category" name="category" class="search-select">
                        <option value="">전체 카테고리</option>
                        <option value="SERVICE" ${param.category eq 'SERVICE' ? 'selected' : ''}>서비스 문의</option>
                        <option value="RESERVATION" ${param.category eq 'RESERVATION' ? 'selected' : ''}>예약 문의</option>
                        <option value="PRICE" ${param.category eq 'PRICE' ? 'selected' : ''}>가격 문의</option>
                        <option value="LOCATION" ${param.category eq 'LOCATION' ? 'selected' : ''}>지점 문의</option>
                        <option value="COMPLAINT" ${param.category eq 'COMPLAINT' ? 'selected' : ''}>불만 접수</option>
                        <option value="SUGGESTION" ${param.category eq 'SUGGESTION' ? 'selected' : ''}>개선 제안</option>
                        <option value="ETC" ${param.category eq 'ETC' ? 'selected' : ''}>기타</option>
                    </select>
                </div>
                
                <!-- 검색 버튼들 -->
                <div class="search-buttons">
                    <button type="submit" class="btn-search">
                        <i class="fas fa-search"></i>
                        검색하기
                    </button>
                    <button type="button" class="btn-reset" onclick="resetForm()">
                        <i class="fas fa-undo"></i>
                        초기화
                    </button>
                </div>
            </form>
        </div>
         
        <!-- 🏷️ 검색 결과 정보 -->
        <c:if test="${not empty param.keyword or not empty param.category}">
            <div class="search-result-info">
                <div class="result-count">
                    <i class="fas fa-list-ul"></i>
                    검색 결과: <strong>${totalCount}개</strong>의 문의사항
                </div>
                <div class="search-keywords">
                    <c:if test="${not empty param.keyword}">
                        <span class="keyword-tag">
                            <i class="fas fa-search"></i> ${param.keyword}
                        </span>
                    </c:if>
                    <c:if test="${not empty param.category}">
                        <span class="keyword-tag">
                            <i class="fas fa-tag"></i> 
                            <c:choose>
                                <c:when test="${param.category eq 'SERVICE'}">서비스 문의</c:when>
                                <c:when test="${param.category eq 'RESERVATION'}">예약 문의</c:when>
                                <c:when test="${param.category eq 'PRICE'}">가격 문의</c:when>
                                <c:when test="${param.category eq 'LOCATION'}">지점 문의</c:when>
                                <c:when test="${param.category eq 'COMPLAINT'}">불만 접수</c:when>
                                <c:when test="${param.category eq 'SUGGESTION'}">개선 제안</c:when>
                                <c:when test="${param.category eq 'ETC'}">기타</c:when>
                            </c:choose>
                        </span>
                    </c:if>
                </div>
            </div>
        </c:if>

        <!-- 📝 문의하기 버튼 (하나만) -->
        <c:choose>
            <c:when test="${not empty sessionScope.userId}">
                <div class="d-flex justify-content-end mb-3">
                    <a href="<c:url value='/inquiry/write'/>" class="btn-write">
                        <i class="fas fa-pen me-2"></i>문의하기
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="login-info" style="margin-bottom: 1.5rem;">
                    <i class="fas fa-info-circle me-2"></i>
                    문의 작성을 위해서는 <a href="<c:url value='/login'/>">로그인</a>이 필요합니다.
                    <button type="button" class="btn-write ms-3" onclick="showLoginAlert()">
                        <i class="fas fa-pen me-2"></i>문의하기
                    </button>
                </div>
            </c:otherwise>
        </c:choose>


                <!-- 문의 테이블 -->
                <div class="table-container">
                    <div class="table-header">
                        <h5>총 <span style="color: #2b6cb0;">${totalCount != null ? totalCount : 0}</span>건의 문의</h5>
                    </div>

                    <c:choose>
                        <c:when test="${empty inquiryList}">
                            <div class="empty-state">
                                <i class="fas fa-inbox"></i>
                                <h5>등록된 문의가 없습니다.</h5>
                                <p>첫 번째 문의를 작성해보세요!</p>
                                <c:if test="${not empty sessionScope.userId}">
                                    <a href="<c:url value='/inquiry/write'/>" class="btn-write">
                                        <i class="fas fa-pen me-2"></i>문의하기
                                    </a>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th style="width: 8%;">번호</th>
                                            <th style="width: 50%;">제목</th>
                                            <th style="width: 15%;">작성자</th>
                                            <th style="width: 20%;">처리상태</th>
                                            <th style="width: 15%;">작성일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
                                            <tr style="cursor: pointer;" data-inquiry-id="${inquiry.inquiryId}">
                                                <!-- 🔢 번호 (전체 게시물 수에서 역순으로 계산) -->
                                                <td class="text-center number-cell">
                                                    <c:set var="currentPageNumber" value="${totalCount - ((currentPage - 1) * pageSize) - status.index}" />
                                                    <span class="post-number">${currentPageNumber}</span>
                                                </td>
                                                
                                                <!-- 📝 제목 -->
                                                <td>
                                                    <a href="javascript:void(0)" class="inquiry-title" data-inquiry-id="${inquiry.inquiryId}">
                                                        <!-- 비밀글 아이콘 -->
                                                        <c:if test="${inquiry.isSecret}">
                                                            <i class="fas fa-lock text-warning me-1"></i>
                                                        </c:if>
                                                        
                                                        ${inquiry.title}
                                                        
                                                        <!-- 오늘 작성글 NEW 아이콘 -->
                                                        <c:if test="${inquiry.isToday}">
                                                            <span class="badge bg-danger ms-2">NEW</span>
                                                        </c:if>
                                                    </a>
                                                </td>
                                                
                                                <!-- 👤 작성자 -->
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${not empty inquiry.username}">
                                                            <span class="username">${inquiry.username}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="username anonymous">익명</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                
                                                <!-- 📋 처리상태 -->
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${inquiry.status == 'WAITING'}">
                                                            <span class="status-badge status-waiting">답변대기</span>
                                                        </c:when>
                                                        <c:when test="${inquiry.status == 'PROCESSING'}">
                                                            <span class="status-badge status-processing">처리중</span>
                                                        </c:when>
                                                        <c:when test="${inquiry.status == 'COMPLETED'}">
                                                            <span class="status-badge status-completed">답변완료</span>
                                                        </c:when>
                                                        <c:when test="${inquiry.status == 'CLOSED'}">
                                                            <span class="status-badge status-closed">종료</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge status-waiting">답변대기</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                
                                                <!-- 📅 작성일 -->
                                                <td class="text-center">
                                                     <c:choose>
                                                     <c:when test="${not empty inquiry.createdDateFormatted}">
                                                     <span class="date-unified">
                                                          ${inquiry.createdDateFormatted}
                                                     </span>
                                                     </c:when>
                                                      <c:otherwise>
                                                  <span class="date-unified">-</span>
                                                   </c:otherwise>
                                                  </c:choose>

                                                </td>
                                                
                                        
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- 📄 페이징 -->
                            <c:if test="${totalPages > 1}">
                                <div class="pagination-container">
                                    <nav aria-label="문의 목록 페이지 네비게이션">
                                        <ul class="pagination">
                                            <!-- 첫 페이지로 -->
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="<c:url value='/inquiry/list?page=1'/>" aria-label="첫 페이지">
                                                        <i class="fas fa-angle-double-left"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                            
                                            <!-- 이전 그룹 -->
                                            <c:if test="${pagination.hasPrevGroup}">
                                                <li class="page-item">
                                                    <a class="page-link" href="<c:url value='/inquiry/list?page=${pagination.startPage - 1}'/>" aria-label="이전">
                                                        <i class="fas fa-angle-left"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                            
                                            <!-- 페이지 번호들 -->
                                            <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
                                                <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="<c:url value='/inquiry/list?page=${pageNum}'/>">${pageNum}</a>
                                                </li>
                                            </c:forEach>
                                            
                                            <!-- 다음 그룹 -->
                                            <c:if test="${pagination.hasNextGroup}">
                                                <li class="page-item">
                                                    <a class="page-link" href="<c:url value='/inquiry/list?page=${pagination.endPage + 1}'/>" aria-label="다음">
                                                        <i class="fas fa-angle-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                            
                                            <!-- 마지막 페이지로 -->
                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="<c:url value='/inquiry/list?page=${totalPages}'/>" aria-label="마지막 페이지">
                                                        <i class="fas fa-angle-double-right"></i>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                    
                                    <!-- 페이지 정보 -->
                                    <div class="page-info">
                                        <span class="current-page">${currentPage}</span> / 
                                        <span class="total-pages">${totalPages}</span> 페이지
                                        <span class="total-count">(총 ${totalCount}건)</span>
                                    </div>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
        <!-- 공통 스크립트 -->
        <jsp:include page="/WEB-INF/views/common/script.jsp" />
        
        <!-- Footer -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>

<script>

            // ⚠️ 로그인 안내 알림
        function showLoginAlert() {
            if (confirm('문의는 로그인 후 가능합니다.\n로그인 페이지로 이동하시겠습니까?')) {
                window.location.href = '<c:url value="/login"/>';
            }
        }
// JavaScript로 상세페이지 이동
function goToDetail(inquiryId) {
    if (inquiryId) {
        window.location.href = '<c:url value="/inquiry/view/"/>' + inquiryId;
    }
}

// 행 클릭으로도 이동 가능
document.querySelectorAll('tbody tr').forEach(function(row) {
    row.addEventListener('click', function(e) {
        if (e.target.tagName !== 'A' && e.target.tagName !== 'I' && e.target.tagName !== 'SPAN') {
            const inquiryId = this.getAttribute('data-inquiry-id');
            if (inquiryId) {
                goToDetail(inquiryId);
            }
        }
    });
});
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.table-container, .button-container, .login-info, .user-info-section, .pagination-container');
            elements.forEach((el, index) => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    el.style.transition = 'all 0.5s ease';
                    el.style.opacity = '1';
                    el.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });


// 폼 초기화 함수
function resetForm() {
    document.getElementById('keyword').value = '';
    document.getElementById('category').value = '';
    window.location.href = '<c:url value="/inquiry/list"/>';
}

// 엔터키로 검색
document.addEventListener('DOMContentLoaded', function() {
    const keywordInput = document.getElementById('keyword');
    if (keywordInput) {
        keywordInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                document.getElementById('searchForm').submit();
            }
        });
    }
});
</script>
</body>
</html>

