<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>선수등록</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


  <script type="text/javascript">
    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();

//      console.log("pageNo : " + pageNo);
    }

  </script>

  <style type="text/css">
    .selected {font-weight: bold;}
  </style>

</head>
<body>

<section style="margin: 50px auto 10px auto;width: 960px; height: 630px" class="highlight_white">
  <table class="table table-hover">
    <thead>
    <tr>
      <th>순번</th>
      <th>내용</th>
      <th>날짜</th>

    </tr>
    </thead>

    <tbody>
    <c:if test="${boardList.size() != 0}">
      <c:forEach items="${boardList}" var="board">
        <tr>
          <td>${board.bid}</td>
          <td>${board.content}</td>
          <td>${board.writedate}</td>
        </tr>
      </c:forEach>
    </c:if>

    </tbody>
  </table>
</section>

<div style="text-align: center">
<form name="listForm" action="pagenation.ok" method="post">
<div class="pagination">
    <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
    <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
    <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
    <input type="hidden" name="pageNo" value="${paging.pageNo}" />
    <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
    <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
    <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />


  <li class="previous"><a href="javascript:goPage(${paging.firstPageNo})"><span aria-hidden="true"></span>처음</a></li>
  <li><a href="javascript:goPage(${paging.prevPageNo})" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
  <li>
    <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
      <c:choose>
        <c:when test="${i eq paging.pageNo}">
          <a href="javascript:goPage(${i})" class="selected">${i}</a>
        </c:when>
        <c:otherwise>
          <a href="javascript:goPage(${i})">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </li>
  <li><a href="javascript:goPage(${paging.nextPageNo})" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
  <li class="next"><a href="javascript:goPage(${paging.finalPageNo})">마지막<span aria-hidden="true"></span></a></li>
</div>
</form>
</div>


</body>
</html>