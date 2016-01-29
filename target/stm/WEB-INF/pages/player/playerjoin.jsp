<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script type="text/javascript">
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
      frm.file.click();
    }

    $(document).ready(function(){

      $('#file').change(function(){

        $('#input1').alert('close');

        var fsize = $(this)[0].files[0].size;
        var ftype = $(this)[0].files[0].type;
        var fname = $(this)[0].files[0].name;

        if(fsize > 2048 * 2048){ //2mb
          var el = $('#wrapper');
          el.append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                  '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                  '<span aria-hidden="true">&times;</span></button>' +
                  '<strong>[주의]</strong>파일용량을 2MB 이하로 수정해서 등록해주시기 바랍니다'+
                  '</div>');

          return false;
        }

      });


      $('form').submit(function(){
        $('#input1').alert('close');

        var fileimgs = document.getElementById("file").files;

        for(var i=0 ; i < fileimgs.length; i++){
          var file = fileimgs[i];
          if(file.size > 2048 * 2048){ //2mb

            var el = $('#wrapper');
            el.append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                    '<span aria-hidden="true">&times;</span></button>' +
                    '<strong>[주의]</strong>파일용량을 2MB 이하로 수정해서 등록해주시기 바랍니다'+
                    '</div>');

            return false;
          }
        }
      });

    });

  </script>


  <style>

    .img-thumbnail {
      display: inline-block;
      /*width: 140px;*/
      /*height: 140px;*/
      /*max-width: 100%;*/
      /*height: auto;*/
      padding: 4px;
      line-height: 1.42857143;
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 4px;
      -webkit-transition: all .2s ease-in-out;
      -o-transition: all .2s ease-in-out;
      transition: all .2s ease-in-out;
    }

  </style>
</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>

  <section class="page-subject">
    <h2>선수등록</h2>
  </section>

  <form method="post" action="playerinsert" enctype="multipart/form-data" name="frm" class="form-horizontal">
    <section   class="highlight">

      <div id="wrapper" style="margin-top: 5px"></div>

      <div style="margin: 20px 20px ">
        <div class="form-group">
          <label for="preview" class="col-md-2 control-label">사진</label>
          <div class="col-md-4">
            <img width="130px" height="130px" class="img-thumbnail" id="preview" name="emblem" src="/resources/img/140+140.svg" alt="140x140">
            <input style="display:none" type="file" id="file" name="file" onchange="previewImage(this)"  accept="image/*"/>
          </div>
        </div>

        <div class="form-group">
          <div class="col-md-2"></div>
          <div class="col-md-4">
            <A style="width: 130px" class="btn btn-default" onclick=open_file(); href="#">파일찾기</A> </P>
          </div>
        </div>

        <div class="form-group">
          <label for="playername" class="col-md-2 control-label">선수이름</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="playername" name="playername" required>
          </div>

          <label for="exclass" class="col-md-2 control-label">선수레벨</label>
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
          <label class="col-md-2 control-label">공격/수비</label>
          <div class="col-md-4">
            <select name="positioncategory" class="form-control">
              <option value="공격">공격</option>
              <option value="수비">수비</option>
            </select>
          </div>

          <label class="col-md-2 control-label">포지션</label>
          <div class="col-md-4">
            <select name="positioncode" class="form-control">
              <option value="FW">FW</option>
              <option value="MF">MF</option>
              <option value="DF">DF</option>
              <option value="GK">GK</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="backnumber" class="col-md-2 control-label">등번호</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="backnumber" name="backnumber" required>
          </div>

          <label for="joindate" class="col-md-2 control-label">입단일자</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="joindate" name="joindate" required>
            <script>
              $('#joindate').datepicker({
                format: "yyyy-mm-dd",
                language: "ko",
                autoclose: true,
                todayHighlight: true
              });
            </script>
          </div>
        </div>

        <div class="form-group">
          <label class="col-md-2 control-label">소속상태</label>
          <div class="col-md-4">
            <div class="radio">
              <label>
                <input type="radio" name="status" value="Y" checked> 소속
              </label>
              <label>
                <input type="radio" name="status" value="N"> 비소속
              </label>
            </div>
          </div>

          <label for="date" class="col-md-2 control-label">퇴단일자</label>
          <div class="col-md-4">
            <input type="text" class="form-control" id="date" name="date">
            <script>
              $('#date').datepicker({
                format: "yyyy-mm-dd",
                language: "ko",
                autoclose: true,
                todayHighlight: true
              });
            </script>
          </div>


        </div>

        <div class="form-group">
          <label for="description" class="col-md-2 control-label">선수소개</label>
          <div class="col-md-4">
            <textarea class="form-control" rows="4" name="description" id="description"></textarea>
          </div>
        </div>
        <input type="hidden" value="${userkey}" name="userkey" id="userkey">
        <input type="hidden" value="${teamid}" name="teamid" id="teamid">
      </div>
    </section>

    <input type="submit" value="선수등록"  class="btn btn-default" style="width: 110px;">
    <input type="reset" value="지우기" class="btn btn-default" style="width: 110px;">
  </form>
</article>


<footer class="highlight" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
