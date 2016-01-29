<%@ page import="javax.xml.ws.spi.http.HttpContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />

  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script>






  </script>
</head>
<body>

로그인 결과값 페이지 돌아온 토큰은: <br>
응답 바디는 : ${data}
<br>
응답 바디는 : ${userData}

</body>
</html>
