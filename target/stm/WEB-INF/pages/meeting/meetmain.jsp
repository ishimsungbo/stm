<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 팀회의</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <%--  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
    <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
    <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>--%>

  <%--datetimepicker--%>
  <link rel="stylesheet" href="/resources/datetimepicker/css/bootstrap-datetimepicker.min.css">
  <script type="text/javascript" src="/resources/datetimepicker/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
  <script type="text/javascript" src="/resources/datetimepicker/js/locales/bootstrap-datetimepicker.ko.js" charset="UTF-8"></script>

  <script>
    //jquery start
    $(document).ready(function() {

      setTimeout(function () {
        $('#alert').alert('close');
      }, 3000);


      $('#search_meetingtype').val($('#meetingtype').val());

    });

    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();
    }

  </script>


</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>

  <section class="page-subject">
    <h3>팀회의 목록</h3>
  </section>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[삭제]</strong> 회의 정보가 삭제되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[생성]</strong> 회의 정보가 정보가 생성되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[변경]</strong> 회의 정보가 정보가 변경되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="/meeting/meetmain" method="POST"  name="search">
      <%--1열--%>
      <fieldset>
        <div class="form-group" style="margin-bottom: auto">
          <label for="search_fromdate" class="col-md-2 control-label">회의일자</label>
          <div class="col-md-3">
            <div class="input-group date search_fromdate"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="search_fromdate">
              <input class="form-control" size="20" type="text" value="${paging.fromdate}">
              <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
              <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
            </div>
            <input type="hidden" id="search_fromdate" name="search_fromdate" /><br/>
            <script>
              $('.search_fromdate').datetimepicker({
                language:  'ko',
                weekStart: 1,
                todayBtn:  1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                showMeridian: 1
              });
            </script>
          </div>

          <div class="col-md-3">
            <div class="input-group date search_todate"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="search_todate">
              <input class="form-control" size="20" type="text" value="${paging.todate}">
              <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
              <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
            </div>
            <input type="hidden" id="search_todate" name="search_todate" /><br/>
            <script>
              $('.search_todate').datetimepicker({
                language:  'ko',
                weekStart: 1,
                todayBtn:  1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                showMeridian: 1
              });
            </script>
          </div>


          <div class="col-md-4">
            <button type="submit" class="btn btn-default" style="width: 110px">검색</button>
            <a class="btn btn-default" href="/meeting/meetinsert" style="width: 110px">입력</a>
          </div>
        </div>

        <div class="form-group" style="margin-top: auto">
          <label for="search_subject" class="col-md-2 control-label">주제</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="search_subject" name="search_subject" value="${paging.subject}">
          </div>

          <label for="search_meetingtype" class="col-md-2 control-label">종류</label>
          <div class="col-md-4">
            <select  class="form-control" id="search_meetingtype" name="search_meetingtype">
              <option value="">전체</option>
              <option value="A" selected>정기회의</option>
              <option value="B">대회준비</option>
              <option value="C">전지훈련</option>
              <option value="E">기타</option>
            </select>
          </div>
        </div>

      </fieldset>
    </form>
  </section>

  <section class="highlight_white">

    <table class="table table-hover">
      <thead>
      <tr>
        <th>회의주제</th>
        <th>회의일시</th>
        <th>회의종류</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${list.size()!=0}">
        <c:forEach items="${list}" var="list">
          <tr>
            <td><a href="/meeting/updateview?meetingid=${list.meetingid}">${list.subject}</a></td>
            <td><fmt:formatDate value="${list.fromdate}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>
              <c:choose>
                <c:when test="${list.meetingtype== 'A'}">
                  정기회의
                </c:when>
                <c:when test="${list.meetingtype== 'B'}">
                  대회준비
                </c:when>
                <c:when test="${list.meetingtype== 'C'}">
                  전지훈련
                </c:when>
                <c:when test="${list.meetingtype== 'D'}">
                  기타
                </c:when>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${list.size()==0}">
        <tr>
          <td colspan="10" style="text-align: center" class="warning">회의이력이 존재하지 않습니다.</td>
        </tr>
      </c:if>
      </tbody>
    </table>


    <div style="text-align: center">
      <form name="listForm" action="meetmain" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />

          <input type="hidden" id="fromdate" name="search_fromdate" value="${paging.fromdate}" />
          <input type="hidden" id="todate" name="search_todate" value="${paging.todate}" />
          <input type="hidden" id="meetingtype" name="search_meetingtype" value="${paging.meetingtype}" />
          <input type="hidden" id="subject" name="search_subject" value="${paging.subject}" />


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
