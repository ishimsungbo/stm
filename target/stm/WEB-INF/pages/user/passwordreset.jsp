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
  <script src="/resources/jquery.progressTimer.js"></script>
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

      alert('['+email+']  이메일주소로 인증번호를 발송합니다.');

      $("#progressTimer").progressTimer({
        timeLimit: 5,
        warningThreshold: 10,
        baseStyle: 'progress-bar-warning',
        warningStyle: 'progress-bar-danger',
        completeStyle: 'progress-bar-info',
        onFinish: function() {
          console.log("I'm done");
        }
      });

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
    <form:form id="frm" commandName="findUserDto" action="pwdreset" cssClass="form-horizontal">

      <div id="progressTimer"></div>

      <div class="form-group">
        <label for="email" class="col-md-2 control-label">유저ID</label>
        <div class="col-md-4">
          <input class="form-control" type="text" name="userid" id="userid" value="${findUserDto.userid}" required>
        </div>
      </div>
      <div class="form-group">
        <label for="email" class="col-md-2 control-label">이메일</label>
        <div class="col-md-4">
          <input class="form-control" type="email" name="email" id="email" value="${findUserDto.email}" required>
        </div>
      </div>
      <div class="form-group">
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <input class="btn btn-default" type="submit"  value="다음단계" style="width: 100px">
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
