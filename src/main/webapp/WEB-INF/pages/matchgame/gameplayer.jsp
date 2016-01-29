<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 대회경기</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap_line.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script>
    $(document).ready(function() {

      var allplayers;

      var playercount = "${playercount}";
      var teamid = "${teamid}";
      var gameid = 0;
      var cgamid ="${gameid}";

      if(playercount==0){

        var data = JSON.parse('${playerGameVos}');


        console.log(data);

        for(var i= 0, l = data.length; i < l; i++) {
          var row = i + 1;
          $('#myTable > tbody:last').append('<tr">' +
                  '<td width="10.5%"><select class="form-control" id="playerid[]"  name="playerGameVos[' + i + '].playerid">' +
                  '</select></td>' +
                  '<td width="9%"><select class="form-control" id="positioncode[]" name="playerGameVos[' + i + '].positioncode">' +
                  '<option value=' + data[i].positioncode + ' selected>' + data[i].positioncode + '</option>' +
                  '</select></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].offensive" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].defensive" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].pass" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].controll" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].tactics" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].strength" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos[' + i + '].creativity" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].goal"  type="number" value="0" min="0" max="15"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].asist" type="number" value="0" min="0" max="15"></td>' +
                  '<td rowspan="2" style="text-align: center; vertical-align: middle"><button class="btn btn-sm btn-danger" onclick="deleteRow(this)">삭제</button></td></tr>' +
                  '<tr>' +
                  '<td colspan="3"><textarea class="form-control" id="good[]" name="playerGameVos[' + i + '].good" placeholder="좋은 플레이 및 발전가능성등"></textarea></td>' +
                  '<td colspan="3"><textarea class="form-control" name="playerGameVos[' + i + '].problem" placeholder="보완점등"></textarea></td>' +
                  '<td colspan="3"><textarea class="form-control" name="playerGameVos[' + i + '].review" placeholder="기타"></textarea></td>' +
                  '<td><input class="form-control text-center" id="" name="playerGameVos[' + i + '].intime" type="number" value="90" min="0" max="120"></td>' +
                  '<td></td>'+
                  '<input type="hidden" name="playerGameVos[' + i + '].gameid" value=' + cgamid + '>' +
                  '</tr>'
          );

          var t = $("select[id='playerid[]'").size();


          $("select[id='playerid[]'").eq(i).append("<option value=" + data[i].playerid + " seleted>" + data[i].playername + "</option>");

          var positionSize = $("select[id='positioncode[]'").size();
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='FW'>FW</option>");
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='MF'>MF</option>");
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='DF'>DF</option>");
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='GK'>GK</option>");

        };
      }else{
        //업데이트 및 삭제 처리
        var upData = JSON.parse('${UpplayerGameVos}');
        //console.log(upData);

        $('#pageflag').attr('value','update');

        for(var i= 0, l = upData.length; i < l; i++) {
          var row = i + 1;
          $('#myTable > tbody:last').append('<tr">' +
                  '<td width="10.5%"><select class="form-control" id="playerid[]"  name="playerGameVos[' + i + '].playerid">' +
                  '</select></td>' +
                  '<td width="9%"><select class="form-control" id="positioncode[]" name="playerGameVos[' + i + '].positioncode">' +
                  '<option value=' + upData[i].positioncode + ' selected>' + upData[i].positioncode + '</option>' +
                  '</select></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].offensive"  value="'+upData[i].offensive+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].defensive"  value="'+upData[i].defensive+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].pass"       value="'+upData[i].pass+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].controll"   value="'+upData[i].controll+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].tactics"    value="'+upData[i].tactics+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].strength"   value="'+upData[i].strength+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].creativity" value="'+upData[i].creativity+'" type="number" value="0" min="0" max="10" step="1"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].goal"       value="'+upData[i].goal+'" type="number" value="0" min="0" max="15"></td>' +
                  '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + i + '].asist"      value="'+upData[i].asist+'" type="number" value="0" min="0" max="15"></td>' +
                  '<td rowspan="2" style="text-align: center; vertical-align: middle"><button class="btn btn-sm btn-danger" id="delete">삭제</button></td></tr>' +
                  '<tr>' +
                  '<td colspan="3"><textarea class="form-control" id="good[]" name="playerGameVos[' + i + '].good" placeholder="좋은 플레이 및 발전가능성등">'+upData[i].good+'</textarea></td>' +
                  '<td colspan="3"><textarea class="form-control" name="playerGameVos[' + i + '].problem" placeholder="보완점등">'+upData[i].problem+'</textarea></td>' +
                  '<td colspan="3"><textarea class="form-control" name="playerGameVos[' + i + '].review" placeholder="기타">'+upData[i].review+'</textarea></td>' +
                  '<td><input class="form-control text-center" id="" name="playerGameVos[' + i + '].intime" type="number" value='+upData[i].intime+' min="0" max="120"></td>' +
                  '<td></td>'+
                  '<input type="hidden" name="playerGameVos[' + i + '].gameid" value=' + upData[i].gameid + '>' +
                  '</tr>'
          );

          var t = $("select[id='playerid[]'").size();

          $("select[id='playerid[]'").eq(i).append("<option value=" + upData[i].playerid + " seleted>"+upData[i].playername+"</option>");

          var positionSize = $("select[id='positioncode[]'").size();
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='FW'>FW</option>");
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='MF'>MF</option>");
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='DF'>DF</option>");
          $("select[id='positioncode[]'").eq(positionSize - 1).append("<option value='GK'>GK</option>");

        };

      };

      //입력이 이미된 자료중 삭제를 클릭할 경우
      $("#myTable").on("click", "#delete", function(event){
        event.preventDefault(); //이것을 안달면  form submit 원래 기능이 살아난다.

        var currentRow = $(this).parent().parent().index();
        var connum = 0;
        var playerid;

        if(currentRow==0){
          playerid = $("select[id='playerid[]'").eq(currentRow).val();
        }else{
          var eq = (currentRow / 2)-1;
          playerid = $("select[id='playerid[]'").eq(eq).val();
        }

        //화면삭제처리
        if(currentRow==0){
          $('#myTable tr').eq(currentRow+3).remove();  //그밑에 로우도 삭제
          $(this).parent().parent().remove();          //삭제하려는 로우
        }else{
          $('#myTable tr').eq(currentRow+1).remove();  //그밑에 로우도 삭제
          $(this).parent().parent().remove();          //삭제하려는 로우
        }




      });


      //추가한 라인 select 선수에 이벤트 달기
      $("#myTable").on("change", "select", function(){

        if($(this).attr('id')=='playerid[]'){
          for(var i=0;i < allplayers.length ;i++){
            if(allplayers[i].playerid == $(this).val()){

              var positionSize = $("select[id='positioncode[]'").size();
              $("select[id='positioncode[]'").eq(positionSize - 1).val(allplayers[i].positioncode).attr("selected", "selected");
            }
          }
        }

      });

      $('#plus').click(function(){

        //alert(1);

        var rowCount = $('#myTable tr').length;
        var conditionnum=0;

        var eq = (rowCount / 2)-1;
        //alert(eq);
        //1. 형식에 맞추어 열을 추가해준다.
        $('#myTable > tbody:last').append('<tr>' +
                '<td width="10.5%"><select class="form-control" id="playerid[]"  name="playerGameVos['+eq+'].playerid"><option vlaue="">-</option></select></td>' +
                '<td width="9%"><select class="form-control" id="positioncode[]"  name="playerGameVos['+eq+'].positioncode"><option vlaue="">-</option></select></td>' +
                '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].offensive" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].defensive" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].pass" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].controll" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].tactics" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].strength" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"><input class="form-control text-center" id="" name="playerGameVos['+eq+'].creativity" type="number" value="0" min="0" max="10" step="1"></td>' +
                '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + eq + '].goal" type="number" value="0" min="0" max="15"></td>' +
                '<td width="9%"><input class="form-control text-center"  name="playerGameVos[' + eq + '].asist"type="number" value="0" min="0" max="15"></td>' +
                '<td rowspan="2" style="text-align: center; vertical-align: middle"><button class="btn btn-sm btn-danger"  onclick="deleteRow(this)">삭제</button></td>' +
                '</tr><tr>'+
                '<td colspan="3"><textarea class="form-control" id="good[]" name="playerGameVos['+eq+'].good" placeholder="좋은 플레이 및 발전가능성등"></textarea></td>' +
                '<td colspan="3"><textarea class="form-control"  name="playerGameVos['+eq+'].problem" placeholder="보완점등"></textarea></td>' +
                '<td colspan="3"><textarea class="form-control" name="playerGameVos['+eq+'].review" placeholder="기타"></textarea></td>' +
                '<td><input class="form-control" id="" name="playerGameVos['+eq+'].intime" type="number" value="90" min="0" max="120"></td>' +
                '<td></td>'+
                '<input type="hidden" name="playerGameVos['+eq+'].gameid" value='+cgamid+'>'+
                '</tr>'
        );

        $.ajax({
          url : "/ajax/getPlayerList",
          type: "get",
          data : { "teamid" : teamid },
          success : function(data){
            $("#ajax").remove();
            if(!data){
              alert("등록된 연습경기 데이터가 없습니다.");
              return false;
            }
            allplayers = data;
            //select 옵션의 총 숫자를 파악 한다.
            var select =$("select[id='playerid[]'").size();

            //2.서버에서 팀의 선수정보를 들고온다.
            var selectops = data;
            for(var i = 0, l = selectops.length; i < l; i++){
              var selectop = selectops[i];
              //총 select 숫자에서 1를 빼서 코드를 넣어준다
              $("select[id='playerid[]'").eq(select-1).append("<option value="+selectop.playerid+">"+selectop.playername+"</option>");
            }
            var positionSize =$("select[id='positioncode[]'").size();
            $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='FW'>FW</option>");
            $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='MF'>MF</option>");
            $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='DF'>DF</option>");
            $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='GK'>GK</option>");

          }
        });
      });


      function itemhide(){
        $('#plus').hide();
      }

      function itemshow(){
        $('#plus').show();
      }


      $('#frm').submit(function() {
        // 1.선수를 모두 선택했는지 검사
        var plCount=0;
        var playerCount =$("select[id='playerid[]'").size();

        //입력한내용이 하나도 없다면...
        if(playerCount==0){
          valid('작성하신 개인 기록내용이 존재하지 않습니다.');
          return false;
        };

        var playerArray =[];

        for(var i=0; i < playerCount; i++){
          var value = $("select[id='playerid[]'").eq(i).val();

          playerArray[i]=value;

          if(value=='-'){
            $("select[id='playerid[]'").eq(i).parent().parent('tr').attr('class','danger');
            $("textarea[id='good[]'").eq(i).parent().parent('tr').attr('class','danger');
            plCount = plCount+1;
          }
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
                $("textarea[id='good[]'").eq(i).parent().parent('tr').attr('class','danger');
                valid("동일한 선수 기록을 두개 이상 입력하셨습니다. 하나만 입력해주세요");
                return false;
              }
            }
          }
        }

        if(plCount > 0){
          alert('선수이름을 선택해주세요');
          valid('선수이름을 선택해주세요');
          $('#alertval').show();
          return false;
        }

        // 2.포지션 값 null 체크
        var posiitonCount=0;
        var codeCount =$("select[id='positioncode[]'").size();

        for(var i=0; i < codeCount; i++){
          var value = $("select[id='positioncode[]'").eq(i).val();
          if(value=='-'){
            $("select[id='positioncode[]'").eq(i).parent().parent('tr').attr('class','danger');
            $("textarea[id='good[]'").eq(i).parent().parent('tr').attr('class','danger');
            posiitonCount = posiitonCount+1;
          }
        }

        if(posiitonCount > 0){
          alert('선수 포지션을 선택해주세요');
          valid('선수 포지션을 선택해주세요');
          return false;
        }
      });


      function valid(errorMessage){
        $('#valid').append(
                '<div class="alert alert-danger" role="alert" id="alertval">'+
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close" id="closebtn"><span aria-hidden="true">&times;</span></button>'+
                '<strong>[필수값]</strong>"'+errorMessage+'"'+
                '</div>');
      }


      $('#valid').click(function(){
        $("select[id='positioncode[]'").parent().parent('tr').attr('class','');
        $("textarea[id='good[]'").parent().parent('tr').attr('class','');
      });

    });

    //테이블에서 삭제할 로우를 선택해서 삭제를 한다.
    //tr 인덱스번호를 알아온 후 후에 그 밑에 한로우로 셋팅된 textarea도 삭제한다.
    function deleteRow(obj){
      var tr = $(obj).parent().parent();
      var tx =  $('#myTable > tbody > tr').eq(tr.index()+1);
      var th =  $('#myTable > tbody > tr').eq(tr.index());

      tr.remove();
      tx.remove();
      th.remove();


    }
  </script>

