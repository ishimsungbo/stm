<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 훈련프로그램</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script src="/resources/nvediter/js/HuskyEZCreator.js"></script>

  <script type="text/javascript">
    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();
    }

    //jquery start
    $(document).ready(function() {

      /*
       setTimeout(function(){
       $('#alert').alert('close');
       },3000);

       //이전에 조회 값을 넣었다면..
       $('#search_weather').val($('#weather').val());
       $('#search_result').val($('#result').val());
       $('#search_formation').val($('#formation').val());
       $('#search_exclass').val($('#exclass').val());
       */

      //스마트 에디터
      $(function(){
        //전역변수선언
        var editor_object = [];

        nhn.husky.EZCreator.createInIFrame({
          oAppRef: editor_object,
          elPlaceHolder: "description",
          sSkinURI: "/resources/nvediter/SmartEditor2Skin.html",
          htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
          }
        });

        //전송버튼 클릭이벤트
        $("#savebutton").click(function(){
          //id가 smarteditor인 textarea에 에디터에서 대입
          editor_object.getById["description"].exec("UPDATE_CONTENTS_FIELD", []);

          // 이부분에 에디터 validation 검증
          if($("#trname").val()==""){
            $("#trname").focus();
            alert("훈련제목은 필수 값입니다. 입력해주세요");
            return false;
          }

          //폼 submit
          $("#frm").submit();
        })
      })


    });
  </script>
</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>훈련프로그램 생성</h3>
  </section>


  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[삭제]</strong> 훈련프로그램이 삭제되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[생성]</strong> 훈련프로그램이 저장되었습니다.
    </div>
  </c:if>


  <spring:form action="/traninig/dbinsert" method="post" id="frm" class="form-horizontal">
  <section class="highlight_white">
      <fieldset>
        <legend>훈련기본정보</legend>
        <div class="form-group">
          <label for="trname" class="col-md-2 control-label">훈련제목</label>
          <div class="col-md-10">
            <input type="text" class="form-control" id="trname" name="trname" placeholder="훈련 제목/이름" required>
          </div>
        </div>

        <div class="form-group">
          <label for="trtype" class="col-md-2 control-label">유형</label>
          <div class="col-md-4">
            <select  class="form-control" id="trtype" name="trtype" required>
              <option value="O">전체</option>
              <option value="A">경기</option>
              <option value="B">패스</option>
              <option value="C">슈팅</option>
              <option value="D">드리블</option>
              <option value="E">체력</option>
              <option value="F">코디네이션</option>
              <option value="G">레크레이션</option>
            </select>
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
          <label class="col-md-2 control-label" for="description">설명</label>
          <div class="col-md-10">
            <textarea class="form-control" name="description" id="description" rows="10" cols="100"></textarea>
          </div>
        </div>

      </fieldset>


      <fieldset>
        <legend>배치정보</legend>
        <div class="form-group">
          <label for="fieldermen" class="col-md-2 control-label">필드선수(인원)</label>
          <div class="col-md-4">
            <input type="number"  class="form-control" id="fieldermen" name="fieldermen" min="0" max="100" step="1" value="0">
          </div>
          <label for="keepermen" class="col-md-2 control-label">골키퍼(인원)</label>
          <div class="col-md-4">
            <input type="number"  class="form-control" id="keepermen" name="keepermen" min="0" max="100" step="1" value="0">
          </div>
        </div>

        <div class="form-group">
          <label for="spacex" class="col-md-2 control-label">공간:가로(meter)</label>
          <div class="col-md-4">
            <input type="number"  class="form-control" id="spacex" name="spacex"  step="1" value="0">
          </div>
          <label for="spacey" class="col-md-2 control-label">공간:세로(meter)</label>
          <div class="col-md-4">
            <input type="number"  class="form-control" id="spacey" name="spacey"  step="1" value="0">
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>훈련 프로그램 의도(목표/전술/기술)</legend>
        <div class="form-group">
          <label class="col-md-2 control-label" for="trobject" style="margin-bottom: 10px">코칭 포인트</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="3" name="trobject" id="trobject" placeholder="주요 코칭 요소 기술" required></textarea>
          </div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label" for="trattackobject">공격 목표</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="3" name="trattackobject" id="trattackobject"></textarea>
          </div>
          <label class="col-md-2 control-label" for="defenceobject">수비 목표</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="3" name="defenceobject" id="defenceobject"></textarea>
          </div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label" for="attacktactics">사용되는 공격전술</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="5" name="attacktactics" id="attacktactics"></textarea>
          </div>
          <label class="col-md-2 control-label" for="defencetactics">사용되는 수비전술</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="5" name="defencetactics" id="defencetactics"></textarea>
          </div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label" for="attackskill">사용되는 공격기술</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="5" name="attackskill" id="attackskill"></textarea>
          </div>
          <label class="col-md-2 control-label" for="defenceskill">사용되는 수비기술</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="5" name="defenceskill" id="defenceskill"></textarea>
          </div>
        </div>
      </fieldset>

      <fieldset>
        <legend>훈련규칙</legend>
        <div class="form-group">
          <label class="col-md-2 control-label" for="trruletime">훈련시간(분)</label>
          <div class="col-md-2">
            <input type="number" id="trruletime" name="trruletime" class="form-control"min="0" max="180" step="5" value="0">
          </div>
          <label class="col-md-2 control-label" for="breaktime">휴식시간</label>
          <div class="col-md-2">
            <input type="number" id="breaktime" name="breaktime" class="form-control"min="0" max="180" step="5" value="0">
          </div>
          <label class="col-md-2 control-label" for="excuteset">반복세트</label>
          <div class="col-md-2">
            <input type="number" id="excuteset" name="excuteset" class="form-control"min="0" max="10" step="1" value="0">
          </div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label" for="youtubesource" style="margin-bottom: 10px">유투브 동영상소스</label>
          <div class="col-md-10">
            <textarea class="form-control" rows="2" name="youtubesource" id="youtubesource" placeholder="유투브 동영상소스"></textarea>
          </div>
        </div>

        <legend>기타정보</legend>

        <div class="form-group">
          <label class="col-md-2 control-label" for="injurypotential">부상위험도</label>
          <div class="col-md-2">
            <select  class="form-control" id="injurypotential" name="injurypotential">
              <option value="G">상</option>
              <option value="F">중</option>
              <option value="P" selected>하</option>
                <%--Good, fair, poor--%>
            </select>
          </div>

          <label class="col-md-2 control-label" for="importance">훈련중요도</label>
          <div class="col-md-2">
            <select  class="form-control" id="importance" name="importance">
              <option value="G">상</option>
              <option value="F">중</option>
              <option value="P" selected>하</option>
                <%--Good, fair, poor--%>
            </select>
          </div>

          <label class="col-md-2 control-label" for="strength">훈련강도</label>
          <div class="col-md-2">
            <select  class="form-control" id="strength" name="strength">
              <option value="G">상</option>
              <option value="F">중</option>
              <option value="P" selected>하</option>
                <%--Good, fair, poor--%>
            </select>
          </div>
        </div>
      </fieldset>
  </section>
  <input type="button" class="btn btn-default" id="savebutton" value="등록" style="width: 110px; float: left"/>
  <input type="reset" value="지우기" class="btn btn-default" style="width: 110px">
  </spring:form>
    </article>

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>
</body>
</html>
