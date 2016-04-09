<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!DOCTYPE html>

<html lang="ko">
<head>
  <title>Sport Team Manager</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
</head>

<script>

  $(document).ready(function() {

    //폼전송시 아이디와 이메일란이 빠졌는지 조사
    $('#frm').submit(function(){

      $('#input1').alert('close');

      var email  = $('#email').val();
      var userid = $('#userid').val();

      if(email==""){

        $('#result').append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                '<span aria-hidden="true">&times;</span></button>' +
                '<strong>이메일을 입력해주세요</strong>'+
                '</div>');

        return false;
      }

      if(userid==""){

        $('#result').append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                '<span aria-hidden="true">&times;</span></button>' +
                '<strong>아이디를 입력해주세요</strong>'+
                '</div>');

        return false;
      }


    });
  });
</script>

<style type="text/css">
  .errorMsg { color: red; }
</style>

<body class="stmbody">

<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h2>비밀번호 재설정</h2>
  </section>

  <%--가입확인 후 아이디를 보여준다--%>
  <div id="result"></div>

  <section class="highlight_white">
    <form:form id="frm" commandName="findUserDto" action="lastpwdcheck" cssClass="form-horizontal">

      <div class="form-group">
        <label for="emailchecknum" class="col-md-2 control-label">아이디</label>
        <div class="col-md-4">
          <input class="form-control" type="text" name="userid" value="${findUserDto.userid}" id="userid">
        </div>
      </div>

      <div class="form-group">
        <label for="emailchecknum" class="col-md-2 control-label">이메일주소</label>
        <div class="col-md-4">
          <input class="form-control" type="text" name="email" value="${findUserDto.email}" id="email">
        </div>
      </div>

      <div class="form-group">
        <label for="emailchecknum" class="col-md-2 control-label">인증번호</label>
        <div class="col-md-4">
          <input class="form-control" type="text" name="emailchecknum" value="${findUserDto.emailchecknum}" id="emailchecknum" required>
        </div>
      </div>

      <div class="form-group">
        <label for="password" class="col-md-2 control-label">새비밀번호</label>
        <div class="col-md-4">
          <input class="form-control" type="password" name="password"  id="password" required>
        </div>
      </div>

      <div class="form-group">
        <label for="pwdclone" class="col-md-2 control-label">새비밀번호확인</label>
        <div class="col-md-4">
          <input class="form-control" type="password" name="pwdclone" id="pwdclone" required>
        </div>
      </div>
      <div class="form-group">
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <input class="btn btn-default" type="submit"  value="재설정" style="width: 100px">
        </div>
      </div>
      <div class="form-group">
        <div class="col-md-2"></div>
        <div class="col-md-10">
          <form:errors cssStyle="margin: 5px" path="*" cssClass="errorMsg" element="div"></form:errors>
        </div>
      </div>
    </form:form>
  </section>


</article>

<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
