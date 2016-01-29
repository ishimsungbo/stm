<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 팀회의 생성</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <%--  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
    <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
    <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>--%>

  <%--datetimepicker--%>
  <link rel="stylesheet" href="/resources/datetimepicker/css/bootstrap-datetimepicker.min.css">
  <script type="text/javascript" src="/resources/datetimepicker/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
  <script type="text/javascript" src="/resources/datetimepicker/js/locales/bootstrap-datetimepicker.ko.js" charset="UTF-8"></script>

  <script src="/resources/nvediter/js/HuskyEZCreator.js"></script>

  <script>
    //jquery start
    $(document).ready(function() {
      //스마트 에디터
      $(function(){
        //전역변수선언
        var editor_object = [];

        nhn.husky.EZCreator.createInIFrame({
          oAppRef: editor_object,
          elPlaceHolder: "content",
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
          editor_object.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

          // 이부분에 에디터 validation 검증

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
    <h3>팀회의 입력</h3>
  </section>

  <form method="post" action="/trjournals/dbinsert"  name="frm" class="form-horizontal" modelAttribute="meetingVo">
    <section class="highlight_white">

      <div class="form-group" style="margin-bottom: auto">
        <label for="exfromdate" class="col-md-2 control-label">회의일자</label>
        <div class="col-md-3">
          <div class="input-group date exfromdate"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="exfromdate" required>
            <input class="form-control" size="16" type="text">
            <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
          </div>
          <input type="hidden" id="exfromdate" name="exfromdate" /><br/>
          <script>
            $('.exfromdate').datetimepicker({
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

        <div class="col-md-3">
          <div class="input-group date extodate"  data-date-format="yyyy-mm-dd hh:ii" data-link-field="extodate" required>
            <input class="form-control" size="16" type="text">
            <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
          </div>
          <input type="hidden" id="extodate" name="extodate" /><br/>
          <script>
            $('.extodate').datetimepicker({
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
        <div class="col-md-2"></div>
      </div>

      <div class="form-group">
        <label for="subject" class="col-md-2 control-label">회의주제</label>
        <div class="col-md-10">
          <input type="text" class="form-control" id="subject" name="subject" required>
        </div>
      </div>

      <div class="form-group">
        <label for="meetingtype" class="col-md-2 control-label">회의종류</label>
        <div class="col-md-4">
          <select  class="form-control" id="meetingtype" name="meetingtype" required>
            <option value="A" selected>정기회의</option>
            <option value="B">대회준비</option>
            <option value="C">전지훈련</option>
            <option value="D">기타</option>
          </select>
        </div>

        <label for="scheduleflag" class="col-md-2 control-label">스케줄생성</label>
        <div class="col-md-4">
          <div class="radio" id="scheduleflag">
            <label>
              <input type="radio" name="scheduleflag" value="Y" checked> Yes
            </label>
            <label>
              <input type="radio" name="scheduleflag" value="N"> No
            </label>
          </div>
        </div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label" for="participant">참석자</label>
        <div class="col-md-10">
          <textarea class="form-control" rows="2" name="participant" id="participant" required></textarea>
        </div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label" for="content">회의내용</label>
        <div class="col-md-10">
          <textarea class="form-control" name="content" id="content" rows="12" cols="100"></textarea>
        </div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label" for="description">기타사항</label>
        <div class="col-md-10">
          <textarea class="form-control" name="description" id="description" rows="3"></textarea>
        </div>
      </div>

    </section>
    <input type="submit" id="savebutton" class="btn btn-default" value="등록" style="width: 110px"/>
    <input type="reset"  value="지우기" class="btn btn-default" style="width: 110px">
  </form>

</article>


<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
