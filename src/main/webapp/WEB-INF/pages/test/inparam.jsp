<%--
  Created by IntelliJ IDEA.
  User: sungbo
  Date: 2015-10-29
  Time: 오후 2:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title></title>
</head>
<body>

<% //index page 에서 test 합니다.
 String wid = request.getParameter("wid");
  String wpw = request.getParameter("wpw");
  out.println("여기는 inparam page 입니다.");
  out.println(wid+"<br>");
  out.println(wpw+"<br>");
%>

</body>
</html>
