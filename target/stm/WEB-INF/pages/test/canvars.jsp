<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>image</title>
  <meta name="viewport" content="initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="/resources/test/canvas2image.js"></script>
  <script type="text/javascript" src="/resources/test/base64.js"></script>
</head>
<body>
<div>
  <img id="img" src="/resources/test/banner1.jpg" border="0" />
  <p>여기는 무엇이지?</p>
  <canvas id="canvas" width="200" height="200" style="border:2px solid red;">
  </canvas>
</div>
<div>
  <button id="btnImgFill" onclick="imgFill();">이미지 넣기</button>
  <button id="btnImgSave" onclick="imgSave();">이미지 저장하기</button>
</div>

<form id="imgForm" action="/test/saveimg" method="post" target="ifrm">

  <input type="hidden" name="data" id="data" />

</form>

<iframe name="ifrm" width="0" height="0" style="display:none"></iframe>




<script type="text/javascript">

  oCanvas = document.getElementById("canvas");

  image = document.getElementById("img");

  ctx = oCanvas.getContext("2d");




  function imgFill() {

    $("#canvas").attr("width", $("#img").css("width"));

    $("#canvas").attr("height", $("#img").css("height"));



    ctx.drawImage(image, 0, 0, image.width, image.height);

    ctx.fillStyle = "#000000";  // 검정색

    ctx.font = "bold 20pt '맑은 고딕'";

    ctx.textBaseline = "top";

    ctx.fillText("1회차 2013.07.07", 0, 0);

    ctx.fillText("홈런왕 유니폼 당첨번호:010-0000-0000", 0, 30);

  }

  function imgSave() {

    //Canvas2Image.saveAsPNG(oCanvas);



    $("#data").val(oCanvas.toDataURL("image/png"));

    $("#imgForm").submit();

  }

</script>




</body>

</html>