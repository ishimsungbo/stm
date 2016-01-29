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
  $(document).ready(function() {

  var exclass    =   "<c:out value='${matchsVo.exclass}'/>";
    var formation    =   "<c:out value='${matchsVo.formation}'/>";
  $('#exclass').val(exclass);
  $('#formation').val(formation);

  });
  </script>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>대회정보 보기/수정</h3>
  </section>


  <spring:form method="post" action="matchupdate"  name="frm" class="form-horizontal" modelAttribute="matchsVo">
    <section class="highlight_white">

      <div class="form-group">
        <label for="exclass" class="col-md-2 control-label">참가선수레벨</label>
        <div class="col-md-4">
          <select  class="form-control" id="exclass" name="exclass" required>
            <option value="A" selected>Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>
      </div>

      <div class="form-group">
        <label for="name" class="col-md-2 control-label">대회명</label>
        <div class="col-md-10">
          <input class="form-control" name="name" id="name" placeholder="필수사항" value="${matchsVo.name}" required>
        </div>
      </div>

      <div class="form-group">
        <label for="fromdate" class="col-md-2 control-label">대회기간</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="fromdate" name="fromdate" value="${matchsVo.efromdate}">
          <script>
            $('#fromdate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>

        <div class="col-md-2">
          <input type="text" class="form-control" id="todate" name="todate" value="${matchsVo.etodate}">
          <script>
            $('#todate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>
      </div>

      <div class="form-group">

        <label for="location" class="col-md-2 control-label">대회지역</label>
        <div class="col-md-4">
          <input type="text" class="form-control" id="location" name="location" value="${matchsVo.location}" placeholder="필수사항" required>
        </div>

        <label for="formation" class="col-md-2 control-label">주포메이션</label>
        <div class="col-md-4">
          <select name="formation" class="form-control" id="formation">
            <option value="A">4-4-2</option>
            <option value="B">3-5-2</option>
            <option value="C">4-5-1</option>
            <option value="D">3-6-1</option>
          </select>
        </div>
      </div>

      <div class="form-group">
        <label for="description" class="col-md-2 control-label">특이사항/기타</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="description" id="description"  placeholder="선택입력">${matchsVo.description}</textarea>
        </div>
      </div>
    </section>

    <section class="highlight_white">
      <div class="form-group">
        <label for="goal" class="col-md-2 control-label">대회목표</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="goal" id="goal"  placeholder="(목표성적 및 대회참가 구체적 목표) 선택입력">${matchsVo.goal}</textarea>
        </div>
      </div>
      <div class="form-group">
        <label for="preparation" class="col-md-2 control-label">전략/전술</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="preparation" id="preparation"  placeholder="(대회를 위한 준비 훈련/경기) 선택입력">${matchsVo.preparation}</textarea>
        </div>
      </div>

      <div class="form-group">
        <label for="satisfaction" class="col-md-2 control-label">만족사항</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="satisfaction" id="satisfaction"  placeholder="(잘된점/발전가능성) 선택입력">${matchsVo.satisfaction}</textarea>
        </div>
      </div>

      <div class="form-group">
        <label for="lack" class="col-md-2 control-label">부족한점</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="lack" id="lack"  placeholder="(반성/보완) 선택입력">${matchsVo.lack}</textarea>
        </div>
      </div>
    </section>

    <input type="hidden" name="matchid" value="${matchsVo.matchid}">
    <input type="hidden" name="teamid" value="${matchsVo.teamid}">

    <a href="/match/matchmain" class="btn btn-default" style="width: 110px">대회목록</a>
    <input type="submit" value="변경"  class="btn btn-default" style="width: 110px">
    <a class="btn btn-default" style="width: 110px" href="/match/delete?matchid=${matchsVo.matchid}">삭제</a>
  </spring:form>
</article>

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
