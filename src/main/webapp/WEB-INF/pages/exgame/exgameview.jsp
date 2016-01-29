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
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <%--extend slider--%>
  <script type="text/javascript" src="/resources/jqueryextend/jquery-ui-1.10.3.custom.js"></script>
  <link rel="stylesheet" type="text/css" href="/resources/jqueryextend/jquery-ui.css">

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script>
    $(document).ready(function() {

      setTimeout(function(){
        $('#alert').alert('close');
      },3000);

      var two = $('#you');
      two.css('color','red');


      var exclass      = "<c:out value='${exgame.exclass}'/>";
      var fw =   "<c:out value='${exgame.fw}'/>";
      var mf  =   "<c:out value='${exgame.mf}'/>";
      var df    =   "<c:out value='${exgame.df}'/>";
      var org    =   "<c:out value='${exgame.org}'/>";
      var passing    =   "<c:out value='${exgame.passing}'/>";
      var fig    =   "<c:out value='${exgame.fig}'/>";
      var setplay    =   "<c:out value='${exgame.setplay}'/>";
      var shooting    =   "<c:out value='${exgame.shooting}'/>";
      var fhwrecord    =   "<c:out value='${exgame.fhwrecord}'/>";
      var fhorecord    =   "<c:out value='${exgame.fhorecord}'/>";
      var shwrecord    =   "<c:out value='${exgame.shwrecord}'/>";
      var shorecord    =   "<c:out value='${exgame.shorecord}'/>";
      var result    =   "<c:out value='${exgame.result}'/>";
      var formation    =   "<c:out value='${exgame.formation}'/>";
      var youtubesource    =   "<c:out value='${exgame.youtubesource}'/>";
      var sptrid    =   "<c:out value='${exgame.sptrid}'/>";

      $('#youtubesource').val(youtubesource);
      $('#exclass').val(exclass);
      $('#fw').val(fw);
      $('#mf').val(mf);
      $('#df').val(df);
      $('#org').val(org);
      $('#passing').val(passing);
      $('#fig').val(fig);
      $('#shooting').val(shooting);
      $('#setplay').val(setplay);

      $('#formation').val(formation);
      $('#result').val(result);

      $('#fhwrecord').val(fhwrecord);
      $('#fhorecord').val(fhorecord);
      $('#shwrecord').val(shwrecord);
      $('#shorecord').val(shorecord);
      $('#sptrid').val(sptrid);


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

      $("#slider05").slider({
        range:"min",
        min:0,
        max:10,
        value:passing,
        slide:function(event,ui){
          $("#passing").val(ui.value)
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

      $("#slider07").slider({
        range:"min",
        min:0,
        max:10,
        value:shooting,
        slide:function(event,ui){
          $("#shooting").val(ui.value)
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
      $("#passing").val($("#slider05").slider("value"));
      $("#fig").val($("#slider06").slider("value"));
      $("#shooting").val($("#slider07").slider("value"));
      $("#setplay").val($("#slider08").slider("value"));

      ///////////////////////////////////////////////////
      //툴립 스코어
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })


      $('#score').change(function(){

        var fw=$('#fhwrecord').val();
        var fo=$('#fhorecord').val();
        var sw=$('#shwrecord').val();
        var so=$('#shorecord').val();

        var wsum = fw + sw;
        var ssum = fo + so;

        if(wsum > ssum){
          $('#result').val("W");
        }else if( wsum < ssum){
          $('#result').val("L");
        }else{
          $('#result').val("E");
        }
      });

      $('#video > iframe').attr('width','480');
      $('#video > iframe').attr('height','320');
    });
  </script>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>


<article>

  <section class="page-subject">
    <h3>연습경기정보(보기/수정/삭제)</h3>
  </section>

  <c:if test="${upflag == 'Y'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 연습경기 정보가 정상적으로 업데이트 되었습니다.
    </div>
  </c:if>


  <spring:form method="post" action="/exgame/exupdate"  name="frm" cssClass="form-horizontal" modelAttribute="ExGameVo">
    <section class="highlight">

      <div class="form-group">
        <label for="exclass" class="col-md-2 control-label">선수구성레벨</label>
        <div class="col-md-3">
          <select  class="form-control" id="exclass" name="exclass">
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>
       </div>

      <div class="form-group">
        <label for="oppoteam" class="col-md-2 control-label">상대팀명</label>
        <div class="col-md-4">
          <input type="text" class="form-control" id="oppoteam" name="oppoteam" value=${exgame.oppoteam} required>
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
        <label for="exclass" class="col-md-2 control-label"><a href="https://www.youtube.com/" target="_blank">Youtube소스</a></label>
        <div class="col-md-8">
          <%--<input type="text" class="form-control" id="youtubesource" name="youtubesource"--%>
                 <%--data-toggle="tooltip" data-placement="left" title="유투브 소스를 붙여넣으세요">--%>
          <textarea class="form-control" rows="2" name="youtubesource" id="youtubesource"  data-toggle="tooltip" data-placement="left" title="유투브 소스를 붙여넣으세요"
                  >${exgame.youtubesource}</textarea>
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
              ${exgame.youtubesource}
          </div>
          <div class="col-md-2"></div>
          </div>
        </div>


      <div class="form-group">
        <label for="location" class="col-md-2 control-label">장소</label>
        <div class="col-md-4">
          <input type="text" class="form-control" id="location" name="location" value=${exgame.location} required>
        </div>

        <label for="gamedate" class="col-md-2 control-label">경기일자</label>
        <div class="col-md-4">
          <input type="text" class="form-control" id="gamedate" name="gamedate"  value="${exgame.extrgamedate}" required>
          <script>
            $('#gamedate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
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

        <label for="sptrid" class="col-md-2 control-label">전지훈련</label>
        <div class="col-md-4">
          <select class="form-control" id="sptrid" name="sptrid">
            <option value="0">없음</option>
          </select>
        </div>

      </div>

      <script>
        //          전지훈련에서의 연습게임인지 매핑해준다.
        var options = JSON.parse('${jsonList}');

        var selectBox = document.getElementById('sptrid');

        for(var i = 0, l = options.length; i < l; i++){
          var option = options[i];
          selectBox.options.add( new Option(option.textdisp, option.sptrid, option.selected) );
        }
      </script>


      <div class="form-group">
        <label class="col-md-2 control-label">FW부분</label>
        <div class="col-md-4">
          <div id="slider01" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" step="1" min="0" max="10" type="number" id="fw" name="fw">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">MF부분</label>
        <div class="col-md-4">
          <div id="slider02" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" step="1" min="0" max="10" type="number" id="mf" name="mf">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">DF부분</label>
        <div class="col-md-4">
          <div id="slider03" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" step="1" min="0" max="10" type="number" id="df" name="df">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">슈팅부분</label>
        <div class="col-md-4">
          <div id="slider07" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" step="1" min="0" max="10" type="number" id="shooting" name="shooting">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">패싱부분</label>
        <div class="col-md-4">
          <div id="slider05" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" class="form-control" step="1" min="0" max="10" type="number" id="passing" name="passing">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">체력부분</label>
        <div class="col-md-4">
          <div id="slider06" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" step="1" min="0" max="10" type="number" id="fig" name="fig">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">Set play</label>
        <div class="col-md-4">
          <div id="slider08" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input  class="form-control text-center" step="1" min="0" max="10" type="number" id="setplay" name="setplay">
        </div>
        <div class="col-md-4"></div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label">조직력부분</label>
        <div class="col-md-4">
          <div id="slider04" style="width: 300px;float: left; margin-top: 10px"></div>
        </div>
        <div class="col-md-2">
          <input class="form-control text-center" step="1" min="0" max="10" type="number" id="org" name="org">
        </div>
        <div class="col-md-5"></div>
      </div>


      <div id ="score">
        <div class="form-group">
          <label class="col-md-2 control-label">스코어 전</label>
          <div class="col-md-4">
            <input type="number" name="fhwrecord" class="form-control" style="float: left; width: 60px" id="fhwrecord" min="0" max="20" step="1"
                   data-toggle="tooltip" data-placement="left" title="우리팀 득점" value="0"
                   required>
            <input  type="number" name="fhorecord" class="form-control" style="float: left; width: 60px" id="fhorecord" min="0" max="20" step="1"
                    data-toggle="tooltip" data-placement="right" title="상대팀 득점" value="0"
                    required>
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

          <label class="col-md-2 control-label">경기결과</label>
          <div class="col-md-2">
            <select name="result" class="form-control" id="result">
              <option value="W">승</option>
              <option value="L">패</option>
              <option value="E" selected>무</option>
            </select>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label for="objectpoint" class="col-md-2 control-label">목표(지도포인트)</label>
        <div class="col-sm-4">
          <textarea class="form-control" rows="5" name="objectpoint" id="objectpoint">${exgame.objectpoint}</textarea>
        </div>

        <label for="fw_description" class="col-md-2 control-label">FW부분</label>
        <div class="col-sm-4">
          <textarea class="form-control" rows="5" name="fw_description" id="fw_description">${exgame.fw_description}</textarea>
        </div>
      </div>

      <div class="form-group">
        <label for="mf_description" class="col-md-2 control-label">MF부분</label>
        <div class="col-sm-4">
          <textarea class="form-control" rows="5" name="mf_description" id="mf_description">${exgame.mf_description}</textarea>
        </div>

        <label for="df_description" class="col-md-2 control-label">DF부분</label>
        <div class="col-sm-4">
          <textarea class="form-control" rows="5" name="df_description" id="df_description">${exgame.df_description}</textarea>
        </div>
      </div>

      <div class="form-group">
        <label for="description" class="col-md-2 control-label">경기총평</label>
        <div class="col-sm-10">
          <textarea class="form-control" rows="3" name="description" id="description">${exgame.description}</textarea>
        </div>
      </div>
      </div>
      <input type="hidden" id="exgameid" name="exgameid" value=${exgame.exgameid}>
    </section>
    <a href="/exgame/exgamemain" class="btn btn-default" style="width: 110px">경기목록</a>
    <input type="submit" value="변경" class="btn btn-default" style="width: 110px">
    <a href="/exgame/delete?exgameid=${exgame.exgameid}" class="btn btn-default" style="width: 110px">삭제</a>
  </spring:form>
</article>

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
