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
    <h3>전지훈련 목록</h3>
  </section>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[삭제]</strong> 전지훈련정보가 삭제되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[생성]</strong> 전지훈련정보가 생성되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[변경]</strong> 전지훈련정보가 변경되었습니다.
    </div>
  </c:if>

  <section class="highlight_white">

    <div class="form-group">
      <div class="col-md-10"></div>
      <a class="btn btn-default col-md-2" href="sptrinsert" style="width: 110px; margin-bottom: 10px">입력</a>
    </div>

    <table class="table table-bordered" style="margin-top: 20px">
      <thead>
      <tr>
        <th>제목</th>
        <th>기간</th>
        <th>장소</th>
        <th>참여인원</th>
      </tr>
      </thead>
      <!-- db data view -->
      <tbody>
      <c:if test="${list.size() != 0}">
        <c:forEach items="${list}" var="list">
          <tr>
            <td><a href="/sptr/sptrview?sptrid=${list.sptrid}">${list.subject}</a></td>
            <td>${list.exfromdate} ~ ${list.extomdate}</td>
            <td>${list.location}</td>
            <td>${list.participationplayer}</td>
          </tr>
        </c:forEach>
      </c:if>

      <c:if test="${list.size() == 0}">
        <tr>
          <td colspan="10" style="text-align: center" class="warning">전지훈련 정보가 존재하지 않습니다.</td>
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