</head>

<body class="stmbody" style="width: 1100px">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>
  <section class="page-subject">
    <h3>개인 경기 기록입력</h3>
  </section>

  <form method="post" action="/matchgame/playerinsert" id="frm" name="frm" class="form-horizontal">

    <div id="valid"></div>

    <section class="highlight_white">

      <div class="row" id="addrow">
        <div class="col-md-2">
          <button type="button" class="btn btn-default btn-sm" aria-label="Left Align"  id="plus">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
          </button>
        </div>
        <div class="col-md-10"></div>
      </div>

      <table class="table table-condensed" id="myTable" style="margin-top: 20px">
        <thead>
        <tr>
          <th>선수이름</th>
          <th>포지션</th>
          <th>공격</th>
          <th>수비</th>
          <th>패스</th>
          <th>컨트롤</th>
          <th>전술</th>
          <th>체력</th>
          <th>창의성</th>
          <th>골</th>
          <th>도움</th>
          <th></th>
        </tr>
        <tr>
          <th colspan="3">Good Play(좋은 점)</th>
          <th colspan="3">Defect Play(부족한 점)</th>
          <th colspan="3">기타/비고</th>
          <th>출전시간</th>
          <th></th>
          <th></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </section>
    <input id="pageflag" name="pageflag" type="hidden" value="insert"/>
    <a href="/matchgame/matchgame" class="btn btn-default" style="width: 110px;">경기목록</a>
    <input id="submit" type="submit" class="btn btn-default" value="저장" style="width: 110px"/>
  </form>

</article>

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
