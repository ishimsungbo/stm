<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript">

  $(document).ready(function() {
    //아이디찾기 또는 비번 찾기중 어느 버튼을 눌렀는지 hidden 파라메터에 값을 할당한다.
    $('#update').click(function(){
      alert(1);
      $('#flag').val(1);
    });
  });
    </script>
<form action="demo_form.asp" id="update">
  Enter name: <input type="text" name="fname">
  <input type="submit" value="Submit">
</form>



</body>

<div class="nav navbar-default navbar-right">
  <c:if test="${pageContext.request.userPrincipal.name != null}">
    <a href="javascript:formSubmit()">
      <button type="button" class="btn btn-default" style="margin-top: 16px;width: 120px;">
        logout
      </button></a>
  </c:if>
</div>

</html>