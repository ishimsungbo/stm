<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 평가정보리스트</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script>
    $(document).ready(function() {
      $('#search_weather').val($('#weather').val());
    });

    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();

      console.log("pageNo : " + pageNo);
    }
  </script>

  <style>
    .row{
      margin-top: 5px;
    }
  </style>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>

  <section class="page-subject">
    <h3>평가목록</h3>
  </section>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 평가 자료가 정상적으로 변경 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 평가 자료가 정상적으로 삭제 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 평가 자료가 정상적으로 생성 되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="/evaluation/physical" method="POST"  name="search">
      <%--1번째 열--%>
      <div class="row">
        <div class="col-md-2 text-right">
          <h5>평가일자</h5>
        </div>
        <div class="col-md-2">
          <%--<input type="date" class="form-control" name="fromdate" id="fromdate" style="width: 155px;float: left">--%>
          <input type="text" class="form-control" name="search_fromdate" id="search_fromdate" style="width: 155px;float: left" data-provide="datepicker" value="${paging.fromdate}">
          <script>
            $('#search_fromdate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>
        <div class="col-md-2">
          <%--<input type="date" class="form-control" name="todate" id="todate" style="width: 155px;float: left">--%>
          <input type="text" class="form-control" name="search_todate" id="search_todate" style="width: 155px;float: left" data-provide="datepicker" value="${paging.todate}">
          <script>
            $('#search_todate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <button type="submit" class="btn btn-default" style="width: 110px">검색</button>
          <a class="btn btn-default" href="physical_insert" style="width: 110px">입력</a>
        </div>
      </div>
      <%--2번째 열--%>
      <div class="row">
        <div class="col-md-2 text-right"><h5>주관자</h5></div>
        <div class="col-md-3">
          <input type="text" class="form-control" id="search_performer" name="search_performer" value="${paging.performer}">
        </div>
        <div class="col-md-2 text-right"><h5>날씨</h5></div>
        <div class="col-md-3">
          <select id="search_weather" name="search_weather" class="form-control">
            <option value="">전체</option>
            <option value="맑음">맑음</option>
            <option value="흐림">흐림</option>
            <option value="비">비</option>
            <option value="눈">눈</option>
          </select>
        </div>
        <div class="col-md-2"></div>
      </div>
      <div class="row">
        <div class="col-md-2 text-right"><h5>제목</h5></div>
        <div class="col-md-3">
          <input type="text" class="form-control" id="search_subject" name="search_subject" style="width: 300px" value="${paging.subject}">
        </div>
        <div class="col-md-2 text-right"><h5>장소</h5></div>
        <div class="col-md-3">
          <input type="text" class="form-control" id="search_location" name="search_location" value="${paging.location}">
        </div>
      </div>
    </form>
  </section>


  <section class="highlight_white">
    <table class="table table-hover">
      <thead>
      <tr>
        <th>제목</th>
        <th>장소</th>
        <th>평가일자</th>
        <th>주관자</th>
        <th>날씨</th>
      </tr>
      </thead>
      <!-- db data view -->
      <tbody>
      <c:if test="${list.size() != 0}">
        <c:forEach items="${list}" var="evallist">
          <tr>
            <td><a href="physical_update?evaluationid=${evallist.evaluationid}">${fn:substring(evallist.subject,0,20)}</a></td>
            <td>${fn:substring(evallist.location,0,10)}</td>
            <td><fmt:formatDate value="${evallist.date}" pattern="yyyy년 MM월 dd일"/></td>
            <td>${evallist.performer}</td>
            <td>${evallist.weather}</td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${list.size() == 0}">
        <tr>
          <td colspan="10" style="text-align: center" class="warning">평가자료가 존재하지 않습니다.</td>
        </tr>
      </c:if>
      </tbody>
    </table>

    <div style="text-align: center">
      <form name="listForm" action="physical_main" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />

          <input type="hidden" name="search_fromdate" value="${paging.fromdate}" />
          <input type="hidden" name="search_todate" value="${paging.todate}" />
          <input type="hidden" name="search_performer" value="${paging.performer}" />
          <input type="hidden" id="weather" name="search_weather" value="${paging.weather}" />
          <input type="hidden" name="search_subject" value="${paging.subject}" />
          <input type="hidden" name="search_location" value="${paging.location}" />

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

  </section>
</article>



<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
