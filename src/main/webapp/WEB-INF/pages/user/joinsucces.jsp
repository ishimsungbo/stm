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

  <title>회원가입확인</title>

  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <style>
    .row{
      margin: 15px;
    }
    .btn{
      width: 150px;
    }
  </style>

  <script language="JavaScript">
    function nextWin()
    {location = "/"}
  </script>


</head>
<body class="stmbody" onLoad="setTimeout('nextWin()', 5000)">

<header><%@ include file="../headerpage.jsp"%></header>

<article>

  <h3>회원 가입 완료</h3>
  <section style="margin: 50px">
    <div class="row">
      <div class="col-md-2">유저아이디</div>   <div class="col-md-3">${UserVo.userid}</div>
    </div>
    <div class="row">
      <div class="col-md-2">이메일주소</div>   <div class="col-md-3">${UserVo.email}</div>
    </div>
    <div class="row">
      <div class="col-md-2">전화번호</div>   <div class="col-md-3">${UserVo.phone}</div>
    </div>
  </section>

  <section>
    <p>5초후 로그인 페이지로 이동합니다. 로그인 후 팀생성 또는 팀 소속 요청을 하셔서 STM을 이용하세요!</p>
  </section>

</article>



<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
