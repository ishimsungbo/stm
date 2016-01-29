<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<!DOCTYPE html>

<html lang="ko">
<head>
  <title>ImgTest01</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
  <script src="/resources/modernizr-1.6.min.js"></script>
</head>

<style>
  canvas{
    border: 1px solid red;
  }

</style>

<script type="text/javascript">
  window.addEventListener('load', eventWindowLoaded, false);
  function eventWindowLoaded() {
    canvasApp();
  }

  function canvasSupport () {
    return Modernizr.canvas;
  }


  function canvasApp(){


    if (!canvasSupport()) {
      return;
    }else{
      var theCanvas = document.getElementById('canvas');
      var context = theCanvas.getContext('2d');
    }

    var spaceShip=new Image();
    spaceShip.src="/resources/ship1.png";
    spaceShip.addEventListener('load', eventShipLoaded , false);

    function eventShipLoaded() {
      drawScreen();
    }


    function drawScreen() {

      context.drawImage(spaceShip, 0, 0);
      context.drawImage(spaceShip, 50, 50);

    }

  }


</script>

<body>
<canvas id="canvas" width="500" height="500">
  Your browser does not support the HTML 5 Canvas.
</canvas>
</body>
</html>
