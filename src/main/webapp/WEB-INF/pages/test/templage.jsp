<%@ page import="javax.xml.ws.spi.http.HttpContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Html Template(그리드 레이아웃 960px)</title>

    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
    <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
    <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
    <script src="/resources/jui-master/dist/jui.min.js"></script>

  <style>


    *{
      font-family:Arial, Verdana, sans-serif;
      color: #665544;
      text-align: center;
    }

    body{
      width: 960px;
      margin: 0 auto;
    }

    #nav, #feature, .article, #footer{
      background-color: #efefef;
      margin-top: 20px;
      padding: 10px 0px 5px 0px;
      border: 1px solid;
    }
    #feature, .article{
      height: 100px;
    }


    li{
      display: inline;
      padding: 5px;
    }

  </style>

</head>

<body>

<div class="container clearfix">
  <div id="header" class="grid_12">
    <h1>로고</h1>
    <div id="nav">
      <ul>
        <li>홈</li>
        <li>상품</li>
        <li>서비스</li>
        <li>소개</li>
        <li>연락처</li>
      </ul>
    </div>
  </div>

  <div id="feature" class="grid_12">
    <p>960px 고정형 레이아웃 페이지 디자인</p>
  </div>

  <div class="article col-sm-4"><p>첫번째열</p></div>
  <div class="article col-sm-4"><p>두번째열</p></div>
  <div class="article col-sm-4"><p>세번째열</p></div>

  <div id="footer" class="col-sm-12">
    <p>&copy; Copyright 2011</p>
  </div>
</div>
</body>

</html>

