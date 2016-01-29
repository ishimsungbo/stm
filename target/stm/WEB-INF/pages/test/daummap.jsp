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
    var container = document.getElementById('map'),
            options = {
              center: new daum.maps.LatLng(35.450701, 126.570667),
              level: 3
            };

    var map = new daum.maps.Map(container, options);

    var mapTypeControl = new daum.maps.MapTypeControl();
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

    var zoomControl = new daum.maps.ZoomControl();
    map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

  });
</script>



</body>
</html>
