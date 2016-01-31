<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 선수정보</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>
  <script src="/resources/jui-master/dist/jui.min.js"></script>

</head>

<script>
  $(document).ready(function() {

    var PlayerName;
    var seach_con    =   "<c:out value='${seach_con}'/>";

    $('#seach_con').val(seach_con);

    setTimeout(function(){
      $('#alert').alert('close');
    },3000);

    var teamid = "${teamid}";

    //alert(teamid);

    var playerid = "${playerid}";
    var paramtrace = "${grap}";
    getplayerInfo();

    $('#change').click(function() {

      var joindate = $('#joindate').val();
      var playername = $('#playername').val();
      var backnumber = $('#backnumber').val();

      if(joindate==""){
        upfrm.joindate.focus();
        alert('입단일자는 필수 사항입니다');
        $('#alertr').append('<div class="alert alert-danger alert-dismissible" role="alert" id="alertu"> ' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button> ' +
                '<strong>[성공]</strong> 입단일자는 필수값 입니다. </div>');
        setTimeout(function(){
          $('#alertu').alert('close');
        },3000);
        return;
      }

      if(playername==""){
        upfrm.playername.focus();
        alert('선수이름은 필수 사항입니다');
        $('#alertr').append('<div class="alert alert-danger alert-dismissible" role="alert" id="alertu"> ' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button> ' +
                '<strong>[성공]</strong> 선수이름은 필수값 입니다. </div>');
        setTimeout(function(){
          $('#alertu').alert('close');
        },3000);
        return;
      }

      if(backnumber==""){
        upfrm.backnumber.focus();
        alert('등번호는 필수 사항입니다');
        $('#alertr').append('<div class="alert alert-danger alert-dismissible" role="alert" id="alertu"> ' +
                '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button> ' +
                '<strong>[성공]</strong> 등번호는 필수값 입니다. </div>');
        setTimeout(function(){
          $('#alertu').alert('close');
        },3000);
        return;
      }

      $('#upfrm').submit();
    });


    if(paramtrace=='grap'){
      $('#collapseFive').collapse('show');
    }else if(paramtrace=='playerup'){
      $('#collapseOne').collapse('show');
      getplayerInfo();
    }


    $('#collapseOne').on('show.bs.collapse', function () {
      getplayerInfo();
    })

    //선수정보 업데이트 닫기 눌렀을때..
    $('#closedBtn').click(function(){
      $("#alert").alert('close');
    });

    //선수정보 가져오기 ajax

    function getplayerInfo(){
      $.ajax({
        url : "/ajax/getplayer",
        type: "get",
        data : { "id" : playerid },

        success : function(data){
          $("#ajax").remove();

          if(!data){
            alert("존재하지 않는 ID입니다");
            return false;
          }
          PlayerName = data.playername;
          $('#playername').val(data.playername);
          $("#exclass").val(data.exclass).attr("selected", "selected");
          $("#positioncategory").val(data.positioncategory).attr("selected", "selected");
          $("#positioncode").val(data.positioncode).attr("selected", "selected");
          if(data.status=='Y'){
            $("input:radio[name='status']:radio[value='Y']").attr('checked', true);
          }else{
            $("input:radio[name='status']:radio[value='N']").attr('checked', true);
          }
          $('#description').val(data.description);
          $('#joindate').val(data.joinFormatdate);
          $('#preview').attr("src","/resources/img/player/"+data.picture);
          $('#playerid').val(data.playerid);
          $('#backnumber').val(data.backnumber);
          $('#date').val(data.enddate);

        }
      }); //ajax end
    }
  });


  function previewImage(input) {
    var preview = document.getElementById('preview');

    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        preview.setAttribute('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    } else {
      preview.setAttribute('src', '/resources/img/140+140.svg');
    }
  }

  function open_file(){
    upfrm.file.click();
  }

  var json = JSON.parse('${jsonList}');

  var pjson = JSON.parse('${plist}');
  var seachParam = '${seach_con}';

  var arry_exdate = [];
  for(var i in json){
    arry_exdate.push([json[i].exdate]);
  }

  var arry_exdatecon=[];

  for(var i in arry_exdate){
    arry_exdatecon.push(arry_exdate[i]);
  }

  //5개의 최근 평가를 보여준다. 5개 이상을 표현하면 그래픽이 보기 않좋다.
  if(arry_exdatecon.length < 5) {
    var v_conplit = 5 - arry_exdatecon.length;
    for (var i = 1; v_conplit >= i; i++) {
      arry_exdatecon.push('--------');
    };
  };




  //페이징
  function goPage(pageNo){
    document.listForm.pageNo.value = pageNo;
    document.listForm.submit();

  }
