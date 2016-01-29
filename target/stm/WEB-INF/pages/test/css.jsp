<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>선수등록</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


  <script>
    $(document).ready(function(){

      $("#btn1").click(function(){
        $("#test1").text("Hello world!");

//        $("#idiv").height(500);
//        $("#idiv").width(300);

        $("#idiv").css("width","500px").css("height","200px");
      });

      $("#btn2").click(function(){
        $("div").hide();
      });

      $("#btn3").click(function(){
        $("div").show();
      });

    })

  </script>



</head>
<body>

<div id="idiv" style="border: 2px red solid">
 <p id="test1" style="background-color: red">안녕하세요</p>
</div>

<button id="btn1">적용</button>
<button id="btn2">숨겨보까?</button>
<button id="btn3">보이기?</button>

<button id="btn4">submit</button>
</body>
</html>