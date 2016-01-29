<%--
부트스트랩 왼쪽 수직 목록 만드는 예제
--%>
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

  <style>
    body{
      padding-top: 60px;
    }

  </style>

</head>

<body>

<div class="navbar navbar-inverse navbar-fixed-top">   <%--navbar-fixed-top 페이지 상단에 고정 시킨다--%>
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Bootstrap</a>
    </div>
  </div>
</div>

<div class="container">
    <div class="row">
      <div class="col-md-3">
        <div class="list-group">

          <div class="panel-heading">
            <h3 class="panel-title">
              <i class="glyphicon glyphicon-leaf"></i>
              <span>Panel Title</span>
            </h3>
          </div>

          <div class="list-group-item"><a href="#">HTML5</a></div>
          <div class="list-group-item"><a href="#">CSS3</a></div>
          <div class="list-group-item"><a href="#">EXMAScript5</a></div>
        </div>

        <div class="list-group">

          <div class="panel-heading">
            <h3 class="panel-title">
              <i class="glyphicon glyphicon-eject"></i>
              <span>Panel Title</span>
            </h3>
          </div>

          <div class="list-group-item"><a href="#">Jquery</a></div>
          <div class="list-group-item"><a href="#">HTML5 API</a></div>
        </div>


        <div class="list-group">
          <div class="list-group-item"><a href="#">About</a></div>
          <div class="list-group-item"><a href="#">Help</a></div>
        </div>
      </div>
      <div class="col-md-9">
        <h1>자유론</h1>
        <p> 인간은 타인의 권리와 피해를 주지 않는 범위에서 자유를 누릴 권리가 있다.</p>
        <p> 관습에 얽매인 인간들</p>
        <p> 관습에 얽매인 인간들</p>
        <p> 관습에 얽매인 인간들</p>
        <p> 관습에 얽매인 인간들</p>
        <p> 관습에 얽매인 인간들</p>
        <p> 관습에 얽매인 인간들</p>
        </div>
    </div>
  </div>
</body>

</html>
