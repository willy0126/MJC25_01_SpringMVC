<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <jsp:include page="/WEB-INF/views/common/head.jsp" />
      <title>절차 및 비용 - Star's Haven, 반려동물 장례식장</title>
      <link rel="stylesheet" href="<c:url value='/resources/css/infostyle.css'/>" />
    </head>

    <body>
      <div class="page-wrapper">
        <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
        <main class="main-wrapper">
          <div class="site-container">

            <section id="hero-section" class="fade-in fade-delay-200 hero-block">
              <div class="hero-content">
                <h2 class="hero-title">마지막 안녕을 진심으로 도와드립니다</h2>
                <p class="hero-lead">
                  반려동물의 마지막 산책길이 더욱 의미 있는 시간이 될 수 있도록 최선을 다하겠습니다.
                </p>
              </div>
            </section>

            <section id="procedure" class="container my-5 mt-8 fade-in fade-delay-500">
              <h4 class="h3">절차 안내</h4>

              <!-- Progress -->
              <div class="bg-section p-4 rounded mx-auto">
                <div class="d-flex justify-content-between mb-4">
                  <c:forEach var="i" begin="1" end="8">
                    <div class="text-center flex-fill">
                      <div class="bg-primary text-white rounded-circle mx-auto mb-2"
                        style="width:44px; height:44px; line-height:44px;">${i}
                      </div>
                      <c:choose>
                        <c:when test="${i == 1}">
                          <p class="mb-0">지점 확인</p>
                        </c:when>
                        <c:when test="${i == 2}">
                          <p class="mb-0">지점 선택</p>
                        </c:when>
                        <c:when test="${i == 3}">
                          <p class="mb-0">날짜 선택</p>
                        </c:when>
                        <c:when test="${i == 4}">
                          <p class="mb-0">정보 입력</p>
                        </c:when>
                        <c:when test="${i == 5}">
                          <p class="mb-0">예약 신청</p>
                        </c:when>
                        <c:when test="${i == 6}">
                          <p class="mb-0">예약 승인</p>
                        </c:when>
                        <c:when test="${i == 7}">
                          <p class="mb-0">지점 방문</p>
                        </c:when>
                        <c:when test="${i == 8}">
                          <p class="mb-0">장례 진행</p>
                        </c:when>
                      </c:choose>
                    </div>
                  </c:forEach>
                </div>
              </div>
            </section>

            <!-- 비용 테이블 -->
            <section id="cost-common2" class="py-5 fade-in">
              <div class="site-container">
                <h4 class="h3">비용 안내</h4>

                <ul class="item-list list-unstyled">
                  <li class="item">
                    <div class="card">
                      <div class="item-icon mb-3">
                        <img src="${pageContext.request.contextPath}/resources/img/service_item01.png" alt="화장 서비스 아이콘">
                      </div>
                      <h3 class="item-title">기본 구성</h3>
                      <p class="item-desc">장례 서비스, 기본 유골함</p>
                      <p class="item-price">₩200,000</p>
                    </div>
                  </li>

                  <li class="item">
                    <div class="card">
                      <div class="item-icon mb-3">
                        <img src="${pageContext.request.contextPath}/resources/img/service_item02.png" alt="장례 의전 아이콘">
                      </div>
                      <h3 class="item-title">별의 안식 패키지</h3>
                      <p class="item-desc">장례 서비스, 인견 수의+수의보, 오동나무 관,<br>기본 유골함, 미니 꽃다발</p>
                      <p class="item-price">₩350,000</p>
                    </div>
                  </li>

                  <li class="item">
                    <div class="card">
                      <div class="item-icon mb-3">
                        <img src="${pageContext.request.contextPath}/resources/img/service_item03.png" alt="장례 의전2 아이콘">
                      </div>
                      <h3 class="item-title">별의 요람 패키지</h3>
                      <p class="item-desc">장례 서비스, 고급 면 수의+수의보, 목화솜 이불,<br>요람 관, 한지 수목함, 미니 꽃다발
                      </p>
                      <p class="item-price">₩500,000</p>
                    </div>
                  </li>

                  <li class="item">
                    <div class="card">
                      <div class="item-icon mb-3">
                        <img src="${pageContext.request.contextPath}/resources/img/service_item04.png" alt="장례 의전3 아이콘">
                      </div>
                      <h3 class="item-title">메모리얼 패키지</h3>
                      <p class="item-desc">장례 서비스, 고급 면 수의+수의보, 오동나무 관,<br>2중 기능성 유골함, 미니 꽃다발</p>
                      <p class="item-price">₩750,000</p>
                    </div>
                  </li>

                  <li class="item">
                    <div class="card">
                      <div class="item-icon mb-3">
                        <img src="${pageContext.request.contextPath}/resources/img/service_item05.png" alt="장례 의전4 아이콘">
                      </div>
                      <h3 class="item-title">프리미엄 패키지</h3>
                      <p class="item-desc">장례 서비스, 고급 린넨 투톤 수의+수의보,<br>고급 오동나무 관, 호두나무 유골함, 미니 꽃다발,<br>헤이븐
                        어메니티</p>
                      <p class="item-price">₩950,000</p>
                    </div>
                  </li>

                  <li class="item">
                    <div class="card">
                      <div class="item-icon mb-3">
                        <img src="${pageContext.request.contextPath}/resources/img/service_item06.png" alt="장례 의전5 아이콘">
                      </div>
                      <h3 class="item-title">All-in-one VIP 패키지</h3>
                      <p class="item-desc">장례 서비스, 프리미엄 린넨 투톤 수의+수의보,<br>고급 오동나무 관, 호두나무 스톤함, 미니 꽃다발,<br>헤이븐
                        어메니티(+ 맞춤 주문 제작 가능)</p>
                      <p class="item-price">₩1,150,000</p>
                    </div>
                  </li>
                </ul>
              </div>
            </section>

            <section id="cost-notice" class="py-4 fade-in">
              <div class="site-container">
                <div class="alert border-0 rounded-3 p-4">
                  <h4 class="alert-heading">유의사항</h4>
                  <ul class="mb-0">
                    <li>기준 무게를 초과하는 경우 추가 요금이 부과됩니다. (10,000원/kg)</li>
                    <li>패키지의 장례용품은 반려동물의 크기에 따라 사이즈 변경이 필요할 수 있으며, 이때 추가 요금이 발생할 수 있습니다.</li>
                    <li>각 지점 별 All-in-one VIP 패키지는 상황에 따라 구성이 달라질 수 있습니다.</li>
                    <li><b>해당 내용은 프로젝트의 완성도를 위한 내용이므로, 실제로 서비스 하지 않는 내용입니다.</b></li>
                  </ul>
                </div>
              </div>
            </section>
          </div>
        </main>

        <jsp:include page="/WEB-INF/views/common/footer.jsp" />

      </div>

      <jsp:include page="/WEB-INF/views/common/script.jsp" />
    </body>

    </html>