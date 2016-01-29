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

      var teamid='${teamid}';
      var exclass;

      $('#exclass').change(function(){

        $('#myTable > tbody > tr').remove();

        var exclass=$('#exclass').val();

        $.ajax({
          url: "/ajax/getteamplayers",
          type: "get",
          data: {
            "teamid" : teamid,
            "exclass": exclass
          },
          success: function (data) {
            if (!data) {
              alert("데이터를 불러오는 도중 에러가 발생했습니다.");
              $('#alertTag').append('<tr><td colspan="10" style="text-align: center" class="warning">서버에서 문제가 있습니다. 관리자에게 문의해주세요</td></tr>');
              return false;
            }

            if(data.length==0){
              alert("등록된 선수 데이터가 없습니다.");
              $('#myTable > tbody:last').append('<tr><td colspan="10" style="text-align: center" class="warning">해당클래스에 등록된 선수가 존재하지 않습니다</td></tr>');
            }else{

              $('#tabletr').remove();

              for(var i= 0, l = data.length; i < l; i++) {
                $('#myTable > tbody:last').append('<tr id="tabletr">' +
                        '<td><input class="form-control" type="text" value="'+data[i].playername+'" name="lineVos[' + i + '].playername"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" step="0.1" max="250" value="0"  name="lineVos[' + i + '].height"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" step="0.1" max="250" value="0" name="lineVos[' + i + '].weight"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" max="250" value="0" name="lineVos[' + i + '].bodyfat"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" max="300" value="0" name="lineVos[' + i + '].footsize"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" step="0.1" max="20" value="0" name="lineVos[' + i + '].fifty"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" step="0.1" max="30" value="0" name="lineVos[' + i + '].onehundred"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" step="0.1" max="100" value="0" name="lineVos[' + i + '].twohundred"></td>' +
                        '<td><input class="form-control text-center" type="number" min="0" step="0.1" max="200" value="0" name="lineVos[' + i + '].fourhudred"></td>' +
                        '<td width="10.5%"><select class="form-control text-center" name="lineVos['+i+'].bodysize"> ' +
                        '<option value="S">S</option> ' +
                        '<option value="M">M</option>' +
                        '<option value="L">L</option>' +
                        '<option value="XL">XL</option>' +
                        '<option value="XXL">XXL</option>' +
                        '<option value="XXXL">XXXL</option>' +
                        '</select></td>' +
                        '<input type=hidden value="'+data[i].playerid+'" name="lineVos[' + i + '].playerid">' +
                        '</tr>'
                );
              }
            }

          }
        }); //ajax end

      }); //exclass.change.function end



    });
  </script>

</head>


<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>선수신체정보 입력</h3>
  </section>

  <div id="alertTag"></div>

  <form  class="form-horizontal" action="phycreate" method="post" id="frm" name="frm">

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
          <input type="text" class="form-control" id="extdate" name="extdate" required>
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
          <input type="text" class="form-control" id="performer" name="performer" required>
        </div>
      </div>

      <div class="form-group">
        <label for="description" class="col-md-2 control-label">설명/기타</label>
        <div class="col-md-5">
          <textarea class="form-control" rows="1" name="description" id="description"></textarea>
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
        </tbody>
      </table>

    </section>
    <%--evaluation/phyplayermain--%>
    <a class="btn btn-default" href="phyplayermain" style="width: 110px">목록</a>
    <input type="submit" value="등록" class="btn btn-default" style="width: 110px">
    <input type="reset" value="지우기" class="btn btn-default" style="width: 110px;">
  </form>
</article>



<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
