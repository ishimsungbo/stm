<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 전지훈련 정보생성</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <%--extend slider--%>
  <script type="text/javascript" src="/resources/jqueryextend/jquery-ui-1.10.3.custom.js"></script>
  <link rel="stylesheet" type="text/css" href="/resources/jqueryextend/jquery-ui.css">

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script>
    $(document).ready(function() {

      var exfromdate    =   "<c:out value='${sptrainingVo.exfromdate}'/>";
      var extomdate    =   "<c:out value='${sptrainingVo.extomdate}'/>";

      $('#efromdate').val(exfromdate);
      $('#etodate').val(extomdate);

    });
  </script>

  <style>
    /*.row{*/
    /*margin-top: 10px;*/
    /*}*/
  </style>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>

  <section class="page-subject">
    <h2>전지훈련 정보생성</h2>
  </section>

  <spring:form method="post" action="/sptr/updateSP"  name="frm" class="form-horizontal">
    <section class="highlight_white">
      <fieldset>
        <legend>전지훈련</legend>
        <div class="form-group">
          <label for="subject" class="col-md-2 control-label">제목</label>
          <div class="col-md-6">
            <input type="text" class="form-control" id="subject" name="subject" value="${sptrainingVo.subject}" required>
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label for="efromdate" class="col-md-2 control-label">기간</label>
          <div class="col-md-2">
            <input type="text" class="form-control" id="efromdate" name="efromdate" required>
            <script>
              $('#efromdate').datepicker({
                format: "yyyy-mm-dd",
                language: "ko",
                autoclose: true,
                todayHighlight: true
              });
            </script>
          </div>

          <div class="col-md-2">
            <input type="text" class="form-control" id="etodate" name="etodate" required>
            <script>
              $('#etodate').datepicker({
                format: "yyyy-mm-dd",
                language: "ko",
                autoclose: true,
                todayHighlight: true
              });
            </script>
          </div>
        </div>


        <div class="form-group">
          <label for="location" class="col-md-2 control-label">장소</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="location" name="location" value="${sptrainingVo.location}" required>
          </div>

          <label class="col-md-2 control-label">스케줄생성</label>
          <div class="col-md-4">
            <div class="radio">
              <label>
                <input type="radio" name="addscflag" value="Y" checked> Yes
              </label>
              <label>
                <input type="radio" name="addscflag" value="N"> No
              </label>
            </div>
          </div>
        </div>

        <div class="form-group">
          <label for="object" class="col-md-2 control-label">목표</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="object" id="object" required>${sptrainingVo.object}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="description" class="col-md-2 control-label">비고/기타</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="description" id="description" required>${sptrainingVo.description}</textarea>
          </div>
        </div>

      </fieldset>
      <fieldset>
        <legend>전지훈련 준비 물품내역</legend>
        <div class="form-group">
          <label for="ballcount" class="col-md-2 control-label">축구공</label>
          <div class="col-md-2">
            <input type="number" id="ballcount" name="ballcount" class="form-control" value="${sptrainingVo.ballcount}" min="0" max="100" step="1">
          </div>
          <label for="conecount" class="col-md-2 control-label">꼬깔콘</label>
          <div class="col-md-2">
            <input type="number" id="conecount" name="conecount" class="form-control" value="${sptrainingVo.conecount}" min="0" max="100" step="1">
          </div>
          <label for="platecount" class="col-md-2 control-label">접시콘</label>
          <div class="col-md-2">
            <input type="number" id="platecount" name="platecount" class="form-control" value="${sptrainingVo.platecount}" min="0" max="100" step="1">
          </div>
        </div>

        <div class="form-group">
          <label for="vestuniform" class="col-md-2 control-label">훈련조끼</label>
          <div class="col-md-2">
            <input type="number" id="vestuniform" name="vestuniform" class="form-control" value="${sptrainingVo.vestuniform}" min="0" max="100" step="1">
          </div>
          <label for="polescount" class="col-md-2 control-label">드리블봉</label>
          <div class="col-md-2">
            <input type="number" id="polescount" name="polescount" class="form-control" value="${sptrainingVo.polescount}" min="0" max="100" step="1">
          </div>
          <label for="ladder" class="col-md-2 control-label">사다리</label>
          <div class="col-md-2">
            <input type="number" id="ladder" name="ladder" class="form-control" value="${sptrainingVo.ladder}" min="0" max="100" step="1">
          </div>
        </div>

        <div class="form-group">
          <label for="roundbases" class="col-md-2 control-label">봉베이스</label>
          <div class="col-md-2">
            <input type="number" id="roundbases" name="roundbases" class="form-control" value="${sptrainingVo.roundbases}" min="0" max="100" step="1">
          </div>
          <label for="participationplayer" class="col-md-2 control-label">참여선수수</label>
          <div class="col-md-2">
            <input type="number" id="participationplayer" name="participationplayer" class="form-control" value="${sptrainingVo.participationplayer}" min="0" max="100" step="1">
          </div>
          <div class="col-md-4">
          </div>
        </div>
      </fieldset>
    </section>

    <input type="hidden" name="sptrid" id="sptrid" value="${sptrainingVo.sptrid}">
    <a href="/sptr/sptrmain" class="btn btn-default" style="width: 110px;">훈련목록</a>
    <input type="submit" class="btn btn-default" id="savebutton" value="변경" style="width: 110px;"/>
    <a href="/sptr/deleteSP?sptrid=${sptrainingVo.sptrid}" class="btn btn-default" style="width: 110px">삭제</a>
  </spring:form>
</article>

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
