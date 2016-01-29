<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 전지훈련리스트</title>
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


      $('#search_exclass').val($('#exclass').val());
      $('#search_weather').val($('#weather').val());

    });

    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();
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
    <h3>훈련일지 목록</h3>
  </section>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[삭제]</strong> 훈련일지 정보가 삭제되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[생성]</strong> 훈련일지 정보가 생성되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[변경]</strong> 훈련일지 정보가 변경되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="/trjournals/trjournalmain" method="POST"  name="search">
      <%--1열--%>
      <fieldset>
      <div class="form-group" style="margin-bottom: auto">
        <label for="search_fromdate" class="col-md-2 control-label">훈련일자</label>
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
          <a class="btn btn-default" href="/trjournals/jrinsertview" style="width: 110px">입력</a>
        </div>
      </div>

      <div class="form-group">
        <label for="search_exclass" class="col-md-2 control-label">선수레벨</label>
        <div class="col-md-4">
          <select  class="form-control" id="search_exclass" name="search_exclass">
            <option value="" selected>모두</option>
            <option value="O">전체대상</option>
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>

        <label for="search_weather" class="col-md-2 control-label">날씨</label>
        <div class="col-md-4">
          <select  class="form-control" id ="search_weather" name="search_weather">
            <option value="">전체</option>
            <option value="맑음">맑음</option>
            <option value="흐림">흐림</option>
            <option value="비">비</option>
            <option value="눈">눈</option>
          </select>
        </div>
      </div>

        <div class="form-group">
          <label for="search_concept" class="col-md-2 control-label">훈련주제</label>
          <div class="col-md-4">
          <input type="text" class="form-control" id="search_concept" name="search_concept" value="${paging.concept}">
          </div>
          <label for="search_location" class="col-md-2 control-label">장소</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="search_location" name="search_location" value="${paging.location}">
          </div>
        </div>

      </fieldset>
    </form>
  </section>

  <section class="highlight_white">

    <table class="table table-hover">
      <thead>
      <tr>
        <th>훈련주제</th>
        <th>일자</th>
        <th>선수레벨</th>
        <th>참여인원</th>
        <th>훈련평가점수</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${list.size()!=0}">
        <c:forEach items="${list}" var="list">
          <tr>
            <td><a href="/trjournals/jrview?jeid=${list.jeid}">${fn:substring(list.concept,0,20)}</a></td>
            <td><fmt:formatDate value="${list.trdate}" pattern="yyyy-MM-dd HH:mm"/></td>
            <td>
              <c:choose>
                <c:when test="${list.exclass== 'A'}">
                  Class A
                </c:when>
                <c:when test="${list.exclass== 'B'}">
                  Class B
                </c:when>
                <c:when test="${list.exclass== 'C'}">
                  Class C
                </c:when>
                <c:when test="${list.exclass== 'D'}">
                  Class D
                </c:when>
                <c:otherwise>
                  전체
                </c:otherwise>
              </c:choose>
            </td>
            <td>${list.playercount}</td>
            <td>${list.satisfaction}</td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${list.size()==0}">
        <tr>
          <td colspan="5" style="text-align: center" class="warning">등록된 훈련일지가 존재하지 않습니다.</td>
        </tr>
      </c:if>
      </tbody>
    </table>


    <div style="text-align: center">
      <form name="listForm" action="trjournalmain" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />

          <input type="hidden" name="search_fromdate" value="${paging.fromdate}"/>
          <input type="hidden" name="search_todate" value="${paging.todate}" />
          <input type="hidden" id="exclass" name="search_exclass" value="${paging.exclass}" />
          <input type="hidden" id="weather" name="search_weather" value="${paging.weather}" />
          <input type="hidden" id="concept" name="search_concept" value="${paging.concept}" />
          <input type="hidden" id="location" name="search_location" value="${paging.location}" />

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
