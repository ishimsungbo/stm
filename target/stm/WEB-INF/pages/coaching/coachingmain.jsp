<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="stm" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 코칭정보</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      //이전에 조회 값을 넣었다면..
      $('#search_coachinglevel').val($('#coachinglevel').val());
      $('#search_coachingtype').val($('#coachingtype').val());
      $('#search_playerid').val($('#playerid').val());
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
    <h3>코칭정보</h3>
  </section>

  <section class="highlight_white">

    <form class="form-horizontal" action="/coaching/coachingmain" method="POST"  name="search">
      <div class="row">
        <div class="col-md-2 text-right">
          <h5>검색일자</h5>
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
          <a class="btn btn-default" href="coachinginsert" style="width: 110px">입력</a>
        </div>
      </div>

      <div class="row">
        <div class="col-md-2 text-right">
          <h5>코칭유형</h5>
        </div>
        <div class="col-md-3">
          <spring:select path="levelvo" name="search_coachinglevel" id="search_coachinglevel" class="form-control">
            <spring:option value="" label="전체"/>
            <spring:options items="${coachinglevel}" itemValue="LookupCode" itemLabel="DescripTion"/>
          </spring:select>
        </div>
        <div class="col-md-2 text-right">
          <h5>코칭부분</h5>
        </div>
        <div class="col-md-3">
          <spring:select path="typevo" name="search_coachingtype" id="search_coachingtype" class="form-control">
            <spring:option value="" label="전체"/>
            <spring:options items="${coachingtype}" itemValue="LookupCode"
                            itemLabel="DescripTion" />
          </spring:select>
        </div>
        <div class="col-md-2"></div>
      </div>

      <div class="row">
        <div class="col-md-2 text-right">
          <h5>선수이름</h5>
        </div>
        <div class="col-md-3">
          <spring:select path="SearchVo" name="search_playerid" id="search_playerid" class="form-control">
            <spring:option value="" label="전체"/>
            <spring:options items="${poslist}" itemValue="playerid" itemLabel="playername" />
          </spring:select>
        </div>
      </div>
    </form>
  </section>

  <section class="highlight_white">
    <table class="table table-hover">
      <thead>
      <tr>
        <th>선수이름</th>
        <th>제목</th>
        <th>코칭유형</th>
        <th>코칭부분</th>
        <th>중복여부</th>
        <th>일시</th>
      </tr>
      </thead>
      <!-- db data view -->
      <thead>
<c:if test="${list.size() != 0}">
      <c:forEach items="${list}" var="coachinglist">
        <tr>
          <td>${coachinglist.playername}</td>
          <td><a href="coachingview?coachingid=${coachinglist.coachingid}" data-toggle="tooltip" data-placement="left" title="${coachinglist.problem}" >${fn:substring(coachinglist.subject,0,15)}</a></td>
          <td>${coachinglist.leveldisp}</td>
          <td>${coachinglist.typedisp}</td>
          <td>${coachinglist.recoachingflag}</td>
          <td><fmt:formatDate value="${coachinglist.date}" pattern="yyyy년 MM월 dd일"/></td>
        </tr>
      </c:forEach>
</c:if>
<c:if test="${list.size() == 0}">
<tr>
  <td colspan="9" style="text-align: center" class="warning">개인코칭 자료가 없습니다.</td>
</tr>
</c:if>
      </tbody>
      </thead>
    </table>

    <div style="text-align: center">
      <form name="listForm" action="coachingmain" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />
          <input type="hidden" id="playerid" name="search_playerid" value="${paging.playerid}" />
          <input type="hidden" name="search_fromdate" value="${paging.fromdate}" />
          <input type="hidden" name="search_todate" value="${paging.todate}" />
          <input type="hidden" id="coachinglevel" name="search_coachinglevel" value="${paging.coachinglevel}" />
          <input type="hidden" id="coachingtype" name="search_coachingtype" value="${paging.coachingtype}" />


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

<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
