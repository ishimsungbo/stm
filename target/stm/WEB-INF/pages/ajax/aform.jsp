<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>response객체에 문자열 담기</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
</head>

<%--
 1.response객체에 문자열 담기
폼아이디를 입력받아서버로 전송그리고 서버에서 파라메터를 받아 DB처리 예 GET--%>
<script>
  $(document).ready(function() {
    $("#joinOk").bind("click",function(){
      $.ajax({
        url : "/ajax/bform",
        type: "get",
        data : { "id" : $("#id").val() },
        success : function(responseData){
          $("#ajax").remove();
          var data = JSON.parse(responseData);
          if(!data){
            alert("존재하지 않는 ID입니다");
            return false;
          }
          var html = '';
          html += '<form class="form-signin" action="" id="ajax">';
          html += '이름<input type="text" class="form-control"  name="name" value="'+data.name+'">';
          html += '아이디<input type="text" class="form-control" name=id" value="'+data.id+'">';
          html += '이메일<input type="text" class="form-control"  name="email" value="'+data.email+'">';
          html += '비밀번호<input type="text" class="form-control" name="password" value="'+data.password+'">';
          html += '</form>';
          $("#container").after(html);
        }
      });
    })
  });
  ;

</script>

<body>
<div id="container">
  <input type="text" id="id" name="id">
  <button id="joinOk" class="btn btn-default">버튼</button>
</div>
</body>
</html>
