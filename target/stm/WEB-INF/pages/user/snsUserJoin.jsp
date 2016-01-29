<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>회원가입</title>
  <%--import css--%>

  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <style type="text/css">
    .errorMsg { color: red; }
  </style>



</head>
<body class="stmbody" style="background-color: #f8f8f8">


<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>회원가입</h3>
  </section>
  <spring:form cssClass="form-horizontal"  action="/insert" method="post" id="frm" name="frm" commandName="userVo">
  <section class="highlight_white" >

    <input type="hidden" name="snsflag" id="snsflag" value="Y">
    <input type="hidden" name="userid" id="userid" value="${userVo.userid}">
    <input type="hidden" name="password" id="password" value="${userVo.userid}">
    <input type="hidden" name="snsprovider" id="snsprovider" value="${userVo.snsprovider}">

    <div class="form-group">
      <div class="col-md-12">
    <div class="text-center">${userVo.snsprovider} 으로 회원가입을 진행합니다.</div>
      </div>
    </div>

    <div class="form-group">
      <label for="userid" class="col-md-2 control-label">이메일</label>
      <div class="col-md-4">
        <input type="email" class="form-control" id="email" name ="email" value="${userVo.email}">
      </div>
      <div class="col-md-6">
        <spring:errors cssStyle="margin: 5px" path="email" cssClass="errorMsg" element="div"></spring:errors>
      </div>
    </div>

    <div class="form-group">
      <div class="col-md-5"></div>
      <div class="col-md-2">
        <input class="btn btn-primary text-center" type="submit" id="reg" value="회원가입" style="width: 100px">
      </div>
      <div class="col-md-5"></div>
    </div>
    </spring:form>


</article>
<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
