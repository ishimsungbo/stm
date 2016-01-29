<%--
  Created by IntelliJ IDEA.
  User: sungbo
  Date: 2015-12-18
  Time: 오후 3:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>에디터 테스트</title>
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/nvediter/js/HuskyEZCreator.js"></script>


</head>
<body>

<form action="/webtest/send" method="post" id="frm">
  <textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;"></textarea>
  <input type="button" id="savebutton" value="서버전송" />
</form>

<script>
  $(document).ready(function() {

    $(function(){
      //전역변수선언
      var editor_object = [];

      nhn.husky.EZCreator.createInIFrame({
        oAppRef: editor_object,
        elPlaceHolder: "smarteditor",
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
        alert('전송?');

        //id가 smarteditor인 textarea에 에디터에서 대입
        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);

        // 이부분에 에디터 validation 검증

        //폼 submit
        $("#frm").submit();
      })
    })

  })

</script>

</body>
</html>
