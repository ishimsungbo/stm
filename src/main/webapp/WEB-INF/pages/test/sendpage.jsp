<%--
  Created by IntelliJ IDEA.
  User: sungbo
  Date: 2015-10-23
  Time: 오후 5:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Json 배열사용법 테스트</title>
  <title>선수등록</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <%--<link rel="stylesheet" href="/resources/jui-master/dist/jui.min.css" />--%>
  <%--<link rel="stylesheet" href="/resources/jui-master/dist/jennifer.theme.min.css" />--%>
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
  <script src="/resources/jui-master/dist/jui.min.js"></script>
</head>
<body class="stmbody">
var 변수는 : ${var} <br>

<a href="test/rep">전송</a>

<p>테스트 경보</p>

<div class="alert alert-warning alert-dismissible" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <strong>Warning!</strong> 동일한 아이디가 이미 존재 합니다.
</div>
<div class="alert alert-success" role="alert">...</div>
<div class="alert alert-info" role="alert">...</div>
<div class="alert alert-warning" role="alert">...</div>
<div class="alert alert-danger" role="alert">...</div>


</body>
</html>
