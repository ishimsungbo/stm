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
  <script src="/resources/jquery.progressTimer.js"></script>
</head>

<script>

  $(document).ready(function() {
    //진행바를 숨기며 시작한다.
    $('#progress').hide();

    //아이디찾기 또는 비번 찾기중 어느 버튼을 눌렀는지 hidden 파라메터에 값을 할당한다.
    $('#pbtn').click(function(){
      $('#pageflag').val(1);
    });
    $('#pid').click(function(){
      $('#pageflag').val(2);
    });

    $('form').submit(function(){
      //경보메세지 초기화
      $('#alertr').append('<div class="alert alert-info alert-dismissible" role="alert" id="alertu"> ' +
              '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button> ' +
              '<strong>[전송중]</strong>요청하신 정보를 메일로 보냅니다.</div>');
      setTimeout(function(){
        $('#alertu').alert('close');
      },3000);
      $('#input1').alert('close');
      $('#input2').alert('close');
      //모든 정보가 비었을 경우를 체크 합니다.
      if($('#email').val()=='' &&$('#userid').val()=='' && $('#phone').val()=='' ){
        var el = $('#wrapper');
        el.append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                '<span aria-hidden="true">&times;</span></button>' +
                '<strong>메일주소, 아이디, 전화번호등 정보를 입력해주세요!</strong>'+
                '</div>');

        return false;
      }

      if($('#pageflag').val()==2){
        if($('#userid').val()!=''){
          if($('#email').val()=='' && $('#phone').val()==''){
            var el = $('#wrapper');
            el.append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                    '<span aria-hidden="true">&times;</span></button>' +
                    '<strong>메일주소 또는 전화번호등 정보를 입력해주세요!</strong>'+
                    '</div>');
            return false;
          }
        }
      }

      //서브및 버튼 클릭시 프로그래스 바가 진행한다.
      $("#progressTimer").progressTimer({
        timeLimit: 3,
        warningThreshold: 10,
        baseStyle: 'progress-bar-warning',
        warningStyle: 'progress-bar-danger',
        completeStyle: 'progress-bar-info',
      });


    });

  });
</script>


<body class="stmbody">

<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h2>비밀번호/아이디 찾기</h2>
  </section>

  <div id="alertr"></div>

  <section class="highlight_white">

    <form style="margin-top: 20px" class="form-horizontal" method="get" action="/find"  id="frm" modelAttribute="FindUserDto">

    </form>
  </section>


</article>

<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
