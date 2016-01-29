<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>팀생성</title>
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
                  '<strong>파일용량을 2MB 이하로 수정해서 등록해주시기 바랍니다</strong>'+
                  '</div>');

          return false;
        }

      });


      $('form').submit(function(){
        $('#input1').alert('close');

        var fileimgs = document.getElementById("file").files;

        for(var i=0 ; i < fileimgs.length; i++){
          var file = fileimgs[i];
          if(file.size > 500 * 500){ //2mb

            var el = $('#wrapper');
            el.append('<div id="input1" class="alert alert-danger alert-dismissible" role="alert">' +
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                    '<span aria-hidden="true">&times;</span></button>' +
                    '<strong>파일용량을 2MB 이하로 수정해서 등록해주시기 바랍니다</strong>'+
                    '</div>');

            return false;
          }
        }
      });

    });


  </script>

</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h2>팀 정보 등록</h2>
  </section>
  <section style="margin: 10px" class="highlight">

    <div id="wrapper" style="margin-top: 5px"></div>

    <form method="post" action="/dbwork/teaminsert" enctype="multipart/form-data" name="frm" class="form-horizontal">
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
          <label for="name" class="col-sm-2 control-label">팀명칭</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="name" name="name" placeholder="ex.팀 명칭" required>
          </div>
        </div>

        <div class="form-group">
          <label for="addr" class="col-sm-2 control-label">팀주소</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="addr" name ="addr" placeholder="ex.팀 주소" required>
          </div>
        </div>

        <div class="form-group">
          <label for="teamtype" class="col-sm-2 control-label">팀종목</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="teamtype" name="teamtype"  value="축구" placeholder="ex.축구">
          </div>
        </div>

        <div class="form-group">
          <label class="col-sm-2 control-label">팀단위</label>
          <div class="col-sm-5">
            <select name="type" class="form-control">
              <option value="12">12세미만</option>
              <option value="12">12세</option>
              <option value="15">15세</option>
              <option value="18">18세</option>
              <option value="20">20세</option>
              <option value="초등학교">초등학교</option>
              <option value="중학교">중학교</option>
              <option value="고등학교">고등학교</option>
              <option value="대학교">대학교</option>
              <option value="기타">기타</option>
            </select>
            <%--<input type="text" class="form-control" id="type" name ="type" placeholder="ex.고등학교" required>--%>
          </div>
        </div>

        <div class="form-group">
          <label for="phone" class="col-sm-2 control-label">팀 전화</label>
          <div class="col-sm-5">
            <input type="tel" class="form-control" id="phone" name="phone" placeholder="ex.02-000-0000" required>
          </div>
        </div>

        <div class="form-group">
          <label for="foundationDate" class="col-sm-2 control-label">팀 창단일자</label>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="foundationDate" name="foundationDate" required>
            <script>
              $('#foundationDate').datepicker({
                format: "yyyy-mm-dd",
                language: "ko",
                autoclose: true,
                todayHighlight: true
              });
            </script>
          </div>
        </div>

        <div class="form-group">
          <label for="description" class="col-sm-2 control-label">팀 설명</label>
          <div class="col-sm-5">
            <textarea class="form-control" rows="3" name="description" id="description" placeholder="팀에 대한 간단한 소개 및 설명"></textarea>
          </div>
        </div>

        <div class="row">
          <div class="col-md-2"></div>
          <div class="col-md-3"><input type="submit" value="팀등록"  class="btn btn-default" style="width: 150px"></div>
        </div>
        <input type="hidden" value="${userkey}" name="userkey" id="userkey">
      </div>
    </form>


  </section>
</article>


<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
