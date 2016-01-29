<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>선수등록</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap_line.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <%--extend slider--%>
  <script type="text/javascript" src="/resources/jqueryextend/jquery-ui-1.10.3.custom.js"></script>
  <link rel="stylesheet" type="text/css" href="/resources/jqueryextend/jquery-ui.css">

  <%--datetimepicker--%>
  <link rel="stylesheet" href="/resources/datetimepicker/css/bootstrap-datetimepicker.min.css">
  <script type="text/javascript" src="/resources/datetimepicker/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
  <script type="text/javascript" src="/resources/datetimepicker/js/locales/bootstrap-datetimepicker.ko.js" charset="UTF-8"></script>

  <script>
    $(document).ready(function() {

      var exclass = '${gameVo.exclass}';

      if(!exclass==""){
        var weather = '${gameVo.weather}';
        var formation = '${gameVo.formation}';

        var mf = '${gameVo.mf}';
        var fw = '${gameVo.fw}';
        var df = '${gameVo.df}';
        var org = '${gameVo.org}';
        var fig = '${gameVo.fig}';
        var setplay = '${gameVo.setplay}';

        var fhorecord = '${gameVo.fhorecord}';
        var fhwrecord = '${gameVo.fhwrecord}';
        var shorecord = '${gameVo.shorecord}';
        var shwrecord = '${gameVo.shwrecord}';

        $("#fhorecord").val(fhorecord);
        $("#fhwrecord").val(fhwrecord);
        $("#shorecord").val(shorecord);
        $("#shwrecord").val(shwrecord);

        $("#weather").val(weather);
        $("#exclass").val(exclass);
        $("#formation").val(formation);

        var matchid = '${gameVo.matchid}';
        $("#matchid").val(matchid);
      }

      //슬라이더 부분
      $("#slider01").slider({
        range:"min",
        min:0,
        max:10,
        value:fw,
        slide:function(event,ui){
          $("#fw").val(ui.value)
        }
      });

      $("#slider02").slider({
        range:"min",
        min:0,
        max:10,
        value:mf,
        slide:function(event,ui){
          $("#mf").val(ui.value)
        }
      });

      $("#slider03").slider({
        range:"min",
        min:0,
        max:10,
        value:df,
        slide:function(event,ui){
          $("#df").val(ui.value)
        }
      });
      $("#slider04").slider({
        range:"min",
        min:0,
        max:10,
        value:org,
        slide:function(event,ui){
          $("#org").val(ui.value)
        }
      });


      $("#slider06").slider({
        range:"min",
        min:0,
        max:10,
        value:fig,
        slide:function(event,ui){
          $("#fig").val(ui.value)
        }
      });


      $("#slider08").slider({
        range:"min",
        min:0,
        max:10,
        value:setplay,
        slide:function(event,ui){
          $("#setplay").val(ui.value)
        }
      });

      $("#fw").val($("#slider01").slider("value"));
      $("#mf").val($("#slider02").slider("value"));
      $("#df").val($("#slider03").slider("value"));
      $("#org").val($("#slider04").slider("value"));
      $("#fig").val($("#slider06").slider("value"));
      $("#setplay").val($("#slider08").slider("value"));

      ///////////////////////////////////////////////////
      //툴립 스코어
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })


      $('#score').change(function(){

        var fw=0;
        var fo=0;
        var sw=0;
        var so=0;

        var wsum=0;
        var ssum=0;

        fw=$('#fhwrecord').val();
        fo=$('#fhorecord').val();
        sw=$('#shwrecord').val();
        so=$('#shorecord').val();

      });

      $('#frm').submit(function() {
        var matchid = $('#matchid').val();
        if(matchid==0){
          $('#matchidal').append('<div class="alert alert-warning alert-dismissible" role="alert">'+
                  '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
                  '대회정보를 선택해주세요.</div>');
          return false;
        }
      });

    });
  </script>

  <style type="text/css">
    .errorMsg {
      color: red;
    }
  </style>
</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>




