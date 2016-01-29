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

  <script>

    var uidcheck = '${uidcheck}';


    $(document).ready(function(){
      /*
       $("#errorEmailCheck").hide();

       $('#frm').submit(function() {
       //이메일이 중복인지 아닌지 검사를 한다.
       var email = $('#email').val();

       if(email==""){
       $.showMessage("isemail");
       return false;
       }

       if($('#check').val()=='novali'){
       $.showMessage("checkemail");
       return false;
       };

       if($('#check').val()=='nocheck'){
       $.showMessage("servermail");
       return false;
       }

       });

       $.showMessage = function(check){

       var Message="";

       if(check=="checkemail"){
       Message = "이메일 중복체크를 꼭 해주세요";
       };

       if(check=="isemail"){
       Message = "이메일 아이디는 필수 값입니다. 입력해주세요";
       };

       if(check=="serveremail"){
       Message = "아이디가 이미 존재합니다. 다른 메일을 입력해주세요";
       };
       $('#errorEmailCheck').append('<div class="alert alert-warning alert-dismissible" role="alert" style="margin-top: 20px; width: 500px">' +
       '<button type="button" class="close" data-dismiss="alert" aria-label="Close" style="margin: 0px">' +
       '<span aria-hidden="true">&times;</span></button>'+
       '<strong>Warning!</strong>'+Message+''+
       '</div>');

       $("#errorEmailCheck").show();
       };

       $.checkemail = function(email){
       var lv_count=0;
       $.ajax({
       url : "/validation/checkemail",
       type: "get",
       data : { "email" : email },
       success : function(data){
       if(!data==0){
       alert("메일주소가 존재합니다");
       $('#check').val('nocheck');
       }
       if(data==0){
       alert("가입이 가능합니다.");
       $('#check').val('valid');
       }
       }
       });
       return lv_count;
       }

       $('#checkBtn').click(function () {
       $.checkemail($('#email').val());
       })*/
    });


  </script>

</head>
<body class="stmbody">


<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>회원가입</h3>
  </section>

  <section id="errorEmailCheck">
  </section>

  <spring:form cssClass="form-horizontal"  action="/userdbjoin" method="post" id="frm" name="frm">

    <c:if test="${!snsName.equals('STM')}">

      <div class="alert alert-info" role="alert">${snsName} 정보로 회원가입을 진행하고 계십니다.</div>

      <section class="highlight_white" >

        <input type="hidden" name="userid" id="userid" value="${userid}">
        <input type="hidden" name="snsflag" id="snsflag" value="Y">
        <input type="hidden" name="snsname" id="snsname" value="${snsusername}">
        <input type="hidden" name="snsprovider" id="snsprovider" value="${snsName}">
        <input type="hidden" name="password" id="password" value="${userid}">

        <div class="form-group">
          <label for="email" class="col-md-2 control-label">이메일 주소</label>
          <div class="col-md-4">
            <input type="email" class="form-control" id="email" name ="email" placeholder="이메일주소" required>
          </div>
        </div>

        <div class="form-group">
          <label for="phone" class="col-md-2 control-label">전화번호</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호(필수 아닙니다)">
          </div>
        </div>

        <input class="btn btn-default" type="submit" id="reg" value="회원가입" style="width: 100px">
        <input class="btn btn-default" type="reset" value="지우기" style="width: 100px">
      </section>
    </c:if>

    <c:if test="${snsName.equals('STM')}">
      <section class="highlight_white" >

        <div class="form-group">
          <label for="userid" class="col-md-2 control-label">아이디</label>
          <div class="col-md-4">
            <input class="form-control" name="userid" id="userid" required>
          </div>
        </div>
        <div class="form-group">
          <label for="password" class="col-md-2 control-label">비밀번호</label>
          <div class="col-md-4">
            <input type="password" class="form-control" id="password" name="password" placeholder="암호">
          </div>
        </div>

        <div class="form-group">
          <label for="email" class="col-md-2 control-label">이메일 주소</label>
          <div class="col-md-4">
            <input type="email" class="form-control" id="email" name ="email" placeholder="이메일주소" required>
          </div>
        </div>

        <div class="form-group">
          <label for="phone" class="col-md-2 control-label">전화번호</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호(필수 아닙니다)">
          </div>
        </div>

        <input type="hidden" name="snsflag" id="snsflag" value="N">
        <input class="btn btn-default" type="submit" id="reg" value="회원가입" style="width: 100px">
        <input class="btn btn-default" type="reset" value="지우기" style="width: 100px">

        <c:if test="${uidcheck == 'idcheck'}">
          <div class="alert alert-warning alert-dismissible" role="alert" style="margin-top: 20px; width: 500px">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="margin: 0px"><span aria-hidden="true">&times;</span></button>
            <strong>Warning!</strong> 동일한 아이디가 이미 존재 합니다.
          </div>
        </c:if>
        <spring:errors cssStyle="margin: 5px" path="*" cssClass="errorMsg" element="div"></spring:errors>
      </section>
    </c:if>

  </spring:form>


</article>

</body>
</html>
