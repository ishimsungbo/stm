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
      var exclass = "${headerVo.exclass}";
      $('#exclass').val(exclass);

    });

  </script>

</head>


<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>선수신체정보 변경</h3>
  </section>

  <form  class="form-horizontal" action="phyupdate" method="post" id="frm" name="frm">

    <input type="hidden" value="${headerVo.headerid}" name="headerid">

    <section class="highlight_white">

      <div class="form-group">

        <label for="description" class="col-md-2 control-label">선수레벨</label>
        <div class="col-md-2">
          <select  class="form-control" id="exclass" name="exclass" required>
            <option value="" selected>선택</option>
            <option value="O">전체대상</option>
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>

        <label for="extdate" class="col-md-2 control-label">입력일자</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="extdate" name="extdate" value="${headerVo.extdate}" required>
          <script>
            $('#extdate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>

        <label for="performer" class="col-md-2 control-label">주관자</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="performer" value="${headerVo.performer}" name="performer" required>
        </div>
      </div>

      <div class="form-group">
        <label for="description" class="col-md-2 control-label">설명/기타</label>
        <div class="col-md-5">
          <textarea class="form-control" rows="1" name="description" id="description">${headerVo.description}</textarea>
        </div>
      </div>
    </section>
    <section class="highlight_white">

      <table class="table table-condensed" id="myTable">
        <thead>
        <tr>
          <th>이름</th>
          <th>키(cm)</th>
          <th>몸무게(kg)</th>
          <th>체지방</th>
          <th>발크기(cm)</th>
          <th>50m(초)</th>
          <th>100m(초)</th>
          <th>200m(초)</th>
          <th>400m(초)</th>
          <th>몸크기</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${phylines.lineVos}" var="lineVos" varStatus="status">
          <tr>
            <td width="9%">${lineVos.playername}</td>
            <td><input class="form-control text-center" type="number"  step="any"  name="lineVos[${status.index}].height" value="${lineVos.height}"></td>
            <td><input class="form-control text-center" type="number" step="0.1" name="lineVos[${status.index}].weight" value="${lineVos.weight}"></td>
            <td><input class="form-control text-center" type="number"  name="lineVos[${status.index}].bodyfat" value="${lineVos.bodyfat}"></td>
            <td><input class="form-control text-center" type="number"  name="lineVos[${status.index}].footsize" value="${lineVos.footsize}"></td>
            <td><input class="form-control text-center" type="number" step="0.1" name="lineVos[${status.index}].fifty" value="${lineVos.fifty}"></td>
            <td><input class="form-control text-center" type="number" step="0.1" name="lineVos[${status.index}].onehundred" value="${lineVos.onehundred}"></td>
            <td><input class="form-control text-center" type="number" step="0.1" name="lineVos[${status.index}].twohundred" value="${lineVos.twohundred}"></td>
            <td><input class="form-control text-center" type="number" step="0.1" name="lineVos[${status.index}].fourhundred" value="${lineVos.fourhundred}"></td>
            <td width="11%">
              <form:select class="form-control text-center"
                           path="mySelectValues"   name="lineVos[${status.index}].bodysize" >
                <form:option value="${lineVos.bodysize}">${lineVos.bodysize}</form:option>
                <form:options items="${mySelectValues}"/>
              </form:select>
            </td>
            <input type="hidden"  name="lineVos[${status.index}].playerid" value="${lineVos.playerid}">
            <input type="hidden"  name="lineVos[${status.index}].lineid" value="${lineVos.lineid}">
          </tr>
        </c:forEach>
        </tbody>
      </table>

    </section>
    <a href="/evaluation/phyplayermain" class="btn btn-default" style="width: 110px">목록</a>
    <input type="submit" value="변경" class="btn btn-default" style="width: 110px">
    <a href="/evaluation/delete?headerid=${headerVo.headerid}" class="btn btn-default" style="width: 110px">삭제</a>
  </form>
</article>


<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
