<%@ page import="com.sun.net.httpserver.HttpsServer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="stm" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>

<html lang="ko">
<head>
    <title>Sport Team Manager</title>
    <link rel="stylesheet" href="/resources/stm.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
    <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
    <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
    <script src="/resources/new_jui/jui-core-develop/dist/core.min.js"></script>
    <script src="/resources/new_jui/jui-chart-develop/dist/chart.min.js"></script>
    <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
    <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

    <script>

        $(document).ready(function() {


            $("#teamjoin").hover(function(){
                $(this).attr("src","/resources/systemimg/teamjoin_hover.svg");
            }, function(){
                $(this).attr("src","/resources/systemimg/teamjoin.svg");
            });

            $("#teamreq").hover(function(){
                $(this).attr("src","/resources/systemimg/teamreq_hover.svg");
            }, function(){
                $(this).attr("src","/resources/systemimg/teamreq.svg");
            });

            var teamId='${teamvo.teamid}';
            var loginName='${curlogname}';
            var teamcount='${teamCount}';

            //로그인을 실행하면 자료를 가져온다.
            if(loginName!='anonymousUser' && teamcount >= 1){

                $.ajax({
                    url : "/ajax/getMatchs",
                    type: "get",
                    data:{},
                    success : function(evaldata) {
                        if (!evaldata) {
                            alert("대회정보가 서버에 없습니다.");
                            return false;}
                        var selectBox = $('#matchid');
                        for(var i = 0, l = evaldata.length; i < l; i++){
                            selectBox.append("<option value="+evaldata[i].matchid+">"+evaldata[i].name+"</option>");}}
                });

                //대회경기 평균정보
                $.ajaxGameCall(teamId,"O","0000-00-00","0000-00-00","new",0);

                //연습경기 평균정보
                $.ajaxCall(teamId,"O","0000-00-00","0000-00-00","new");

                //평가에 대한 정보
                $.ajaxEval("0000-00-00","0000-00-00","new");

                //선수 신체정보관련
                $.phyajax(teamId,"O","0000-00-00","0000-00-00");





            }
            //exClass에 따른 실행
            $('#query').click(function(){

                var matchid = $('#matchid').val();

                var fromdate = $('#fromdate').val();
                var todate   = $('#todate').val();

                if(fromdate==""){
                    fromdate = "0000-00-00";
                }

                if(todate==""){
                    todate = "0000-00-00";
                }

                var exclass = $('#exclass').val();
                $.ajaxGameCall(teamId,exclass,fromdate,todate,"update",matchid);
                $.ajaxCall(teamId,exclass,fromdate,todate,"update");
                $.phyajax(teamId,exclass,fromdate,todate);
                $.ajaxEval(fromdate,todate,"update");
            });
        });

        //선수들 신체정보 가져오기
        $.phyajax = function(teamid,exClass,fromdate,todate){

            $('#myphytable tr').eq(1).remove();

            $.ajax({
                url : "/reports/phyplayerAvg",
                type: "get",
                data : { "teamid"   : teamid,
                    "exclass"  : exClass,
                    "fromdate" : fromdate,
                    "todate" : todate
                },
                success : function(evaldata) {
                    if (!evaldata) {

                        $('#myphytable > tbody:last').append('<tr">' +
                                '<td colspan="8" style="text-align: center" class="warning">입력된 선수 신체정보가 없습니다.</td>' +
                                '</tr>'
                        );

                        return false;
                    }

                    $('#myphytable > tbody:last').append('<tr">' +
                            '<td>'+evaldata.height+'</td>' +
                            '<td>'+evaldata.weight+'</td>' +
                            '<td>'+evaldata.bodyfat+'</td>' +
                            '<td>'+evaldata.footsize+'</td>' +
                            '<td>'+evaldata.fifty+'</td>' +
                            '<td>'+evaldata.onehundred+'</td>' +
                            '<td>'+evaldata.twohundred+'</td>' +
                            '<td>'+evaldata.fourhundred+'</td>' +
                            '</tr>'
                    );

                }

            });
        };

        //서버에서 연습경기 평가 평균 가져오기
        $.ajaxCall = function (teamId,exClass,fromdate,todate,falg) {
            //경기 레벨
            $('#exgameTable tr').eq(1).remove();

            $.ajax({
                url : "/report/exgamesData",
                type: "get",
                data : { "teamid"   : teamId,
                    "exclass"  : exClass,
                    "fromdate" : fromdate,
                    "todate"   : todate},
                success : function(exgameData){
                    $("#ajax").remove();
                    if(!exgameData){
                        alert("등록된 연습경기 자료가 없습니다");
                        var data1 = [
                            {
                                FW : 1, MF :1, DF :1
                            }
                        ];

                        var data2 = [
                            {
                                슈팅 : 1,셋플레이 : 1, 패스 :1, 조직 : 1, 체력 : 1
                            }
                        ];

                        //select changed
                        var axis = c.axis(0);
                        axis.update(data1);

                        var axis1 = c1.axis(0);
                        axis1.update(data2);
                        return false;
                    }

                    $("#exgamecount").text(exgameData.exgamecount);
                    $("#getpoint").text(exgameData.wgoal);
                    $("#losspoint").text(exgameData.ogoal);
                    $("#win").text(exgameData.wincount);
                    $("#loss").text(exgameData.losscount);
                    $("#same").text(exgameData.nullcount);

                    $('#exgameTable > tbody:last').append('<tr">' +
                            '<td class="text-center">'+exgameData.exgamecount+'</td>' +
                            '<td class="text-center">'+exgameData.wincount+'</td>' +
                            '<td class="text-center">'+exgameData.losscount+'</td>' +
                            '<td class="text-center">'+exgameData.nullcount+'</td>' +
                            '<td class="text-center">'+exgameData.wgoal+'</td>' +
                            '<td class="text-center">'+exgameData.ogoal+'</td>' +
                            '</tr>');

                    var data1 = [{FW : exgameData.fw, MF : exgameData.mf, DF : exgameData.df}];

                    var data2 = [{슈팅 : exgameData.shooting,셋플레이 : exgameData.setplay, 패스 :exgameData.passing, 조직 : exgameData.org, 체력 : exgameData.fig}];

                    if(falg=="new"){
                        //차트를 생성한다.
                        var chart = jui.include("chart.builder");

                        c = chart("#chart-position", {
                            width:430,
                            height:300,
                            axis : {
                                x : {
                                    type : "block",
                                    domain : "",
                                    //domain : [ "FW", "MF", "DF"],
                                    line : true
                                },
                                y : {
                                    type : "range",
                                    step : 10,
                                    line : true,
                                    domain : function(d) {
                                        return 10;
                                    },
                                    orient : "right"
                                },
                                data : data1

                            },
                            brush : {
                                type : "column",
                                target : [ "FW", "MF", "DF"],
                                innerPadding : 10,
                                outerPadding : 10,
                                animate : true
                            },
                            widget : [
                                { type : "title", text : "연습경기 포지션별 평균 포인트" },
                                { type : "tooltip" },
                                { type : "legend",filter : true}
                            ]
                        });

                        c1 = chart("#chart-data", {
                            width:430,
                            height:300,
                            axis : {
                                x : {
                                    type : "block",
                                    domain : "quarter",
                                    line : true
                                },
                                y : {
                                    type : "range",
                                    step : 10,
                                    line : true,
                                    domain : function(d) {
                                        return 10;
                                    },
                                    orient : "right"
                                },
                                data : data2
                            },
                            brush : {
                                type : "column",
                                target : [ "슈팅", "셋플레이", "패스","조직","체력"],
                                innerPadding : 10,
                                outerPadding : 10,
                                animate : true
                            },
                            widget : [
                                { type : "title", text : "연습경기 기술별 평균 포인트" },
                                { type : "tooltip" },
                                { type : "legend",filter : true }
                            ]
                        });

                    }else{

                        //select changed
                        var axis = c.axis(0);
                        axis.update(data1);

                        var axis1 = c1.axis(0);
                        axis1.update(data2);

                        c1.render();
                    }
                }
            }); //end ajax

            //선수레벨
            $.ajax({
                url : "/report/exgamesDataPlayer",
                type: "get",
                data : { "teamid"   : teamId,
                    "exclass"  : exClass,
                    "fromdate" : fromdate,
                    "todate"   : todate,
                    "playerid" : 0},
                success : function(playerGamedata){
                    $("#ajax").remove();
                    if(!playerGamedata){
                        return false;
                    }


                    var playerData = [
                        {
                            창의성 : playerGamedata.creativity, 전술 : playerGamedata.tactics, 체력 : playerGamedata.strength,
                            공격력 : playerGamedata.offensive, 수비력 : playerGamedata.defensive, 패스 : playerGamedata.pass,
                            컨트롤 : playerGamedata.controll
                        }
                    ];



                    if(falg=="new"){
                        var chart = jui.include("chart.builder");
                        c2=chart("#chart-player", {
                            width:910,
                            height:300,
                            axis : {
                                x : {
                                    type : "block",
                                    domain : "quarter",
                                    line : true
                                },
                                y : {
                                    type : "range",
                                    step : 10,
                                    line : true,
                                    domain : function(d) {
                                        return 10;
                                    },
                                    orient : "right"
                                },
                                data : playerData
                            },
                            brush : {
                                type : "column",
                                target : [ "창의성", "전술", "체력", "공격력","수비력","패스","컨트롤" ],
                                innerPadding : 35,
                                outerPadding : 35,
                                animate : true
                            },
                            widget : [
                                { type : "title", text : "팀선수들 평균 기술 포인트" },
                                { type : "tooltip" },
                                { type : "legend",filter : true }
                            ]
                        });
                    }else{
                        var axis3 = c2.axis(0);
                        axis3.update(playerData);

                        c2.render();
                    }
                }
            }); //end ajax

        }//main end

        //대회경기에 대한 정보
        $.ajaxGameCall = function(teamId,exClass,fromdate,todate,falg,matchid){
            $('#gameTable tr').eq(1).remove();
            $.ajax({
                url : "/report/gamesData",
                type: "get",
                data : {    "teamid"   : teamId,
                    "exclass"  : exClass,
                    "fromdate" : fromdate,
                    "todate"   : todate,
                    "matchid"  : matchid
                },
                success : function(gameData){
                    $("#ajax").remove();
                    if(!gameData){
                        alert("등록된 경기 자료가 없습니다");
                        var data1 = [{FW : 1, MF :1, DF :1,셋플레이 : 1,조직 : 1, 체력 : 1}];

                        var axis = c.axis(0);
                        axis.update(data1);

                        return false;
                    }

                    $("#iexgamecount").text(gameData.exgamecount);
                    $("#igetpoint").text(gameData.wgoal);
                    $("#ilosspoint").text(gameData.ogoal);
                    $("#iwin").text(gameData.wincount);
                    $("#iloss").text(gameData.losscount);
                    $("#isame").text(gameData.nullcount);

                    $('#gameTable > tbody:last').append('<tr">' +
                            '<td class="text-center">'+gameData.exgamecount+'</td>' +
                            '<td class="text-center">'+gameData.wincount+'</td>' +
                            '<td class="text-center">'+gameData.losscount+'</td>' +
                            '<td class="text-center">'+gameData.nullcount+'</td>' +
                            '<td class="text-center">'+gameData.wgoal+'</td>' +
                            '<td class="text-center">'+gameData.ogoal+'</td>' +
                            '</tr>');

                    var data = [{FW : gameData.fw, MF : gameData.mf, DF : gameData.df,셋플레이 : gameData.setplay,조직 : gameData.org, 체력 : gameData.fig} ];

                    if(falg=="new") {
                        var gamechart = jui.include("chart.builder");
                        c3 = gamechart("#game-position", {
                            height: 300,
                            axis: {
                                x: {
                                    type: "block",
                                    domain: "",
                                    line: true,
                                    animate: true
                                },
                                y: {
                                    type: "range",
                                    step: 10,
                                    line: true,
                                    domain: function (d) {
                                        return 10;
                                    },
                                    orient: "right"
                                },
                                data: data

                            },
                            brush: {
                                type: "column",
                                target: ["FW", "MF", "DF", "셋플레이", "조직", "체력"],
                                innerPadding: 10,
                                outerPadding: 10,
                                animate: true
                            },
                            widget: [
                                {type: "title", text: "대회경기 평균포인트"},
                                {type: "tooltip"},
                                {type: "legend", filter: true}
                            ]
                        });
                    }else{
                        // alert("조회버튼 클릭시");
                        var axiss = c3.axis(0);
                        axiss.update(data);

                        c3.render();
                    }
                }
            }); //경기 평균 end ajax

            //선수레벨
            $.ajax({
                url : "/report/gamesDataPlayer",
                type: "get",
                data : { "teamid"   : teamId,
                    "exclass"  : exClass,
                    "fromdate" : fromdate,
                    "todate"   : todate,
                    "playerid" : 0,
                    "matchid" :matchid
                },
                success : function(playerGamedata){
                    $("#ajax").remove();
                    if(!playerGamedata){
                        return false;
                    }


                    var playerData = [
                        {
                            창의성 : playerGamedata.creativity, 전술 : playerGamedata.tactics, 체력 : playerGamedata.strength,
                            공격력 : playerGamedata.offensive, 수비력 : playerGamedata.defensive, 패스 : playerGamedata.pass,
                            컨트롤 : playerGamedata.controll
                        }
                    ];



                    if(falg=="new"){
                        var vchart = jui.include("chart.builder");
                        c5 =vchart("#gameChartPlayer", {
                            width:910,
                            height:300,
                            axis : {
                                x : {
                                    type : "block",
                                    domain : "quarter",
                                    line : true
                                },
                                y : {
                                    type : "range",
                                    step : 10,
                                    line : true,
                                    domain : function(d) {
                                        return 10;
                                    },
                                    orient : "right"
                                },
                                data : playerData
                            },
                            brush : {
                                type : "column",
                                target : [ "창의성", "전술", "체력", "공격력","수비력","패스","컨트롤" ],
                                innerPadding : 35,
                                outerPadding : 35,
                                animate : true
                            },
                            widget : [
                                { type : "title", text : "팀선수들 평균 기술 포인트" },
                                { type : "tooltip" },
                                { type : "legend",filter : true }
                            ]
                        });
                    }else{
                        var axis3 = c5.axis(0);
                        axis3.update(playerData);

                        c5.render();
                    }
                }
            }); //end ajax

        }

        //정기 평가에대한 정보
        $.ajaxEval = function(fromdate,todate,flag){
            //정기평가 그래픽 차트를 위한 ajax report/playerAvgeval"
            $.ajax({
                url : "/report/playerAvgeval",
                type: "get",
                data : {fromdate: fromdate
                    ,todate :   todate
                },
                success : function(evaldata) {

                    if (!evaldata) {
                        alert("등록된 정기 평가자료가 없습니다");
                        return false;
                    }


                    var yyyymmdd = [];
                    for (var i = 0; i < evaldata.length; i++) {
                        yyyymmdd.push([evaldata[i].yyyymmdd]);
                    }


                    //5개의 최근 평가를 보여준다. 5개 이상을 표현하면 그래픽이 보기 않좋다.
                    if (yyyymmdd.length < 5) {
                        var v_conplit = 5 - yyyymmdd.length;
                        for (var i = 1; v_conplit >= i; i++) {
                            yyyymmdd.push('--------');
                        }
                        ;
                    }
                    ;

                    var playerData = evaldata;


                    for (var i = 0; i < playerData.length; i++) {
                        delete playerData[i].date;
                        delete playerData[i].yyyymmdd;
                        delete playerData[i].subject;
                        delete playerData[i].playerid;
                        delete playerData[i].teamid;
                        delete playerData[i].fromdate;
                        delete playerData[i].todate;
                    }

                    var data = playerData;

                    if(flag=="new"){

                        if (data.length == 0) {
                            $('#chart-eval').append('<div class="alert alert-warning text-center" role="alert">입력된 정기 평가자료가 없습니다</div>');
                        }else{
                            if (data.length == 1) {

                                //평가를 1회만 수행한 상태라면 그래픽을 종류를 바꾸어준다.
                                //가로 바 형태의 차트
                                var ichart = jui.include("chart.builder");

                                var vdata = [
                                    {title: "패스", value: data[0].pass, max: 10},
                                    {title: "슈팅", value: data[0].shooting, max: 10},
                                    {title: "킥", value: data[0].kick, max: 10},
                                    {title: "드리블", value: data[0].dribble, max: 10},
                                    {title: "컨트롤", value: data[0].controll, max: 10},
                                    {title: "게임", value: data[0].game, max: 10},
                                    {title: "전술", value: data[0].tactics, max: 10},
                                    {title: "팀웍/리딩", value: data[0].leadings, max: 10},
                                    {title: "창의성", value: data[0].creativity, max: 10}
                                ];

                                c4 = ichart("#chart-eval", {
                                    width: 900,
                                    height: 400,
                                    padding: 0,
                                    axis: {
                                        data: vdata
                                    },
                                    brush: {
                                        type: "bargauge",
                                        size: 35,
                                        animate: true

                                    }
                                });

                            } else if (data.length > 1) {

                                //alert("여기여기");
                                //console.log(data);

                                //가로 이력 그래프 형태의 차트
                                var ichart = jui.include("chart.builder");
                                c4 = ichart("#chart-eval", {
                                    width: 920,
                                    height: 400,
                                    axis: {
                                        x: {
                                            type: "fullblock",
                                            domain: yyyymmdd,
                                            line: true
                                        },
                                        y: {
                                            type: "range",
                                            domain: function (d) {
                                                return Math.max(d.pass, d.shooting, d.kick, d.dribble, d.game, d.tactics, d.leadings, d.creativity, d.controll);
                                            },
                                            step: 10
                                        },
                                        //buffer : 10,
                                        area : { x : 0, y : 0, width : "100%", height : "90%"},
                                        data: data
                                    },
                                    brush: [{
                                        type: "line",
                                        symbol: "curve",
                                        animate: true
                                    }, {
                                        type: "scatter",
                                        hide: true
                                    }],
                                    widget: [
                                        {type: "title", text: "팀 기술평가 평균수치"},
                                        {type: "legend",
                                            filter: true,
                                            format:function(key){
                                                if(key=="pass"){
                                                    return "패스";
                                                }else if(key=="shooting"){
                                                    return "슈팅";
                                                }else if(key=="kick"){
                                                    return "킥";
                                                }else if(key=="dribble"){
                                                    return "드리블";
                                                }else if(key=="game"){
                                                    return "게임";
                                                }else if(key=="tactics"){
                                                    return "전술";
                                                }else if(key=="creativity"){
                                                    return "창의성";
                                                }else if(key=="controll"){
                                                    return "컨트롤";
                                                }else if(key=="leadings"){
                                                    return "팀웍/리딩";
                                                }
                                            },

                                        },
                                        {type: "tooltip", brush: 1},{  type : "scroll"}
                                    ],
                                    style: {
                                        lineBorderDashArray: "6, 3",
                                        scrollBackgroundSize : 10
                                    }
                                });
                            }
                        }
                    }else{
                        //alert("평가 업데이트");

                        console.log(data);

                        var axiss = c4.axis(0);
                        axiss.updateGrid("x", { domain : yyyymmdd });  //X축의 도메인(컬럼 데이터를 재설정)
                        axiss.update(data);
                        c4.render();
                    }


                }
            }); //ajax end
        }

    </script>

    <style>
        .section-subject {
            padding-bottom: 9px;
            margin: 10px auto 20px auto;
            border-bottom: 2px solid #eee;
        }
        .row{
            margin-top: 10px;
            margin-bottom: 10px;
        }
    </style>

