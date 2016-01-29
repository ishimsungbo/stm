<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 대회정보</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script>
    //jquery start
    $(document).ready(function() {

      setTimeout(function () {
        $('#alert').alert('close');
      }, 3000);




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
    <h3>대회정보</h3>
  </section>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>대회 정보가 정상적으로 생성 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>대회 정보가 정상적으로 삭제 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>대회 정보가 정상적으로 변경 되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="#" method="POST"  name="search">

      <div class="form-group">
        <label for="search_fromdate" class="col-md-2 control-label">대회기간</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="search_fromdate" name="search_fromdate" value="${paging.fromdate}">
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
          <input type="text" class="form-control" id="search_todate" name="search_todate" value="${paging.todate}">
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
          <a class="btn btn-default" href="/match/matchnew" style="width: 110px">대회입력</a>
        </div>
      </div>

      <div class="form-group">
        <label for="search_name" class="col-md-2 control-label">대회명</label>
        <div class="col-md-4">
          <input class="form-control" id="search_name" name="search_name" value="${paging.name}">
        </div>

        <label for="search_location" class="col-md-2 control-label">개최지역</label>
        <div class="col-md-4">
          <input class="form-control" id="search_location" name="search_location" value="${paging.location}">
        </div>

      </div>

      <div class="form-group">
          <label for="search_exclass" class="col-md-2 control-label">선수구성레벨</label>
          <div class="col-md-4">
            <select  class="form-control" id="search_exclass" name="search_exclass">
              <option value="">전체</option>
              <option value="A">Class A</option>
              <option value="B">Class B</option>
              <option value="C">Class C</option>
              <option value="D">Class D</option>
            </select>
          </div>
        <div class="col-md-6"></div>
      </div>

    </form>
  </section>
  <section class="highlight_white">
    <table class="table table-hover">
      <thead>
      <tr>
        <th>대회명</th>
        <th>대회기간</th>
        <th>지역</th>
        <th>선수레벨</th>
        <th class="text-center">승/패</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${list.size()!=0}">
        <c:forEach items="${list}" var="list">
          <tr>
            <td><a href="/match/matchview?matchid=${list.matchid}">${list.name}</a></td>
            <td><fmt:formatDate value="${list.fromdate}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${list.todate}" pattern="yyyy-MM-dd"/></td>
            <td>${list.location}</td>
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
                <c:otherwise>
                  Class D
                </c:otherwise>
              </c:choose>
            </td>
            <th class="text-center">${list.wincount}/${list.losscount}</th>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${list.size()==0}">
        <tr>
          <td colspan="10" style="text-align: center" class="warning">대회정보가 존재하지 않습니다.</td>
        </tr>
      </c:if>
      </tbody>
    </table>

    <div style="text-align: center">
      <form name="listForm" action="matchmain" method="post">
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
          <input type="hidden" id="name" name="search_name" value="${paging.name}" />
          <input type="hidden" id="exclass" name="search_exclass" value="${paging.exclass}" />
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
