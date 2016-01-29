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

      $('#exclass').change(function() {
        var teamid='${teamid}';
        var exclass = $('#exclass').val();
          $.ajax({
            url: "/ajax/evalplayer",
            type: "get",
            data: {
              "teamid" : teamid,
              "exclass": exclass
            },
            success: function (data) {
              if (!data) {
                alert("데이터를 불러오는 도중 에러가 발생했습니다");
                return false;
              }

              if(data.length==0){
                alert("선택하신 클래스의 등록선수가 존재하지 않습니다");
                $('#myTable > tbody > tr').remove();
                $('#myTable > tbody:last').append('<tr id="tabletr">' +
                        '<td colspan="12" style="text-align: center" class="warning">선택하신 클래스에 등록된 선수가 존재하지 않습니다</td>'+
                        '</tr>');
              }else{

                $('#myTable > tbody > tr').remove();
                for(var i= 0, l = data.length; i < l; i++) {
                  $('#myTable > tbody:last').append('<tr id="tabletr">' +
      '<td width="18%"><select class="form-control" id="playerid[]"  name="evalvos[' + i + '].playerid"></select></td>' +
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].pass" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].shooting" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].kick" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].dribble" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].controll" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].game" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].tactics" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].creativity" min="0" max="10" step="1" value=0 ></td>'+
      '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].leadings" min="0" max="10" step="1" value=0 ></td>'+
      '<td><button class="btn btn-sm btn-danger"  onclick="deleteRow(this)">삭제</button></td>'+
      '</tr>');
                  $("select[id='playerid[]'").eq(i).append("<option value=" + data[i].playerid + " seleted>" + data[i].playername + "</option>");
                }

              }

            }
          }); //ajax end
      }); //change event

      $('#plus').click(function(){

        var teamid='${teamid}';
        var exclass = "O";

        var i = $('#myTable tr').length-1;

        $('#myTable > tbody:last').append('<tr id="tabletr">' +
                '<td width="18%"><select class="form-control" id="playerid[]"  name="evalvos[' + i + '].playerid"></select></td>' +
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].pass" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].shooting" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].kick" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].dribble" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].controll" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].game" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].tactics" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].creativity" min="0" max="10" step="1" value=0 ></td>'+
                '<td width="8%"><input class="form-control" type="number" class="input" name="evalvos[' + i + '].leadings" min="0" max="10" step="1" value=0 ></td>'+
                '<td><button class="btn btn-sm btn-danger"  onclick="deleteRow(this)">삭제</button></td>'+
                '</tr>');


        //선택할 선수를 추가해준다.
        $.ajax({
          url: "/ajax/evalplayer",
          type: "get",
          data: {
            "teamid" : teamid,
            "exclass": exclass
          },
          success : function(data){
            if(!data){
              return false;
            }
            var select =$("select[id='playerid[]'").size();
            var selectops = data;
            for(var i = 0, l = selectops.length; i < l; i++){
              var selectop = selectops[i];
              $("select[id='playerid[]'").eq(select-1).append("<option value="+selectop.playerid+">"+selectop.playername+"</option>");
            }

          }
        });
      });

      //insert to db


      $('#frm').submit(function() {
        var playerArray =[];
        var playerCount =$("select[id='playerid[]'").size();

        for(var i=0; i < playerCount; i++){
          var value = $("select[id='playerid[]'").eq(i).val();
          playerArray[i]=value;
        }
        var cnt=0;
        for(var i=0; i < playerCount; i++){
          var value = $("select[id='playerid[]'").eq(i).val();
          cnt=0;

          for(var j=0; j < playerCount ; j++){
            if(value==playerArray[j]){
              cnt++;


              if(cnt==2){
                $("select[id='playerid[]'").eq(i).parent().parent('tr').attr('class','danger');
                alert("같은 이름의 선수를 두개 입력했어요.");
                return false;
              }
            }
          }

        }
      });
      <!--------------------------  End -------------------------->
    });

    function deleteRow(obj){
      var tr = $(obj).parent().parent();
      var th =  $('#myTable > tbody > tr').eq(tr.index());
      tr.remove();
      th.remove();
    }

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

  <div id="valid"></div>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 평가 자료가 정상적으로 삭제 되었습니다.
    </div>
  </c:if>

  <form:form  cssClass="form-horizontal" action="/dbwork/evalinsert" method="post" id="frm" name="frm" modelAttribute="playerList">
    <section class="highlight_white">

      <div class="form-group">
        <label for="exclass" class="col-md-2 control-label">선수구성레벨</label>
        <div class="col-md-3">
          <select  class="form-control" id="exclass" name="exclass">
            <option value="O">전체</option>
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>

        <label for="date" class="col-md-2 control-label">실행일자</label>
        <div class="col-md-3">
          <input type="text" class="form-control" id="date" name="date" required>
          <script>
            $('#date').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>

      </div>


      <div class="form-group">
        <label for="subject" class="col-md-2 control-label">제목</label>
        <div class="col-md-6">
          <input type="text" class="form-control" id="subject" name="subject" required>
        </div>
      </div>

      <div class="form-group">
        <label for="location" class="col-md-2 control-label">장소</label>
        <div class="col-md-6">
          <input type="text" class="form-control" id="location" name="location" required>
        </div>
      </div>

      <div class="form-group">
        <label for="performer" class="col-md-2 control-label">주관자</label>
        <div class="col-md-3">
          <input type="text" class="form-control" id="performer" name="performer" required>
        </div>

        <label class="col-md-2 control-label">날씨</label>
        <div class="col-md-3">
          <select name="weather" class="form-control">
            <option value="맑음">맑음</option>
            <option value="흐림">흐림</option>
            <option value="비">비</option>
            <option value="눈">눈</option>
          </select>
        </div>

      </div>

      <div class="form-group">
        <label for="evalrason" class="col-md-2 control-label">평가기준/방식</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="evalrason" id="evalrason"></textarea>
        </div>
      </div>
      <div class="form-group">
        <label for="description" class="col-md-2 control-label">기타/비고</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="3" name="description" id="description"></textarea>
        </div>
      </div>

    </section>

    <section class="highlight_white">
      <div class="row" id="addrow">
        <div class="col-md-2">
          <button type="button" class="btn btn-default btn-sm" aria-label="Left Align"  id="plus">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
          </button>
        </div>
        <div class="col-md-10"></div>
      </div>

      <table class="table table-striped" id="myTable">
        <thead>
        <tr>
          <th>선수이름</th>
          <th>패스</th>
          <th>슈팅</th>
          <th>킥</th>
          <th>드리블</th>
          <th>컨트롤</th>
          <th>게임</th>
          <th>전술</th>
          <th>창의성</th>
          <th>리딩</th>
          <th></th>
        </tr>
        </thead>
        <tbody>
          <c:forEach items="${playerList.evalvos}" var="evalvos" varStatus="status">
          <tr>
            <td width="18%"><select class="form-control" id="playerid[]" name="evalvos[${status.index}].playerid"><option value="${evalvos.playerid}">${evalvos.playername}</option></select></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].pass" min="0" max="10" step="1" value="${evalvos.pass}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].shooting" min="0" max="10" step="1" value="${evalvos.shooting}"></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].kick" min="0" max="10" step="1" value="${evalvos.kick}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].dribble" min="0" max="10" step="1" value="${evalvos.dribble}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].controll" min="0" max="10" step="1" value="${evalvos.controll}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].game" min="0" max="10" step="1" value="${evalvos.game}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].tactics" min="0" max="10" step="1" value="${evalvos.tactics}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].creativity" min="0" max="10" step="1" value="${evalvos.creativity}" ></td>
            <td width="8%"><input class="form-control" type="number" class="input" name="evalvos[${status.index}].leadings" min="0" max="10" step="1" value="${evalvos.leadings}" ></td>
            <td><button class="btn btn-sm btn-danger"  onclick="deleteRow(this)">삭제</button></td>
          </tr>
        </c:forEach>
        </tbody>

      </table>
    </section>

    <input type="hidden" value="${teamid}" name="teamid" id="teamid">
    <input type="submit" value="등록" class="btn btn-default" style="width: 110px">
    <input type="reset" value="지우기" class="btn btn-default" style="width: 110px;">
  </form:form>
</article>



<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
