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
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js" charset="UTF-8"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js" charset="UTF-8"></script>


  <script type="text/javascript" src="/resources/jqueryextend/jquery-ui-1.10.3.custom.js" charset="UTF-8"></script>
  <link rel="stylesheet" type="text/css" href="/resources/jqueryextend/jquery-ui.css">

  <%--datetimepicker--%>
  <link rel="stylesheet" href="/resources/datetimepicker/css/bootstrap-datetimepicker.min.css">
  <script type="text/javascript" src="/resources/datetimepicker/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
  <script type="text/javascript" src="/resources/datetimepicker/js/locales/bootstrap-datetimepicker.ko.js" charset="UTF-8"></script>



  <script>

    $(document).ready(function() {

      function getplayerInfo(exclass,teamid){
        $.ajax({
          url : "/ajax/getteamplayers",
          type: "get",
          data : { "exclass" : exclass,
            "teamid" : teamid
          },
          success : function(data){
            $("#ajax").remove();

            if(!data){
              alert("존재하지 않는 ID입니다");
              return false;
            }
            for(var i in data){
              //  alert(data[i].playername); 훈련참여 선수를 변경
              var rowCurrentrowNum = i;

              $('#playertable > tbody:last').append('<tr>' +
                      '<td class="col-md-1">'+data[i].playername+'</td>' +
                      '<td class="col-md-1"><select class="form-control" id="status[]" name="trJrPlayerVos['+rowCurrentrowNum+'].status">' +
                      '<option value="Y" selected>Y</option>'+
                      '<option value="N">N</option>'+
                      '</select></td>' +
                      '<td class="col-md-1"><input class="form-control col-md-1" value="5" min="0" max="10" name="trJrPlayerVos['+rowCurrentrowNum+'].satisfaction" type="number"></td>' +
                      '<td class="col-md-8"><input class="form-control col-md-1"  name="trJrPlayerVos['+rowCurrentrowNum+'].description" type="text"></td>' +
                      '<td class="col-md-1"><select class="form-control" id="injury[]" name="trJrPlayerVos['+rowCurrentrowNum+'].injury">' +
                      '<option value="Y">Y</option>'+
                      '<option value="N" selected>N</option>'+
                      '</select></td>' +
                      '<input class="form-control col-md-1"  name="trJrPlayerVos['+rowCurrentrowNum+'].playerid" type="hidden" value='+data[i].playerid+'>'+
                      '</tr>');

            }
          }
        });
      }


      $('#exclass').change(function(){
        var exclass = $('#exclass option:selected').val();
        $('#playertable > tbody:last > tr').remove(); //화면에 존재하는 선수들 정보를 지워준다.
        getplayerInfo(exclass,'${teamid}');  //다시 클래스에 맞는 선수들을 불러온다
      });


      $("#slider01").slider({
        range: "min",
        min: 0,
        max: 10,
        value: ${trJrdata.satisfaction},
        slide: function (event, ui) {
          $("#satisfaction").val(ui.value)
        }
      });

      $("#satisfaction").val($("#slider01").slider("value"));


      $('#plus').click(function(){
        var rowCount = $('#myTable tr').length;

        var rowCurrentrowNum = rowCount - 1;
        $('#myTable > tbody:last').append('<tr>' +
                '<td class="col-md-1"><input class="form-control col-md-1" id="linenum[]" name="timelineVos['+rowCurrentrowNum+'].linenum" type="number" value="'+rowCurrentrowNum+'"></td>' +
                '<td class="col-md-4"><select class="form-control" id="trainingid[]" name="timelineVos['+rowCurrentrowNum+'].trainingid" ><option value="0">없음</option></select></td>' +
                '<td class="col-md-1"><input class="form-control col-md-1" value="0" min="0" max="200" name="timelineVos['+rowCurrentrowNum+'].trminute" type="number"></td>' +
                '<td class="col-md-1"><input class="form-control col-md-1" value="0" min="0" max="10" name="timelineVos['+rowCurrentrowNum+'].satisfaction" type="number"></td>' +
                '<td class="col-md-5"><textarea class="form-control col-md-1" rows="1" name="timelineVos['+rowCurrentrowNum+'].description"></textarea></td>' +
                '</tr>');

        var options = JSON.parse('${trprogram}');

        $("input[id='linenum[]'").eq(rowCurrentrowNum).val(rowCount);

        for(var i = 0, l = options.length; i < l; i++){
          var option = options[i];
          $("select[id='trainingid[]'").eq(rowCurrentrowNum).append("<option value="+option.trainingid+">"+option.trname+"</option>");
        }

      });

      $('#test').click(function(){
        alert('값을 조사합니다.');
        alert( $('#status').val()

        );
      });

    });

    function rowMinus()
    {
      var table = document.getElementById("myTable");
      var rowCount = table.rows.length;
      var rowCurrentrowNum = rowCount-2;

      if(rowCurrentrowNum == -1){
        return;
      }

      document.getElementById("myTable").deleteRow(-1).innerHTML =
              '<tr>'+
              '<td><select name="linenum"><select></td>'+
              '<td><select name="trainingid"><select></td>'+
              '<td><select name="trminute"><select></td>'+
              '<td><select name="satisfaction"><select><td>'+
              '<td><select name="description"><select><td>'+
              '</tr>';
    };
  </script>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>훈련일지 입력</h3>
  </section>

  <form method="post" action="/trjournals/update"  name="frm" class="form-horizontal" >
    <section class="highlight_white">


      <fieldset>
        <legend>훈련일지 기본정보</legend>
        <div class="form-group">
          <label for="date" class="col-md-2 control-label">일자</label>
          <div class="col-md-4">
            <div class="input-group date form_datetime"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="date">
              <input class="form-control" size="16" type="text" value="${trJrdata.formattrdate}" readonly>
              <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
              <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
            </div>
            <input type="hidden" id="date" name="date" value="${trJrdata.formattrdate}" /><br/>
            <script>
              $('.form_datetime').datetimepicker({
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

          <label for="exclass" class="col-md-2 control-label">선수레벨</label>
          <div class="col-md-4">
            <select  class="form-control" id="exclass" name="exclass" required>
              <option value="O" selected>전체대상</option>
              <option value="A">Class A</option>
              <option value="B">Class B</option>
              <option value="C">Class C</option>
              <option value="D">Class D</option>
            </select>
          </div>

        </div>

        <div class="form-group">
          <label for="performer" class="col-md-2 control-label">주관자</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="performer" name="performer" value="${trJrdata.performer}" required>
          </div>

          <label for="location" class="col-md-2 control-label">장소</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="location" name="location" value="${trJrdata.location}" required>
          </div>
        </div>

        <div class="form-group">
          <label for="concept" class="col-md-2 control-label">훈련주제</label>
          <div class="col-md-10">
            <input type="text" class="form-control" id="concept" name="concept" value="${trJrdata.concept}" placeholder="오늘 훈련의 목표 및 컨셉" required>
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label for="good" class="col-md-2 control-label">만족한 부분</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="3" name="good" id="good" >${trJrdata.good}</textarea>
          </div>

          <label for="insufficiency" class="col-md-2 control-label">부족한 부분</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="3" name="insufficiency" id="insufficiency" >${trJrdata.insufficiency}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="conceptobject" class="col-md-2 control-label">설명</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="conceptobject" id="conceptobject"  placeholder="훈련 종합 설명">${trJrdata.conceptobject}</textarea>
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">일일훈련 평가점수</label>
          <div class="col-md-5">
            <div id="slider01" style="width: 350px; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input type="number" class="form-control" id="satisfaction" name="satisfaction" style="width: 80px" min="0" max="10" step="1" value="${trJrdata.satisfaction}" required>
          </div>
          <div class="col-md-3"></div>

        </div>
      </fieldset>
      <input type="hidden" name="jeid" value="${trJrdata.jeid}">
    </section>

    <section class="highlight_white">
      <fieldset>
        <legend>훈련타임라인 [훈련순서]</legend>
        <table class="table table-hover" id="myTable">
          <thead>
          <tr>
            <th>순서</th>
            <th class="text-center">훈련프로그램명</th>
            <th class="text-center">훈련시간(분)</th>
            <th class="text-center">평가점수</th>
            <th>특이사항</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${line}" var="list">
            <tr>
              <td>${list.linenum}</td>
              <td class="text-center">${list.trname}</td>
              <td class="text-center">${list.trminute}</td>
              <td class="text-center">${list.satisfaction}</td>
              <td>${list.description}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </fieldset>
    </section>

    <section class="highlight_white">
      <fieldset>
        <legend>훈련 참여인원</legend>
        <table class="table table-hover" id="playertable">
          <thead>
          <tr>
            <th>이름</th>
            <th class="text-center">참석여부</th>
            <th class="text-center">훈련점수</th>
            <th class="text-center">부상여부</th>
            <th class="text-center">메모</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${playerlist}" var="plist">
            <tr>
              <td>${plist.playername}</td>
              <td class="text-center">${plist.status}</td>
              <td class="text-center">${plist.satisfaction}</td>
              <td class="text-center">${plist.injury}</td>
              <td class="text-center">${plist.description}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>

      </fieldset>
    </section>



    <a href="/trjournals/trjournalmain" class="btn btn-default" style="width: 110px">훈련일지목록</a>
    <input type="submit" class="btn btn-default" value="변경" style="width: 110px"/>
    <a href="/trjournals/delete?jeid=${trJrdata.jeid}" class="btn btn-default" style="width: 110px">삭제</a>
  </form>


</article>


<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
