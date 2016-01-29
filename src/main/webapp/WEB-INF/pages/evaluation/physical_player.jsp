<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 평가등록</title>
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

      var detaileid="${evalDetailVo.detailid}";

      if(detaileid!=""){
        $('#hidden').append('<input type="hidden" name="detailid" value='+detaileid+'>');
      }

    });
  </script>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>평가정보 입력</h3>
  </section>

  <form:form  cssClass="form-horizontal" action="evaldetaile" method="post" id="frm" name="frm" modelAttribute="evalDetailVo">
    <section class="highlight_white">
      <fieldset>
        <legend>${playername} <h4>선수의 상세한 기량/기록/평가</h4></legend>
        <div class="form-group">
          <label for="creativity" class="col-md-2 control-label">창의성</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="creativity" id="creativity" placeholder="창의적 플레이에 관한 의견 및 평가">${evalDetailVo.creativity}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="game" class="col-md-2 control-label">게임</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="game" id="game" placeholder="게임시 선수에 대한 다양한 의견 및 평가">${evalDetailVo.game}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="tactics" class="col-md-2 control-label">전술</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="tactics" id="tactics" placeholder="전술관련 이해력에 대한 의견 및 평가">${evalDetailVo.tactics}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="leadings" class="col-md-2 control-label">리딩</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="leadings" id="leadings" placeholder="동료선수들과의 유대/리딩/협동력">${evalDetailVo.leadings}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="controll" class="col-md-2 control-label">컨트롤</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="controll" id="controll" placeholder="볼 컨트롤 기술 및 기량 대한 의견 및 평가">${evalDetailVo.controll}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="pass" class="col-md-2 control-label">패스</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="pass" id="pass" placeholder="패스 기술 및 기량에 대한 의견 및 평가">${evalDetailVo.pass}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="shooting" class="col-md-2 control-label">슈팅</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="shooting" id="shooting" placeholder="슈팅 기술 및 기량에 대한 의견 및 평가">${evalDetailVo.shooting}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="kick" class="col-md-2 control-label">킥</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="kick" id="kick" placeholder="슈팅 기술 및 기량에 대한 의견 및 평가">${evalDetailVo.kick}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="dribble" class="col-md-2 control-label">드리블</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="dribble" id="dribble" placeholder="드리블 기술 및 기량에 대한 의견 및 평가">${evalDetailVo.dribble}</textarea>
          </div>
        </div>

        <div id="hidden">
          <input type="hidden" name="evaluationid" value="${evaluationid}">
          <input type="hidden" name="teamid" value="${teamid}">
          <input type="hidden" name="playerid" value="${playerid}">
        </div>



        <a href="/evaluation/physical_update?evaluationid=${evaluationid}" class="btn btn-default" style="width: 110px">뒤로</a>
        <input type="submit" value="저장" class="btn btn-default" style="width: 110px">
      </fieldset>
    </section>
  </form:form>
</article>



<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