</head>

<body class="stmbody">




<header>
    <%@ include file="headerpage.jsp"%>
</header>

<article>
    <c:choose>
        <c:when test="${curlogname!='anonymousUser'}">
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <c:if test="${teamCount == 0}">
                    <section class="highlight">
                        <div class="row">
                            <div class="col-md-6 text-center">
                                <a href="/team/teamjoin">
                                    <img id="teamjoin" data-toggle="tooltip" data-placement="top" title="팀을 만듭니다"
                                         src="/resources/systemimg/teamjoin.svg" width="300px" height="300px"/>
                                </a>
                            </div>
                            <div class="col-md-6 text-center">
                                <a href="">
                                    <img id="teamreq"  data-toggle="tooltip" data-placement="top" title="팀의 소속되길 요청합니다"
                                         src="/resources/systemimg/teamreq.svg" width="300px" height="300px"/>
                                <script>
                                    $('#teamreq').click(function(){
                                                alert('팀원 요청 기능은 준비 중입니다');
                                            }
                                    )
                                </script>
                                </a>
                            </div>
                        </div>
                    </section>
                </c:if>

                <c:if test="${teamCount != 0}">
                    <section class="highlight">
                        <div class="row">
                            <div class="col-md-2 text-right"><h5>대회선택</h5></div>
                            <div class="col-md-4">
                                <select class="form-control" id="matchid" name="matchid"><option value="0">없음</option></select>
                            </div>
                            <div class="col-md-2 text-right"><h5>선수클래스</h5></div>
                            <div class="col-md-4">
                                <select class="form-control" id="exclass">
                                    <option value="O" selected>전체대상</option>
                                    <option value="A">Class A</option>
                                    <option value="B">Class B</option>
                                    <option value="C">Class C</option>
                                    <option value="D">Class D</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2 text-right"><h5>조회기간</h5></div>
                            <div class="col-md-2">
                                <input type="text" class="form-control" id="fromdate">
                            </div>
                            <script>
                                $('#fromdate').datepicker({
                                    format: "yyyy-mm-dd",
                                    language: "ko",
                                    autoclose: true,
                                    todayHighlight: true
                                });
                            </script>
                            <div class="col-md-2">
                                <input type="text" class="form-control" id="todate">
                            </div>
                            <script>
                                $('#todate').datepicker({
                                    format: "yyyy-mm-dd",
                                    language: "ko",
                                    autoclose: true,
                                    todayHighlight: true
                                });
                            </script>
                            <div class="col-md-4"></div>
                            <div class="col-md-2">
                                <button class="btn btn btn-primary text-center" id="query" style="width: 110px">조회</button>
                            </div>
                        </div>
                    </section>

                    <section class="highlight_white">
                        <h4 class="section-subject">대회경기 평균정보</h4>
                        <div>
                            <div class="row" style="margin-top: 20px">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-bordered" id="gameTable">
                                            <th class="text-center">경기수</th>
                                            <th class="text-center">승리</th>
                                            <th class="text-center">패배</th>
                                            <th class="text-center">무승부</th>
                                            <th class="text-center">득점</th>
                                            <th class="text-center">실점</th>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-8">
                                    <div id="game-position"></div>
                                </div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div id="gameChartPlayer"></div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="highlight_white">
                        <h4 class="section-subject">연습경기 평균기록</h4>

                        <div class="row">
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered" id="exgameTable">
                                        <th class="text-center">경기수</th>
                                        <th class="text-center">승리</th>
                                        <th class="text-center">패배</th>
                                        <th class="text-center">무승부</th>
                                        <th class="text-center">득점</th>
                                        <th class="text-center">실점</th>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div id="chart-position"></div>
                            </div>
                            <div class="col-md-6">
                                <div id="chart-data"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div id="chart-player"></div>
                            </div>
                        </div>
                    </section>

                    <section class="highlight_white">
                        <h4 class="section-subject">팀 정기평가 평균수치</h4>
                        <div class="row">
                            <div class="col-md-12">
                                <div id="chart-eval"></div>
                            </div>
                        </div>
                    </section>

                    <section class="highlight_white">
                        <h4 class="section-subject">팀 신체정보(평균)</h4>
                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-hover" id="myphytable">
                                    <th>키</th>
                                    <th>몸무게</th>
                                    <th>체비방</th>
                                    <th>발크기</th>
                                    <th>50m</th>
                                    <th>100m</th>
                                    <th>200m</th>
                                    <th>400m</th>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>

                </c:if>
            </c:if>
        </c:when>

        <%--로그인을 하지 않은 경우--%>
        <c:when test="${curlogname=='anonymousUser'}">

            <section class="highlight_white">
                <c:url value="j_spring_security_check" var="loginUrl"/>

                <form class="form-horizontal" action="${loginUrl}" method="post" id="loginmodal" value="loginfrm">

                    <div class="form-group">
                        <label for="userid" class="control-label col-md-2">아이디</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" id="userid" name="userid">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pwd" class="control-label col-md-2">비밀번호</label>
                        <div class="col-md-4">
                            <input type="password" class="form-control" id="pwd" name="pwd">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <input type="submit"    class="btn btn-primary" value="로그인" style="width: 95px"/>
                            <a href="userjoin"     class="btn btn-primary" style="width: 95px">회원가입</a>
                            <a style="position: relative" href="/user/accountfind">아이디찾기</a>/
                            <a style="position: relative" href="/user/passwordreset">비밀번호재설정</a>
                        </div>
                        <div class="col-md-2"></div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-3 text-right">
                            SNS로 회원가입/로그인
                        </div>
                        <div class="col-md-4">
    <%--                        <a href="/oauth/login?snsname=naver"><img src="/resources/systemimg/naver.png" width="50" height="50"></a>
                            <a href="/oauth/login?snsname=twitter"><img src="/resources/systemimg/TwitterLogo.png" width="50" height="50"></a>--%>
                            <a href="/oauth/login?snsname=kakao"><img src="/resources/systemimg/kakaolink_btn.png" width="50" height="50"></a>
                            <a href="/oauth/login?snsname=facebook"><img src="/resources/systemimg/facebook.png" width="50" height="50"></a>
                        </div>
                        <div class="col-md-5"></div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                </form>
            </section>
        </c:when>

    </c:choose>
</article>



<footer class="stm-footer">
    <%@ include file="footer.jsp"%>
</footer>

</body>
</html>
