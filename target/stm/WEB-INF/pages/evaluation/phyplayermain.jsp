<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="message" uri="http://www.springframework.org/tags"%>
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
    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();
    }

    //jquery start
    $(document).ready(function() {

      setTimeout(function(){
        $('#alert').alert('close');
      },3000);



      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })

    });

  </script>


</head>

<%--여기여기 : <message:message code="test"/>--%>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>

  <section class="page-subject">
    <h3>선수신체정보</h3>
  </section>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>  선수 신체정보 기록이 정상적으로 변경 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 선수 신체정보 기록이 정상적으로 생성 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 선수 신체정보 기록이 정상적으로 삭제 되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="/evaluation/phyplayermain" method="POST"  name="search">
      <div class="form-group">

        <label for="search_fromdate" class="col-md-2 control-label">기록일자</label>
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
          <a class="btn btn-default" href="phyplayerinsert" style="width: 110px">입력</a>
        </div>
      </div>

    </form>
  </section>

  <section class="highlight_white">
    <table class="table table-condensed ">
      <thead>
      <tr>
        <th>일자</th>
        <th>주관자</th>
        <th>선수레벨</th>
        <th>설명/기타</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${listHeader.size() != 0}">
        <c:forEach items="${listHeader}" var="list">
          <tr>
            <td><a href="/evaluation/phyplayerupdate?headerid=${list.headerid}"><fmt:formatDate value="${list.exdate}" pattern="yyyy년 MM월 dd일"/></a></td>
            <td>${list.performer}</td>
            <td>
              <c:choose>
                <c:when test="${list.exclass== 'O'}">
                  전체
                </c:when>
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
            <td>${fn:substring(list.description,0,15)}</td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${listHeader.size() == 0}">
        <tr>
          <td colspan="10" style="text-align: center" class="warning">생성하신 선수의 신체 기록정보가 존재하지 않습니다.</td>
        </tr>
      </c:if>
      </tbody>

    </table>
  </section>

</article>


<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
