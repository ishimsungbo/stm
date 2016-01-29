<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 연습경기</title>
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

      itemhide();

      var teamid = "${teamid}";
      var exgameid = 0;
      var gameid   = 0;
      var cexgamid = 0;
      var exclass;

      $('#radio').change(function () {
        //alert('1 : ' +$(':radio[name="scheduleflag"]:checked').val() );

        //대회를 선택하느냐, 경기를 선택하느냐에 따라 서버에서 경기리스트를 가져온다
        if($(':radio[name="scheduleflag"]:checked').val() == 'exgame')
        {
          //alert('연습경기 리스트를 가져옵니다. : '+exgameid);
          $.ajax({
            url : "/ajax/getExgamelist",
            type: "get",
            data : { "teamid" : teamid },
            success : function(data){
              $("#ajax").remove();
              if(!data){
                alert("등록된 연습경기 데이터가 없습니다.");
                return false;
              }
              // 1.input id 변경해준다
              $('#templabel').attr('for','exgameid');
              $('#tempid').attr('id','exgameid');
              $('#exgameid').attr('name','exgameid');

              // 2.연습경기를 선택할 수 있도록 select 에 붙인다.
              var options = data;

              for(var i = 0, l = options.length; i < l; i++){
                var option = options[i];
                $("#exgameid").append("<option value="+option.exclass+option.exgameid+">"+option.exgamename+"</option>");
              }
            }
          }); //ajax end
        }else{
          alert('경기 리스트를 가져옵니다. : '+gameid);
        };

      });

      $('#tempid').change(function () {

        itemshow();

        $('#myTable > tbody:last > tr').remove();

        exgameid = $('#exgameid').val();
        exclass = exgameid.substr(0,1); //문자 잘르기
        cexgamid = exgameid.substr(1,10);

        if(exclass == 'A'){
          $('#exclassdisp').val('Class A');
        }else if(exclass == 'B'){
          $('#exclassdisp').val('Class B');
        }else if(exclass == 'C'){
          $('#exclassdisp').val('Class C');
        }else if(exclass == 'D'){
          $('#exclassdisp').val('Class D');
        }

        $.ajax({
          url : "/ajax/getPlayerList",
          type: "get",
          data : { "cexgamid" : cexgamid },
          success : function(data){
            $("#ajax").remove();
            if(!data){
              alert("등록된 선수 데이터가 없습니다.");
              return false;
            }
            //alert('응답이 왔습니다.');
            //console.log(data);
            //alert(data.length);

            for(var i= 0, l = data.length; i < l; i++){
              var row = i+1;

              $('#myTable > tbody:last').append('<tr">' +
                      '<td width="12%"><select class="form-control" id="playerid[]"  name="playerGameVos['+i+'].playerid">' +
                      '</select></td>' +
                      '<td width="11%"><select class="form-control" id="positioncode[]" name="playerGameVos['+i+'].positioncode">' +
                      '<option value='+data[i].positioncode+' selected>'+data[i].positioncode+'</option>'+
                      '</select></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].offensive" type="number" value="50" min="0" max="100"></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].defensive" type="number" value="50" min="0" max="100"></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].pass" type="number" value="50" min="0" max="100"></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].controll" type="number" value="50" min="0" max="100"></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].tactics" type="number" value="50" min="0" max="100"></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].strength" type="number" value="50" min="0" max="100"></td>' +
                      '<td width="11%"><input class="form-control" id="" name="playerGameVos['+i+'].creativity" type="number" value="50" min="0" max="100"></td>' +
                      '<td rowspan="2" style="text-align: center; vertical-align: middle"><button class="btn btn-sm btn-danger" onclick="deleteRow(this)">삭제</button></td></tr>' +
                      '<tr>'+
                      '<td colspan="3"><textarea class="form-control" id="good[]" name="playerGameVos['+i+'].good" placeholder="좋은 플레이 및 발전가능성등"></textarea></td>' +
                      '<td colspan="3"><textarea class="form-control" name="playerGameVos['+i+'].problem" placeholder="보완점등"></textarea></td>' +
                      '<td colspan="2"><textarea class="form-control" name="playerGameVos['+i+'].review" placeholder="기타"></textarea></td>' +
                      '<td><input class="form-control" id="" name="playerGameVos['+i+'].intime" type="number" value="90" min="0" max="120"></td>' +
                      '<input type="hidden" name="playerGameVos['+i+'].exgameid" value='+cexgamid+'>'+
                      '</tr>'
              );

              var t =$("select[id='playerid[]'").size();

              //alert(data[i].playername +' - '+data[i].playerid);

              $("select[id='playerid[]'").eq(i).append("<option value="+data[i].playerid+" seleted>"+data[i].playername+"</option>");

              var positionSize =$("select[id='positioncode[]'").size();
              $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='FW'>FW</option>");
              $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='MF'>MF</option>");
              $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='DF'>DF</option>");
              $("select[id='positioncode[]'").eq(positionSize-1).append("<option value='GK'>GK</option>");

            }

          }
        }); //ajax end

      });

      $('#plus').click(function(){
        /*문제점 : 열두개가 하나의 객체 레코드다.
        *          아래 처럼 tr 하나를 구하게 되면 2씩 증가하는 현상이 발생한다.
        */
        var rowCount = $('#myTable tr').length;
        var conditionnum=0;

        var eq = (rowCount / 2)-1;
        //alert(eq);
        //1. 형식에 맞추어 열을 추가해준다.
        $('#myTable > tbody:last').append('<tr>' +
                '<td width="12%"><select class="form-control" id="playerid[]" required name="playerGameVos['+eq+'].playerid"><option vlaue="">-</option></select></td>' +
                '<td width="11%"><select class="form-control" id="positioncode[]" required name="playerGameVos['+eq+'].positioncode"><option vlaue="">-</option></select></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].offensive" type="number" value="50" min="0" max="100"></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].defensive" type="number" value="50" min="0" max="100"></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].pass" type="number" value="50" min="0" max="100"></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].controll" type="number" value="50" min="0" max="100"></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].tactics" type="number" value="50" min="0" max="100"></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].strength" type="number" value="50" min="0" max="100"></td>' +
                '<td width="11%"><input class="form-control" id="" name="playerGameVos['+eq+'].creativity" type="number" value="50" min="0" max="100"></td>' +
                '<td rowspan="2" style="text-align: center; vertical-align: middle"><button class="btn btn-sm btn-danger"  onclick="deleteRow(this)">삭제</button></td>' +
                '</tr><tr>'+
                '<td colspan="3"><textarea class="form-control" id="good[]" name="playerGameVos['+eq+'].good" placeholder="좋은 플레이 및 발전가능성등"></textarea></td>' +
                '<td colspan="3"><textarea class="form-control" name="playerGameVos['+eq+'].problem" placeholder="보완점등"></textarea></td>' +
                '<td colspan="2"><textarea class="form-control" name="playerGameVos['+eq+'].review" placeholder="기타"></textarea></td>' +
                '<td><input class="form-control" id="" name="playerGameVos['+eq+'].intime" type="number" value="90" min="0" max="120"></td>' +
                '<input type="hidden" name="playerGameVos['+eq+'].exgameid" value='+cexgamid+'>'+
                '</tr>'
        );

        //select 옵션의 총 숫자를 파악 한다.
        var select =$("select[id='playerid[]'").size();

        //2.서버에서 팀의 선수정보를 들고온다.
        var selectops = JSON.parse('${list}');
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

      });

      function itemhide(){
        $('#plus').hide();
        $('#minus').hide();
      }

      function itemshow(){
        $('#plus').show();
        $('#minus').show();
      }


      $('#frm').submit(function() {
        // 1.선수를 모두 선택했는지 검사
        var plCount=0;
        var playerCount =$("select[id='playerid[]'").size();

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
            alert("빨갱이지우기");
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

      //alert('1.선택한 것은 : '+ tr.index());
      //alert('2.선택한 것은 : '+ tx.index());
      //alert('3.선택한 것은 : '+ th.index());

      tr.remove();
      tx.remove();
      th.remove();
    }




  </script>

</head>

<body class="stmbody" >
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>
  <section class="page-subject">
    <h3>개인경기 기록입력</h3>
  </section>

  <form method="post" action="/playergame/dbinsert" id="frm" name="frm" class="form-horizontal">
    <section class="highlight_white">
      <div class="form-group">
        <label class="col-md-2 control-label" for="radio">1.경기종류선택</label>
        <div class="col-md-4">
          <div class="radio" id="radio">
            <label>
              <input type="radio" name="scheduleflag"  value="game"> 대회경기
              <label>
                <input type="radio" name="scheduleflag" value="exgame"> 연습경기
              </label>
            </label>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label id ="templabel" for="tempid" class="col-md-2 control-label">2.경기 선택</label>
        <div class="col-md-4">
          <select class="form-control" id="tempid" name="tempid">
            <option value="0">경기선택</option>
          </select>
        </div>

        <div class="col-md-4">
          <input class="form-control" value="" id="exclassdisp" disabled>
        </div>

      </div>
    </section>

    <div id="valid"></div>

    <section class="highlight_white">
      <div class="row" id="addrow">
        <div class="col-md-2">
          <button type="button" class="btn btn-default btn-sm" aria-label="Left Align"  id="plus">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
          </button>
          <%--<button type="button" class="btn btn-default btn-sm" aria-label="Left Align"  id="minus">--%>
          <%--<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>--%>
          <%--</button>--%>
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
          <th></th>
        </tr>
        <tr>
          <th colspan="3">Good Play(좋은 점)</th>
          <th colspan="3">Defect Play(부족한 점)</th>
          <th colspan="2">기타</th>
            <th>Playtime</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </section>
    <input id="submit" type="submit" class="btn btn-default" value="등록" style="width: 110px"/>
  </form>

</article>

<footer>

  <%--<table class="table table-condensed">--%>
    <%--<thead>--%>
      <%--<tr>--%>
        <%--<th width="100px">1</th>--%>
        <%--<th width="100px">2</th>--%>
        <%--<th width="100px"></th>--%>
      <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody>--%>
    <%--<tr>--%>
      <%--<td width="100px"><select id="test[]"  name="playerGameVos[0].positioncode"><option value="">-</option></select></td>--%>
      <%--<td width="100px">2</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
      <%--<td width="100px"><select id="test[]"  name="playerGameVos[1].positioncode"><option value="">-</option></select></td>--%>
      <%--<td width="100px">2</td>--%>
    <%--</tr>--%>
    <%--</tbody>--%>
  <%--</table>--%>
  <%--<button id="test">선택</button>--%>
  <%--<script>--%>
    <%--$('#test').click(function(){--%>
      <%--alert('시작');--%>
      <%--var select =$("select[id='test[]'").size();--%>

      <%--alert('시작' + select);--%>
      <%--$("select[id='test[]'").parent().parent('tr').attr('class','danger');--%>
    <%--});--%>
  <%--</script>--%>


</footer>

</body>
</html>
