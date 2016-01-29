<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 팀선수정보</title>
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
      upfrm.file.click();
    }

    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();
    }

  </script>


</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>선수 목록</h3>
  </section>

  <section class="highlight">
    <form class="form-horizontal" action="/player/playermain" method="POST"  name="search">

      <div class="row">
        <div class="col-md-2 text-right">
          <h5>입단일자</h5>
        </div>
        <div class="col-md-2">
          <%--<input type="date" class="form-control" name="fromdate" id="fromdate" style="width: 155px;float: left">--%>
          <input type="text" class="form-control" name="search_fromdate" id="search_fromdate" style="width: 155px;float: left" data-provide="datepicker" value="${paging.fromdate}">
          <script>
            $('#search_fromdate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>
        <div class="col-md-2">
          <%--<input type="date" class="form-control" name="todate" id="todate" style="width: 155px;float: left">--%>
          <input type="text" class="form-control" name="search_todate" id="search_todate" style="width: 155px;float: left" data-provide="datepicker" value="${paging.todate}">
          <script>
            $('#search_todate').datepicker({
              format: "yyyy-mm-dd",
              language: "ko",
              autoclose: true,
              todayHighlight: true
            });
          </script>
        </div>
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <button type="submit" class="btn btn-default" style="width: 110px">검색</button>
          <a class="btn btn-default" href="playerjoin" style="width: 110px">선수등록</a>
        </div>
      </div>

      <div class="row" style="margin-top: 10px">
        <div class="col-md-2 text-right"><h5>선수레벨</h5></div>
        <div class="col-md-2">
          <select  class="form-control" id="search_exclass" name="search_exclass">
            <option value="">Class 전체</option>
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>
        <div class="col-md-2 text-right"><h5>포지션</h5></div>
        <div class="col-md-2">
          <select id="search_positioncode" name="search_positioncode" class="form-control">
            <option value="">포지션 전체</option>
            <option value="FW">FW</option>
            <option value="MF">MF</option>
            <option value="DF">DF</option>
            <option value="GK">GK</option>
          </select>
        </div>
        <div class="col-md-2 text-right"><h5>소속상태</h5></div>
        <div class="col-md-2">
          <div class="radio">
            <label>
              <input type="radio" name="search_status" value="Y"> 소속
            </label>
            <label>
              <input type="radio" name="search_status" value="N"> 비소속
            </label>
          </div>
        </div>
      </div>
    </form>
  </section>

  <section  class="highlight_white">
    <script>
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
    </script>
    <table class="table table-hover">
      <thead>
      <tr>
        <th>사진</th>
        <th>이름</th>
        <th>공격/수비</th>
        <th>포지션</th>
        <th>선수레벨</th>
        <th>입단일자</th>
        <th>연습경기</th>
        <th>대회경기</th>
        <th>정기평가</th>
        <th>개인코칭</th>
      </tr>
      </thead>

      <tbody>
      <c:if test="${list.size() != 0}">
        <c:forEach items="${list}" var="plyear">
          <tr>
            <td><img data-toggle="tooltip" data-placement="left" title="${plyear.description}"
                     src="/resources/img/player/${plyear.picture}" alt="${plyear.picture}" width="50px" height="50px" /></td>

            <td>
              <%--data-toggle="modal" data-target="#myModal" id="playerclick" data-whatever="${plyear.playerid}" 창내림기능--%>
              <h5>
                <a href="/player/playerinfo?playerid=${plyear.playerid}">${plyear.playername}</a>
              </h5>
            </td>

            <td>${plyear.positioncategory}</td>
            <td>${plyear.positioncode}</td>
            <td>
              <c:choose>
                <c:when test="${plyear.exclass== 'A'}">
                  Class A
                </c:when>
                <c:when test="${plyear.exclass== 'B'}">
                  Class B
                </c:when>
                <c:when test="${plyear.exclass== 'C'}">
                  Class C
                </c:when>
                <c:otherwise>
                  Class D
                </c:otherwise>
              </c:choose>
            </td>
            <td><fmt:formatDate value="${plyear.joindate}" pattern="yyyy-MM-dd"/></td>
            <td>${plyear.exgamecount}</td>
            <td>${plyear.gamecount}</td>
            <td>${plyear.evcount}</td>
            <td>${plyear.coachingcount}</td>
          </tr>
        </c:forEach>
      </c:if>

      <c:if test="${list.size() == 0}">
        <tr><td colspan="10" style="text-align: center" class="warning">등록된 선수정보가 존재하지 않습니다.</td></tr>
      </c:if>
      </tbody>
    </table>

    <div style="text-align: center">
      <form name="listForm" action="playermain" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />
          <input type="hidden" id="p_exclass" name="search_exclass" value="${paging.exclass}" />
          <input type="hidden" id="p_positioncode" name="search_positioncode" value="${paging.positioncode}" />
          <input type="hidden" id="p_status" name="search_status" value="${paging.status}" />
          <input type="hidden" name="search_fromdate" value="${paging.fromdate}" />
          <input type="hidden" name="search_todate" value="${paging.todate}" />

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
      </form>
    </div>

  </section>

</article>

<footer>
</footer>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body">
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
                <h5>소속상태</h5>
              </div>
              <div class="col-md-4">
                <div class="radio">
                  <label>
                    <input type="radio" name="status" value="Y"> 소속
                  </label>
                  <label>
                    <input type="radio" name="status" value="N"> 비소속
                  </label>
                </div>
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
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="change">변경</button>
      </div>
    </div>
  </div>
</div>

<script>
  $(document).ready(function() {


    $('#search_exclass').val($('#p_exclass').val());
    $('#search_positioncode').val($('#p_positioncode').val());
    //$('#search_status').val($('#p_status').val());
    if($('#p_status').val()=='Y'){
      $("input:radio[name='search_status']:radio[value='Y']").attr('checked', true);
    }else if($('#p_status').val()=='N'){
      $("input:radio[name='search_status']:radio[value='N']").attr('checked', true);
    }


    $('#change').click(function() {
      $('#upfrm').submit();
    });


    $('#myModal').on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget) // Button that triggered the modal
      var recipient = button.data('whatever') // Extract info from data-* attributes
      // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
      // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
      var modal = $(this);

      $.ajax({
        url : "/ajax/getplayer",
        type: "get",
        data : { "id" : recipient },

        success : function(data){
          $("#ajax").remove();
          console.log(data);
          if(!data){
            alert("존재하지 않는 ID입니다");
            return false;
          }
          modal.find('.modal-title').text('Player Information : '+data.playername);

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
        }

      }); //ajax end


    })


  });

</script>

<footer class="stm-footer">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
