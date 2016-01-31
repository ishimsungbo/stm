<%@ page import="com.sun.net.httpserver.HttpsServer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

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


    $('#idcheck').click(function(){
      $('#input1').alert('close');

      var email=$('#email').val();

      if(email==""){
        alert("이메일을 입력해주세요");
      }else{

        $.ajax({
          url : "/user/finduseid",
          type: "get",
          data : { "email" : email },

          success : function(data){
            $("#ajax").remove();

            if(!data){
              alert('아이디가 존재하지 않습니다');
              return false;
            }

            console.log(data.userid);

            if(data.snsprovider==null){
              $('#result').append('<div id="input1" class="alert alert-warning alert-dismissible" role="alert">'+
                      '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
                      ' '+data.userid+' 으로 '+data.joindate+' 일자에 가입하셨습니다.</div>');
            }else{
              $('#result').append('<div id="input1" class="alert alert-warning alert-dismissible" role="alert">'+
                      '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
                      ' '+data.snsprovider+' 으로 '+data.joindate+' 일자에 가입하셨습니다.</div>');
            }


          }
        }); //ajax end

      }

    });//click end


  });
</script>

<style>
  .row{
    margin-top: 20px;
    margin-bottom: 20px;
  }
</style>

<body class="stmbody">

<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h2>아이디 찾기</h2>
  </section>

  <%--가입확인 후 아이디를 보여준다--%>
  <div id="result"></div>

  <section class="highlight_white">
    <div class="row">
      <div class="col-md-2"></div>
      <div class="col-md-2 control-label">E-mail</div>
      <div class="col-md-4">
        <input type="email" class="form-control" id="email">
      </div>
      <div class="col-md-2"><button class="btn btn-default" id="idcheck">가입여부확인</button></div>
      <div class="col-md-2"></div>
    </div>

  </section>


</article>

<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
