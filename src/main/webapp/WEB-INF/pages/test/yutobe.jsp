<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: sungbo
  Date: 2015-12-14
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>지도에 컨트롤 올리기</title>
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=fff94ed0347e4d3d9802c376b2ebc2ff&libraries=services"></script>
</head>
<body>

<div>
  <input type="text" id="search"> <button id="btn">찾기</button>
</div>

<br>

<div id="map" style="width: 500px; height: 400px"></div>
<p><em>지도를 클릭해주세요!</em></p>
<p id="result"></p>
<input id="wido" type="text"/>
<br>
<input id="yido" type="text"/>
<script>
  $(document).ready(function() {

    var infowindow = new daum.maps.InfoWindow({zIndex:1});

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
              center: new daum.maps.LatLng(37.566815253630246, 126.97899183303711), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
            };

    var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
    var mapTypeControl = new daum.maps.MapTypeControl();

    // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
    // daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

    // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
    var zoomControl = new daum.maps.ZoomControl();
    map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

//    daum.maps.event.addListener(map, 'click', function (mouseEvent) {
//
//      // 클릭한 위도, 경도 정보를 가져옵니다
//      var latlng = mouseEvent.latLng;
//
//      var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
//      message += '경도는 ' + latlng.getLng() + ' 입니다';
//
//      var resultDiv = document.getElementById('result');
//      resultDiv.innerHTML = message;
//      $('#wido').val(latlng.getLat());
//      $('#yido').val(latlng.getLng());
//    });

    // 장소 검색 객체를 생성합니다
    var ps = new daum.maps.services.Places();

    // 키워드로 장소를 검색합니다
    //ps.keywordSearch('이태원 맛집', placesSearchCB);

    function placesSearchCB (status, data, pagination) {
      if (status === daum.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new daum.maps.LatLngBounds();

        for (var i=0; i<data.places.length; i++) {
          displayMarker(data.places[i]);
          bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
        }

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
      }
    }


    function displayMarker(place) {

      // 마커를 생성하고 지도에 표시합니다
      var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(place.latitude, place.longitude)
      });

      // 마커에 클릭이벤트를 등록합니다
      daum.maps.event.addListener(marker, 'click', function(mouseEvent) {
        alert('마커클릭?');
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.title + '</div>');
        infowindow.open(map, marker);
      });
    }

    $('#btn').click(function(){
      alert('지도에서 찾아요'+$('#search').val());
      var search =$('#search').val()
      ps.keywordSearch(search, placesSearchCB);
    });

  });
</script>



</body>
</html>
