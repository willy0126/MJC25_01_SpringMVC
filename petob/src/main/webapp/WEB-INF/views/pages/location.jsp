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
      <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=lvmvm45lpn">
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
            // URL 파라미터 가져오는 함수
            function getQueryParam(param) {
              const urlParams = new URLSearchParams(window.location.search);
              return urlParams.get(param);
            }

            // 찍을 지점 정보 배열 (각 지점별로 고유 id 추가)
            var locations = [
              {
                id: 'main', // 본점 식별자
                title: 'Star\'s Haven 본점',
                lat: 37.5846502, lng: 126.9254007,
                content: '<strong>Star\'s Haven 본점</strong><br>서울특별시 서대문구 가좌로 134'
              },
              {
                id: 'hongdae', // 홍대입구점 식별자
                title: '홍대입구점',
                lat: 37.5579912, lng: 126.9272353,
                content: '<strong>Star\'s Haven 홍대입구점</strong><br>서울특별시 마포구 동교동 172-14'
              },
              {
                id: 'seodaemun', // 서대문점 식별자
                title: '서대문점',
                lat: 37.5659098, lng: 126.9647629,
                content: '<strong>Star\'s Haven 서대문점</strong><br>서울특별시 서대문구 경기대로 82'
              }
            ];

            // URL에서 'branch' 파라미터 값 읽기
            const requestedBranchId = getQueryParam('branch');
            let targetLocationIndex = 0; // 기본값은 본점(첫 번째 지점)

            // 요청된 branch id가 있다면 해당 지점의 인덱스 찾기
            if (requestedBranchId) {
              const foundIndex = locations.findIndex(loc => loc.id === requestedBranchId);
              if (foundIndex !== -1) {
                targetLocationIndex = foundIndex;
              }
            }

            const targetLocation = locations[targetLocationIndex];

            // 지도 생성 (중심 좌표와 줌 레벨은 선택된 지점에 따라 설정)
            var map = new naver.maps.Map('map', {
              center: new naver.maps.LatLng(targetLocation.lat, targetLocation.lng),
              zoom: 13,
              zoomControl: true,
              zoomControlOptions: { position: naver.maps.Position.RIGHT_CENTER },
              mapTypeControl: true,
              mapTypeControlOptions: { position: naver.maps.Position.TOPRIGHT },
              scaleControl: true,
              scaleControlOptions: { position: naver.maps.Position.BOTTOMLEFT }
            });

            var markers = [], infoWindows = [];
            locations.forEach(function (loc, idx) {
              var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(loc.lat, loc.lng),
                map: map,
                title: loc.title,
                icon: {
                  content: '<div class="heart-paw-marker"></div>',
                  anchor: new naver.maps.Point(16, 32) // 아이콘 크기 및 위치에 맞게 조절
                }
              });
              markers.push(marker);

              var infoWindow = new naver.maps.InfoWindow({
                content: '<div style="padding:8px 12px; font-size:14px; line-height:1.4;">'
                  + loc.content + '</div>'
              });
              infoWindows.push(infoWindow);

              naver.maps.Event.addListener(marker, 'click', function () {
                infoWindows.forEach(function (iw) { iw.close(); }); // 다른 정보창 닫기
                infoWindow.open(map, marker);
                map.panTo(marker.getPosition()); // 클릭한 마커로 부드럽게 이동
              });
            });

            // 페이지 로드 시 선택된 지점의 InfoWindow 자동 오픈
            if (markers[targetLocationIndex] && infoWindows[targetLocationIndex]) {
              infoWindows[targetLocationIndex].open(map, markers[targetLocationIndex]);
            }
          </script>
        </main>

        <!-- (4) Footer -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        <!-- (5) 공통 스크립트 -->
        <jsp:include page="/WEB-INF/views/common/script.jsp" />
      </div>
    </body>

    </html>