</script>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h2>선수정보</h2>
  </section>

  <%--<spring:select path="pass" items="${map}">--%>
  <%--</spring:select>--%>


  <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

    <c:if test="${grap == 'playerup'}">
      <div class="alert alert-success alert-dismissible" role="alert" id="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <strong>[성공]</strong> 선수정보가 정상적으로 변경되었습니다.
      </div>
    </c:if>
    <div id="alertr"></div>

    <%--단락시작--%>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingOne">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
            선수정보
          </a>
        </h4>
      </div>

      <%--탭 바디--%>
      <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
        <div class="panel-body">

          <div style="margin: 20px" id="wrapper">

            <form method="post" action="playerupdate" enctype="multipart/form-data" name="upfrm" id="upfrm" class="form-inline">
              <div class="row">
                <div class="col-md-2">
                  <h5>선수이름</h5>
                </div>
                <div class="col-md-4">
                  <input type="text" class="form-control" id="playername" name="playername" required>
                </div>
                <div class="col-md-2">
                  <h5>선수레벨</h5>
                </div>
                <div class="col-md-4">
                  <select  class="form-control" id="exclass" name="exclass">
                    <option value="A">Class A</option>
                    <option value="B">Class B</option>
                    <option value="C">Class C</option>
                    <option value="D">Class D</option>
                  </select>
                </div>
              </div>
              <div class="row">
                <div class="col-md-2">
                  <h5>공격/수비</h5>
                </div>
                <div class="col-md-4">
                  <select id="positioncategory" name="positioncategory" class="form-control">
                    <option value="">공격/수비</option>
                    <option value="공격">공격</option>
                    <option value="수비">수비</option>
                  </select>
                </div>
                <div class="col-md-2">
                  <h5>포지션</h5>
                </div>
                <div class="col-md-4">
                  <select id="positioncode" name="positioncode" class="form-control">
                    <option value="FW">FW</option>
                    <option value="MF">MF</option>
                    <option value="DF">DF</option>
                    <option value="GK">GK</option>
                  </select>
                </div>
              </div>

              <div class="row">
                <div class="col-md-2">
                  <h5>팀입단일자</h5>
                </div>
                <div class="col-md-4">
                  <input type="text" class="form-control" id="joindate" name="joindate" required>
                </div>
                <script>
                  $('#joindate').datepicker({
                    format: "yyyy-mm-dd",
                    language: "ko",
                    autoclose: true,
                    todayHighlight: true
                  });
                </script>
                <div class="col-md-2">
                  <h5>퇴단일자</h5>
                </div>
                <div class="col-md-4">
                  <input type="text" class="form-control" id="date" name="date" required>
                </div>
                <script>
                  $('#date').datepicker({
                    format: "yyyy-mm-dd",
                    language: "ko",
                    autoclose: true,
                    todayHighlight: true
                  });
                </script>
              </div>

              <div class="row">
                <div class="col-md-2">
                  <h5>소속상태</h5>
                </div>
                <div class="col-md-4" style="margin-top: 5px">
                  <div class="radio">
                    <label>
                      <input type="radio" name="status" value="Y"> 소속
                    </label>
                    <label>
                      <input type="radio" name="status" value="N"> 비소속
                    </label>
                  </div>
                </div>

                <div class="col-md-2">
                  <h5>등번호</h5>
                </div>
                <div class="col-md-4">
                  <input type="text" class="form-control" id="backnumber" name="backnumber" required>
                </div>
              </div>

              <div class="row">
                <div class="col-md-2">
                  <h5>사진</h5>
                </div>
                <div class="col-md-4">
                  <img data-toggle="tooltip" data-placement="left" title="사진을 변경하시려면 클릭하세요!"
                       width="130px" height="130px" class="img-thumbnail" id="preview" name="emblem" src="/resources/img/140+140.svg" onclick=open_file() alt="140x140">
                  <input style="display:none" type="file" id="file" name="file" onchange="previewImage(this)"  accept="image/*"/>
                </div>
                <div class="col-md-2">
                  선수소개
                </div>
                <div class="col-md-4">
                  <textarea class="form-control" rows="4" name="description" id="description"></textarea>
                </div>
              </div>
              <input type="hidden" id="playerid" name="playerid" >
            </form>

          </div>

        </div>

        <div class="panel-footer">
          <button type="button" class="btn btn-default"
                  data-toggle="collapse"  href="#collapseOne" aria-expanded="false" id="closedBtn" >닫기</button>
          <button type="button" class="btn btn-primary" id="change">변경</button>
        </div>
      </div>
    </div>

    <%--단락시작--%>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingTwo">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
            대회참가정보
          </a>
        </h4>
      </div>

      <%--탭 바디--%>
      <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
        <div class="panel-body">
          <div class="row">
            <div class="col-md-6">
              <div id="chart-game"></div>
                <script>
                  var teamid = "${teamid}";
                  var playerid = "${playerid}";
                  var playerName = "${playerName}";

                  $.ajax({
                    url : "/report/gamePlayerAvg",
                    type: "get",
                    data : {  "playerid" : playerid,
                      "teamid"   : teamid
                    },
                    success : function(exgamedata) {
                      if (!exgamedata) {
                        return false;
                      }

                      if(exgamedata.length==1){
                        $('#chart-game').append('<h5 class="text-center">대회참가정보가 존재하지 않습니다</h5>');
                      }else{
                        var chart = jui.include("chart.builder");

                        //언어설정
                        var subject = "대회경기 선수평균 기록 수치";

                        var col1="창의성";
                        var col2="전술";
                        var col3="체력";
                        var col4="패스";
                        var col5="컨트롤";
                        var col6="공격";
                        var col7="수비";

                        var row1="선수";
                        var row2="팀평균";

                        //데이터
                        var playerAgv=[
                          {  선수 : exgamedata[0].creativity, 팀평균: exgamedata[1].creativity },
                          {  선수: exgamedata[0].tactics, 팀평균: exgamedata[1].tactics },
                          {  선수: exgamedata[0].strength, 팀평균: exgamedata[1].strength },
                          {  선수: exgamedata[0].offensive, 팀평균: exgamedata[1].offensive },
                          {  선수: exgamedata[0].defensive, 팀평균: exgamedata[1].defensive },
                          {  선수: exgamedata[0].pass, 팀평균: exgamedata[1].pass },
                          {  선수: exgamedata[0].controll, 팀평균: exgamedata[1].controll }
                        ];

                        chart("#chart-game", {
                          width:560,
                          height:380,
                          axis : {
                            x : {
                              type : "block",
                              domain : [ col1,col2,col3,col4,col5,col6,col7 ]
                            },
                            y : {
                              type : "range",
                              domain : [0,10]  //좌측 숫자 0 ~ 10 평가 숫치를 나타낸다.
                            },
                            c : {
                              type : "grid3d"
                            },
                            data : playerAgv,
                            depth : 20,
                            degree : 30
                          },
                          brush : {
                            type : "column3d",
                            outerPadding : 10,
                            innerPadding : 5,
                            colors:["#FFEB3B","#FF9800"],
                            animate : true
                          },
                          widget : [
                            {type : "tooltip",brush : 1},
                            {
                              type : "title",
                              text : subject
                            },
                            { type : "legend",filter : true }
                          ]
                        });
                      }
                    }
                  });
                </script>
            </div>
            <div class="col-md-6">
              <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                  <ul class="list-group">
                    <li class="list-group-item">
                      <span class="badge" id="gamecount">${gameAvg.count}</span>
                      연습경기출전 횟수
                    </li>
                    <li class="list-group-item">
                      <span class="badge" id="gamegoal">${gameAvg.goal}</span>
                      득점
                    </li>
                    <li class="list-group-item">
                      <span class="badge" id="gameassist">${gameAvg.asist}</span>
                      어시시트
                    </li>
                    <li class="list-group-item">
                      <span class="badge" id="gametime">${gameAvg.intime}</span>
                      총경기출장 시간
                    </li>
                  </ul>
                </div>
                <div class="col-md-1"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%--단락시작--%>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingThree">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
            연습경기정보
          </a>
        </h4>
      </div>

      <%--연습경기 내용 바디.--%>
      <div id="collapseThree" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
        <div class="panel-body">
          <div class="row">
            <div class="col-md-6">
              <div id="chart-exgmae"></div>
              <script>

                var lvteamid = "${teamid}";
                var lvplayerid = "${playerid}";
                var playerName = "${playerName}";

                $.ajax({
                  url : "/report/exgamePavg",
                  type: "get",
                  data : {  "teamid"   : lvteamid,
                    "exclass"  : "O",
                    "fromdate" : "0000-00-00",
                    "todate"   : "0000-00-00",
                    "playerid" : lvplayerid},
                  success : function(exgamedata){

                    if(!exgamedata){
                      alert("연습경기 정보가 없습니다.");
                      return false;
                    }

                    if(exgamedata.length==1){
                      $('#chart-exgmae').append('<h5 class="text-center">연습경기 정보가 존재하지 않습니다</h5>');
                    }else{
                      var chart = jui.include("chart.builder");
                      var data = [
                        { type : "패스",     선수 : exgamedata[0].pass, 팀평균 : exgamedata[1].pass },
                        { type : "컨트롤",   선수 : exgamedata[0].controll,  팀평균 : exgamedata[1].controll },
                        { type : "공격",     선수 : exgamedata[0].offensive,  팀평균 : exgamedata[1].offensive },
                        { type : "수비",     선수 : exgamedata[0].defensive,  팀평균 : exgamedata[1].defensive },
                        { type : "창의성",   선수 : exgamedata[0].creativity,  팀평균 : exgamedata[1].creativity },
                        { type : "전술",     선수 : exgamedata[0].tactics,  팀평균 : exgamedata[1].tactics },
                        { type : "체력",     선수 : exgamedata[0].strength,  팀평균 : exgamedata[1].strength }
                      ];

                      chart("#chart-exgmae", {
                        width:450,
                        height:380,
                        axis : {
                          c : {
                            type : "radar",
                            shape : "circle",
                            domain : "type",
                            max:10,
                            step:10,
                          },
                          data : data
                        },
                        brush : {
                          type : "path",
                          colors: ["#9C27B0","#03A9F4"],
                          target : [ "선수", "팀평균" ],
                          animate : true,
                        },
                        widget : [
                          { type : "title", text : "연습경기 평균기록 비교" },
                          { type : "legend",filter : true },
                          { type : "tooltip", brush : 1 }
                        ]
                      });
                    }
                  }
                }); //end ajax
              </script>
            </div>
            <div class="col-md-6">
              <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                  <ul class="list-group">
                    <li class="list-group-item">
                      <span class="badge" id="exgamecount">${exgameAvg.count}</span>
                      연습경기출전 횟수
                    </li>
                    <li class="list-group-item">
                      <span class="badge" id="exgamegoal">${exgameAvg.goal}</span>
                      득점
                    </li>
                    <li class="list-group-item">
                      <span class="badge" id="exgameassist">${exgameAvg.asist}</span>
                      어시시트
                    </li>
                    <li class="list-group-item">
                      <span class="badge" id="exgametime">${exgameAvg.intime}</span>
                      총경기출장 시간
                    </li>
                  </ul>
                </div>
                <div class="col-md-1"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%--단락시작--%>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingThree">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="true" aria-controls="collapseFour">
            개인코칭 및 일일훈련포인트
          </a>
        </h4>
      </div>

      <%--탭 바디--%>
      <div id="collapseFour" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingFour">
        <div class="panel-body">

          <div class="row">
            <div class="col-md-6">
              <ul class="list-group">
                <li class="list-group-item">
                  <span class="badge" >${coachRec.coachingcount}</span>
                   총 코칭 카운트
                </li>
                <li class="list-group-item">
                  <span class="badge" >${coachRec.learnscore}</span>
                   코칭 중요도 평균 포인트
                </li>
                <li class="list-group-item">
                  <span class="badge" >${coachRec.ex}</span>
                   코칭유형[훈련과정]
                </li>
                <li class="list-group-item">
                  <span class="badge" >${coachRec.game}</span>
                  코칭유형[대회경기]
                </li>
                <li class="list-group-item">
                  <span class="badge" >${coachRec.exgame}</span>
                  코칭유형[연습경기]
                </li>
              </ul>
              </ul>
            </div>
            <div class="col-md-6">
              <ul class="list-group">
                <li class="list-group-item">
                  <span class="badge" >${coachRec.trcount}</span>
                  훈련참여횟수
                </li>
                <li class="list-group-item">
                  <span class="badge" >${coachRec.satipoint}</span>
                  훈련점수평균
                </li>
                <li class="list-group-item">
                  <span class="badge" >${coachRec.injucount}</span>
                  부상불참횟수
                </li>
              </ul>
            </div>
          </div>

        </div>
      </div>
    </div>

    <%--단락시작--%>
    <div class="panel panel-default">
      <div class="panel-heading" role="tab" id="headingThree">
        <h4 class="panel-title">
          <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="true" aria-controls="collapseFive">
            정기평가정보
          </a>
        </h4>
      </div>

      <%--탭 바디--%>
      <div id="collapseFive" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingFive">
        <div class="panel-body">

          <c:if test="${list.size() == 0}">
            <h5>정기 평가 정보가 없습니다.</h5>
          </c:if>

          <c:if test="${list.size() > 1}">
            <div id="chart-content"></div>
          </c:if>

          <script>
            var chart = jui.include("chart.builder");

            var flag=2;

            chart("#chart-content", {
              width:900,
              height:300,
              axis : {
                x : {
                  type : "fullblock",
                  domain :arry_exdatecon,
                  line : true
                },
                y : {
                  domain : function(d) {
                    return Math.max(d.dribble, d.game, d.kick, d.leadings, d.pass, d.tactics, d.shooting);
                  },
                  type : "range",
                  step : 10,
                  line : true
                },
                data : pjson
              },
              brush : [{
                type : "line",
                animate : true,
                display : "max",
                active : "pass",
                activeEvent : "click",
                target : [ "dribble", "game", "kick","leadings","pass","tactics","shooting" ]
              }, {
                type : "scatter",symbol : "circle", size: 20,
                hide : true
              }],
              widget : [
                { type : "title", text : "선수 평가기록" },
                { type : "legend",filter : true },
                { type : "tooltip", brush : 1 }
              ]
            });

          </script>


          <c:if test="${list.size() == 1}">
            <div class="row" style="margin: auto">
              <div class="col col-4"><div id="chart"></div></div>
            </div>
          </c:if>
          <script id="tpl_tooltip" type="text/template">
            <div class="tooltip tooltip-top tooltip-black">
              <div class="anchor"></div>
              <div class="message"><!= obj.dataKey !>: <!= obj.data[obj.dataKey] !></div>
            </div>
          </script>

          <script>
            jui.ready([ "chart.builder" ], function(chart) {
              c = chart("#chart", {

                width: 900,
                height : 400,
                theme : "jennifer",
                axis : {
                  x : {
                    type : "block",
                    domain : arry_exdatecon
                  },
                  y : {
                    type : "range",
                    domain : function(d) {
                      return Math.max(d.dribble, d.game, d.kick, d.leadings, d.pass, d.tactics, d.shooting);
                    },
                    step : 5
                  },
                  c : {
                    type : "grid3d"
                  },
                  data : pjson,
                  depth : 200,
                  degree : 45
                },
                brush : {
                  type : "clustercylinder3d",
                  topRate : 1,
                  outerPadding : 50,
                  innerPadding : 0.2
                },
                widget : [
                  {type : "tooltip"},
                  { type : "title", text : "선수평가기록" },
                  { type : "legend" }
                  //{type : "scroll", orient : "bottom"}
                ]
                ,
                style : {
                  gridAxisBorderColor : "black",
                  gridBorderColor : "#dcdcdc"
                }
              });
            })

          </script>
          <%
            String pid =  request.getParameter("playerid");
          %>

          <div>
            <c:if test="${list.size() != 0}">
              <div style="text-align: center">
                <form name="listForm" action="playerinfo" method="post">
                  <div class="row">
                    <div class="col-md-1"></div>
                    <div class="pagination col-md-3">
                      <select name="seach_con" class="form-control" id ="seach_con" onchange="javascript:goPage(${paging.firstPageNo})">
                        <option value="all">전체보기</option>
                        <option value="dribble">드리블</option>
                        <option value="kick">킥</option>
                        <option value="pass">패스</option>
                        <option value="shooting">슈팅</option>
                        <option value="tactics">전술</option>
                        <option value="leadings">리딩</option>
                        <option value="game">게임</option>
                      </select>
                    </div>
                    <div class="pagination col-md-4">
                      <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
                      <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
                      <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
                      <input type="hidden" name="pageNo" value="${paging.pageNo}" />
                      <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
                      <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
                      <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />
                      <input type="hidden" name="playerid" value="<%=pid%>" />
                      <input type="hidden" name="grap" value="grap" />

                      <li class="previous"><a href="javascript:goPage(${paging.firstPageNo})"><span aria-hidden="true"></span>처음</a></li>
                      <li><a href="javascript:goPage(${paging.prevPageNo})" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                      <li>
                        <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
                          <c:choose>
                            <c:when test="${i eq paging.pageNo}">
                              <a href="javascript:goPage(${i})" class="selected">${i}</a>
                            </c:when>
                            <c:otherwise>
                              <a href="javascript:goPage(${i})">${i}</a>
                            </c:otherwise>
                          </c:choose>
                        </c:forEach>
                      </li>
                      <li><a href="javascript:goPage(${paging.nextPageNo})" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                      <li class="next"><a href="javascript:goPage(${paging.finalPageNo})">마지막<span aria-hidden="true"></span></a></li>
                    </div>
                    <div class="col-md-3"></div>
                  </div>
                </form>
              </div>
            </c:if>
          </div>
        </div>
      </div>
    </div>

  </div>
</article>


<footer class="highlight">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>

