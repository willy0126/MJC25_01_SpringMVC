<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>지점 위치 - Star's Haven, 반려동물 장례식장</title>

    <!-- location 페이지 전용 CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/locationstyle.css'/>" />

    <!-- 네이버 지도 API 스크립트 -->
    <script
      type="text/javascript"
      src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=lvmvm45lpn">
    </script>
</head>

<body>
  <div class="page-wrapper">
    <!-- (1) Navbar -->
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    <main class="main-wrapper">
      <div class="site-container">
        <div class="map-title fade-in">지점 안내</div>
        <div class="map-container fade-in">
          <div id="map"></div>
        </div>
        <div class="map-note fade-in">
            <strong>유의 사항</strong>
            <ul>
              <li>운영 시간: 평일 09:00 ~ 18:00</li>
              <li>현장 주차 공간이 협소하오니, 가능하시면 대중교통을 이용해 주세요.</li>
              <li><b>해당 위치는 프로젝트의 완성도를 위해 임의로 지정한 위치이므로, 실제 존재하지 않는 지점 및 장소입니다.</b></li>
            </ul>
        </div>
      </div>
  
      <!-- (3) 지도 초기화 + 마커 + 컨트롤 -->
      <script>
        // 지도 생성
        var map = new naver.maps.Map('map', {
          center: new naver.maps.LatLng(37.5846502, 126.9254007),
          zoom: 13,
          zoomControl: true,
          zoomControlOptions: { position: naver.maps.Position.RIGHT_CENTER },
          mapTypeControl: true,
          mapTypeControlOptions: { position: naver.maps.Position.TOPRIGHT },
          scaleControl: true,
          scaleControlOptions: { position: naver.maps.Position.BOTTOMLEFT }
        });
  
        // 찍을 지점 정보 배열
        var locations = [
          {
            title: 'Star\'s Haven 본점',
            lat: 37.5846502, lng: 126.9254007,
            content: '<strong>Star\'s Haven 본점</strong><br>서울특별시 서대문구 가좌로 134'
          },
          {
            title: '홍대입구점',
            lat: 37.5579912, lng: 126.9272353,
            content: '<strong>Star\'s Haven 홍대입구점</strong><br>서울특별시 마포구 동교동 172-14'
          },
          {
            title: '서대문점',
            lat: 37.5659098, lng: 126.9647629,
            content: '<strong>Star\'s Haven 서대문점</strong><br>서울특별시 서대문구 경기대로 82'
          }
        ];
  
        // 마커와 인포윈도우 생성
        <!-- (3) 마커와 인포윈도우 생성 -->
        var markers = [], infoWindows = [];
        locations.forEach(function(loc, idx) {
          var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(loc.lat, loc.lng),
            map: map,
            title: loc.title,
            icon: {
              content: '<div class="heart-paw-marker"></div>',
              anchor: new naver.maps.Point(16, 32)
            }
          });
          markers.push(marker);

          var infoWindow = new naver.maps.InfoWindow({
            content: '<div style="padding:8px 12px; font-size:14px; line-height:1.4;">'
              + loc.content + '</div>'
          });
          infoWindows.push(infoWindow);

          naver.maps.Event.addListener(marker, 'click', function() {
            infoWindows.forEach(function(iw) { iw.close(); });
            infoWindow.open(map, marker);
            map.panTo(marker.getPosition());
          });
        });

        // 페이지 로드 시 첫 번째 InfoWindow 자동 오픈
        infoWindows[0].open(map, markers[0]);
      </script>
    </main>

    <!-- (4) Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <!-- (5) 공통 스크립트 -->
    <jsp:include page="/WEB-INF/views/common/script.jsp" />
  </div>
</body>
</html>