<article>

  <section class="page-subject">
    <h3>대회경기 결과 입력</h3>
  </section>

  <spring:form method="post" action="matchupdate"  id="frm" name="frm" cssClass="form-horizontal" commandName="gameVo">
    <section style="margin: 10px" class="highlight">
      <div class="row">
        <div class="col-md-12 text-center" id="matchidal">
          <spring:errors cssStyle="margin: 5px" path="*" cssClass="errorMsg" element="div"></spring:errors>
        </div>
      </div>
      <div style="margin-top: 10px">
        <div class="form-group">
          <label for="exclass" class="col-md-2 control-label">선수구성레벨</label>
          <div class="col-md-4">
            <select  class="form-control" id="exclass" name="exclass">
              <option value="A">Class A</option>
              <option value="B">Class B</option>
              <option value="C">Class C</option>
              <option value="D">Class D</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-2 control-label"  data-toggle="tooltip" data-placement="left" title="유투브 동영상에 마우스 오른쪽 클릭 후 소스코드를 복사해주세요"
                 for="youtubesource" style="margin-bottom: 10px"><a href="https://www.youtube.com/" target="_blank">유투브 동영상소스</a></label>
          <div class="col-md-8">
            <textarea class="form-control" rows="2" name="youtubesource" id="youtubesource" placeholder="유투브 동영상소스">${gameVo.youtubesource}</textarea>
          </div>
          <div class="col-md-2">
            <button class="btn btn-info" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
              영상보기
            </button>
          </div>
        </div>

        <div class="collapse" id="collapseExample">
          <div class="form-group">
            <div class="col-md-2"></div>
            <div class="col-md-8 text-center" id="video">
                ${game.youtubesource}
            </div>
            <div class="col-md-2"></div>
          </div>
        </div>

        <div class="form-group">
          <label for="oppoteam" class="col-md-2 control-label">상대팀명</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="oppoteam" name="oppoteam" value="${gameVo.oppoteam}" required>
          </div>

          <label class="col-md-2 control-label">날씨</label>
          <div class="col-md-4">
            <select name="weather" class="form-control" id ="weather">
              <option value="맑음">맑음</option>
              <option value="흐림">흐림</option>
              <option value="비">비</option>
              <option value="눈">눈</option>
            </select>
          </div>
        </div>

        <div class="form-group" style="margin-bottom: auto">

          <label for="date" class="col-md-2 control-label">경기일시</label>
          <div class="col-md-4">
            <div class="input-group date form_datetime"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="date">
              <input class="form-control" size="16" type="text" value="${gameVo.egamedate}"  required>
              <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
              <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
            </div>
            <input type="hidden" id="date" name="date" value="${gameVo.egamedate}" /><br/>
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

          <label for="location" class="col-md-2 control-label">장소</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="location" name="location" value="${gameVo.location}" required>
          </div>
        </div>

        <div class="form-group">

          <label class="col-md-2 control-label">포메이션</label>
          <div class="col-md-4">
            <select name="formation" class="form-control" id="formation">
              <option value="A">4-4-2</option>
              <option value="B">3-5-2</option>
              <option value="C">4-5-1</option>
              <option value="D">3-6-1</option>
            </select>
          </div>

          <label for="matchid" class="col-md-2 control-label">대회정보</label>
          <div class="col-md-4">
            <select class="form-control" id="matchid" name="matchid"></select>
          </div>

          <script>

            var options = JSON.parse('${matchids}');
            var selectBox = document.getElementById('matchid');

            for(var i = 0, l = options.length; i < l; i++){
              var option = options[i];
              selectBox.options.add( new Option(option.name, option.matchid, option.selected) );
            }
          </script>

        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">FW부분</label>
          <div class="col-md-4">
            <div id="slider01" style="width: 300px;float: left; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input class="form-control text-center" min="0" max="10" step="1" type="number" id="fw" name="fw" value="${gameVo.fw}">
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">MF부분</label>
          <div class="col-md-4">
            <div id="slider02" style="width: 300px;float: left; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input class="form-control text-center" min="0" max="10" step="1" type="number" type="number" id="mf" name="mf" value="${gameVo.mf}">
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">DF부분</label>
          <div class="col-md-4">
            <div id="slider03" style="width: 300px;float: left; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input class="form-control text-center" min="0" max="10" step="1" type="number" type="number" id="df" name="df" value="${gameVo.df}">
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">체력부분</label>
          <div class="col-md-4">
            <div id="slider06" style="width: 300px;float: left; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input class="form-control text-center" min="0" max="10" step="1" type="number" type="number" id="fig" name="fig" value="${gameVo.fig}">
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">셋트플레이</label>
          <div class="col-md-4">
            <div id="slider08" style="width: 300px;float: left; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input class="form-control text-center" min="0" max="10" step="1" type="number" type="number" id="setplay" name="setplay" value="${gameVo.setplay}" >
          </div>
          <div class="col-md-4"></div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">조직력부분</label>
          <div class="col-md-4">
            <div id="slider04" style="width: 300px;float: left; margin-top: 10px"></div>
          </div>
          <div class="col-md-2">
            <input class="form-control text-center" min="0" max="10" step="1" type="number" type="number" id="org" name="org" value="${gameVo.org}" >
          </div>
          <div class="col-md-4"></div>
        </div>


        <div id ="score">
          <div class="form-group">
            <label class="col-md-2 control-label">스코어 전</label>
            <div class="col-md-4">
              <input type="number" name="fhwrecord" class="form-control" style="float: left; width: 60px" id="fhwrecord" min="0" max="20" step="1"
                     data-toggle="tooltip" data-placement="left" title="우리팀 득점" value="0"
                      >
              <input  type="number" name="fhorecord" class="form-control" style="float: left; width: 60px" id="fhorecord" min="0" max="20" step="1"
                      data-toggle="tooltip" data-placement="right" title="상대팀 득점" value="0"
                      >
            </div>

          </div>
          <div class="form-group">
            <label class="col-md-2 control-label">스코어 후</label>
            <div class="col-md-4">
              <input  type="number" name="shwrecord" class="form-control" style="float: left; width: 60px" id="shwrecord" min="0" max="20" step="1"
                      data-toggle="tooltip" data-placement="left" title="우리팀 득점" value="0"
                      required>
              <input  type="number" name="shorecord" class="form-control" style="float: left; width: 60px" id="shorecord" min="0" max="20" step="1"
                      data-toggle="tooltip" data-placement="right" title="상대팀 득점" value="0"
                      required>
            </div>

          </div>
        </div>

        <div class="form-group">
          <label for="fw_description" class="col-md-2 control-label">FW부분</label>
          <div class="col-sm-10">
            <textarea class="form-control" rows="4" name="fw_description" id="fw_description">${gameVo.fw_description}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="mf_description" class="col-md-2 control-label">MF부분</label>
          <div class="col-sm-10">
            <textarea class="form-control" rows="4" name="mf_description" id="mf_description">${gameVo.mf_description}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="df_description" class="col-md-2 control-label">DF부분</label>
          <div class="col-sm-10">
            <textarea class="form-control" rows="4" name="df_description" id="df_description">${gameVo.df_description}</textarea>
          </div>
        </div>

        <div class="form-group">
          <label for="description" class="col-md-2 control-label">경기총평</label>
          <div class="col-sm-10">
            <textarea class="form-control" rows="4" name="description" id="description">${gameVo.description}</textarea>
          </div>
        </div>
      </div>

      <input type="hidden" name="gameid" value="${gameVo.gameid}">
      <input type="hidden" name="teamid" value="${gameVo.teamid}">

      <a href="/matchgame/matchgame" class="btn btn-default" style="width: 110px">경기목록</a>
      <input type="submit" value="변경" class="btn btn-default" style="width: 110px">
      <a href="/matchgame/delete?gameid=${gameVo.gameid}" class="btn btn-default" style="width: 110px">삭제</a>
    </section>
  </spring:form>

</article>


<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
