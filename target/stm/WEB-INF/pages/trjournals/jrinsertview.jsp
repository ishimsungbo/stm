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
                      '<td class="col-md-1"><input class="form-control col-md-1" value="10" min="0" max="10" name="trJrPlayerVos['+rowCurrentrowNum+'].satisfaction" type="number"></td>' +
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
        value: 10,
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
                '<td class="col-md-1"><input class="form-control text-center" value="0" min="0" max="200" name="timelineVos['+rowCurrentrowNum+'].trminute" type="number"></td>' +
                '<td class="col-md-1"><input class="form-control text-center" value="0" min="0" max="10" name="timelineVos['+rowCurrentrowNum+'].satisfaction" type="number"></td>' +
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

      //폼 서브밋..
      $('#submit').click(function(){
        if($("#exdate").val()==""){
          $("#exdate").focus();
          alert("훈련일자는 필수 입니다. 입력해주세요");
          return false;
        }
      });


    });

      function rowMinus() {
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

  <form method="post" action="/trjournals/insert"  name="frm" class="form-horizontal" >

    <section class="highlight_white">
      <fieldset>
        <legend>훈련일지 기본정보</legend>
        <div class="form-group">
          <label for="performer" class="col-md-2 control-label">주관자</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="performer" name="performer" placeholder="코치/감독/선생님/직함 등등" required>
          </div>
        </div>

        <div class="form-group" style="margin-bottom: auto">
          <label for="date" class="col-md-2 control-label">일자</label>
          <div class="col-md-4">
            <div class="input-group date form_datetime"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="date">
              <input class="form-control" size="16" type="text" id="exdate" value="">
              <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
              <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
            </div>
            <input type="hidden" id="date" name="date" /><br/>
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
          <label for="location" class="col-md-2 control-label">장소</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="location" name="location" required>
          </div>

          <label class="col-md-2 control-label">날씨</label>
          <div class="col-md-4">
            <select name="weather" class="form-control" id ="weather" required>
              <option value="맑음">맑음</option>
              <option value="흐림">흐림</option>
              <option value="비">비</option>
              <option value="눈">눈</option>
            </select>
          </div>

        </div>

        <div class="form-group">
          <label for="concept" class="col-md-2 control-label">훈련주제</label>
          <div class="col-md-10">
            <input type="text" class="form-control" id="concept" name="concept" placeholder="오늘 훈련의 목표 및 컨셉" required>
          </div>
        </div>

        <div class="form-group">
          <label for="good" class="col-md-2 control-label">만족한 부분</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="3" name="good" id="good"></textarea>
          </div>

          <label for="insufficiency" class="col-md-2 control-label">부족한 부분</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="3" name="insufficiency" id="insufficiency"></textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="conceptobject" class="col-md-2 control-label">설명</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="conceptobject" id="conceptobject" placeholder="훈련 종합 설명"></textarea>
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">일일훈련 평가점수</label>
          <div class="col-md-5">
            <div id="slider01" style="width: 350px; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input type="number" class="form-control text-center" id="satisfaction" name="satisfaction" step="1" min="0" max="10" value="10" required>
          </div>
          <div class="col-md-3"></div>

        </div>
      </fieldset>
    </section>

    <section class="highlight_white">
      <fieldset>
        <legend>훈련타임라인 [훈련순서]</legend>

        <div class="row">
          <div class="col-md-2">
            <button type="button" class="btn btn-default btn-sm" aria-label="Left Align"  id="plus">
              <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            </button>
            <button type="button" class="btn btn-default btn-sm" aria-label="Left Align" onclick="rowMinus()">
              <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
            </button>
          </div>
          <div class="col-md-10"></div>
        </div>


        <table class="table table-hover" id="myTable" style="margin-top: 20px">
          <thead>
          <tr>
            <th>순서</th>
            <th>훈련프로그램</th>
            <th>훈련시간(분)</th>
            <th>평가점수</th>
            <th>특이사항</th>
          </tr>
          </thead>
          <c:forEach var="i" begin="0" end="4" step="1">
            <tr>
              <td class="col-md-1"><input class="form-control col-md-1" id="linenum[]"  name="timelineVos['${i}'].linenum" type="number" value="${i+1}"></td>
              <td class="col-md-4"><select class="form-control" id="trainingid[]" name="timelineVos['${i}'].trainingid" ><option value="0">없음</option></select></td>
              <td class="col-md-1"><input class="form-control text-center" value="0" min="0" max="200" name="timelineVos['${i}'].trminute" type="number"></td>
              <td class="col-md-1"><input class="form-control text-center" value="10" min="0" max="10" step="1" name="timelineVos['${i}'].satisfaction" type="number"></td>
              <td class="col-md-5"><textarea class="form-control col-md-1" rows="1" name="timelineVos['${i}'].description"></textarea></td>

              <script>

                var options = JSON.parse('${trprogram}');
                var i = '${i}';
                var rownum = i;
                for(var i = 0, l = options.length; i < l; i++){
                  var option = options[i];
                  $("select[id='trainingid[]'").eq(rownum).append("<option value="+option.trainingid+">"+option.trname+"</option>");
                }

              </script>
            </tr>
          </c:forEach>
          <tbody>
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
            <th>참석여부</th>
            <th>훈련점수</th>
            <th>메모</th>
            <th>부상여부</th>
          </tr>
          </thead>
          <!-- db data view -->
          <tbody>
          <c:forEach items="${playerlist.trJrPlayerVos}" var="trJrPlayerVos" varStatus="status">
            <tr>
              <td class="col-md-1">${trJrPlayerVos.playername}</td>
              <td class="col-md-1">
                <select class="form-control" name="trJrPlayerVos[${status.index}].status">
                  <option value="Y" selected>Y</option>
                  <option value="N">N</option>
                </select>
              </td>
              <td class="col-md-1">
                <input type="number" class="form-control text-center" name="trJrPlayerVos[${status.index}].satisfaction" min="0" max="10" step="1" value="10">
              </td>
              <td class="col-md-8"><textarea type="text" rows="1" class="form-control" name="trJrPlayerVos[${status.index}].description"></textarea></td>
              <td class="col-md-1">
                <select class="form-control" name="trJrPlayerVos[${status.index}].injury">
                  <option value="Y">Y</option>
                  <option value="N" selected>N</option>
                </select>
                <input type="hidden" name="trJrPlayerVos[${status.index}].playerid" value="${trJrPlayerVos.playerid}">
              </td>
            </tr>


          </c:forEach>
          </tbody>
        </table>

      </fieldset>
    </section>

    <input type="submit" id="submit" class="btn btn-default" value="등록" style="width: 110px"/>
    <input type="reset"  value="지우기" class="btn btn-default" style="width: 110px">
  </form>


</article>

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
