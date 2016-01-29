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

<p> pdf 변환 테스트 페이지 </p>

<div align="center">
  <h1>Spring MVC PDF View Demo (using iText library)</h1>
  <h3><a href="/downloadPDF">Download PDF Document</a></h3>
</div>

</body>

</html>

