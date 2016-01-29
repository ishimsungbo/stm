<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 연습경기</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script type="text/javascript">
    function goPage(pageNo){
      document.listForm.pageNo.value = pageNo;
      document.listForm.submit();
    }

    //jquery start
    $(document).ready(function() {

      setTimeout(function(){
        $('#alert').alert('close');
      },3000);

      //이전에 조회 값을 넣었다면..
      $('#search_weather').val($('#weather').val());
      $('#search_result').val($('#result').val());
      $('#search_formation').val($('#formation').val());
      $('#search_exclass').val($('#exclass').val());

      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
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
    <h3>연습경기</h3>
  </section>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 연습경기 정보가 정상적으로 생성 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong> 연습경기 정보가 정상적으로 삭제 되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="#" method="POST"  name="search">
      <%--1열--%>
      <div class="form-group">
        <label for="search_fromdate" class="col-md-2 control-label">경기일자</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="search_fromdate" name="search_fromdate" value="${paging.fromdate}">
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
          <input type="text" class="form-control" id="search_todate" name="search_todate" value="${paging.todate}">
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
          <a class="btn btn-default" href="exinsert" style="width: 110px">입력</a>
        </div>
      </div>

      <%--2열--%>
      <div class="form-group">
        <label for="search_oppoteam" class="col-md-2 control-label">상대팀명</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="search_oppoteam" name="search_oppoteam" value="${paging.oppoteam}">
        </div>

        <label for="search_exclass" class="col-md-2 control-label">선수구성레벨</label>
        <div class="col-md-2">
          <select  class="form-control" id="search_exclass" name="search_exclass">
            <option value="">전체</option>
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>

        <label class="col-md-2 control-label">날씨</label>
        <div class="col-md-2">
          <select id ="search_weather" name="search_weather" class="form-control">
            <option value="">전체</option>
            <option value="맑음">맑음</option>
            <option value="흐림">흐림</option>
            <option value="비">비</option>
            <option value="눈">눈</option>
          </select>
        </div>

      </div>

      <%--3열--%>
      <div class="form-group">
        <label for="search_location" class="col-md-2 control-label">장소</label>
        <div class="col-md-2">
          <input type="text" class="form-control" id="search_location" name="search_location"  value="${paging.location}">
        </div>

        <label class="col-md-2 control-label">포메이션</label>
        <div class="col-md-2">
          <select id="search_formation" name="search_formation" class="form-control">
            <option value="">전체</option>
            <option value="A">4-4-2</option>
            <option value="B">3-5-2</option>
            <option value="C">4-5-1</option>
            <option value="D">3-6-1</option>
          </select>
        </div>

        <label class="col-md-2 control-label">경기결과</label>
        <div class="col-md-2">
          <select id="search_result" name="search_result" class="form-control">
            <option value="">전체</option>
            <option value="W">승</option>
            <option value="L">패</option>
            <option value="E">무</option>
          </select>
        </div>

      </div>

    </form>
</section>
  <section class="highlight_white">
    <table class="table table-hover">
      <thead>
      <tr>
        <th>연습경기일자</th>
        <th>상대팀명</th>
        <th>선수구성레벨</th>
        <th>스코어</th>
        <th>경기결과</th>
        <th>장소</th>
        <th class="text-center">선수기록</th>
        <th class="text-center">평가입력</th>
      </tr>
      </thead>
      <!-- db data view -->
      <tbody>
      <c:if test="${list.size() != 0}">
        <c:forEach items="${list}" var="Exgame">
          <tr>
            <td><fmt:formatDate value="${Exgame.exgamedate}" pattern="yyyy년 MM월 dd일"/></td>
            <td><a href="exgameview?exgameid=${Exgame.exgameid}">${Exgame.oppoteam}</a></td>
            <td>
              <c:choose>
                <c:when test="${Exgame.exclass== 'A'}">
                  Class A
                </c:when>
                <c:when test="${Exgame.exclass== 'B'}">
                  Class B
                </c:when>
                <c:when test="${Exgame.exclass== 'C'}">
                  Class C
                </c:when>
                <c:otherwise>
                  Class D
                </c:otherwise>
              </c:choose>
            </td>
            <td>${Exgame.fhwrecord+Exgame.shwrecord} : ${Exgame.fhorecord+Exgame.shorecord}</td>
            <td>
              <c:choose>
                <c:when test="${Exgame.result== 'W'}">
                  승
                </c:when>
                <c:when test="${Exgame.result== 'L'}">
                  패
                </c:when>
                <c:when test="${Exgame.result== 'E'}">
                  무
                </c:when>
              </c:choose>
            </td>
            <td>${Exgame.location}</td>
            <td class="text-center">${Exgame.playercount}</td>
            <td style="text-align: center; vertical-align: middle">
              <a class="btn btn-sm btn-info"  data-toggle="tooltip" data-placement="left" title="출전선수들의 경기기록[입력/수정]"
                 href="/playergame/playerinsert?exgameid=${Exgame.exgameid}&playercount=${Exgame.playercount}">선수기록</a>
            </td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${list.size() == 0}">
        <tr>
          <td colspan="8" style="text-align: center" class="warning">등록된 연습경기 정보가 없습니다</td>
        </tr>
      </c:if>
      </tbody>
    </table>

    <div style="text-align: center">
      <form name="listForm" action="exgamemain" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />

          <input type="hidden" name="search_fromdate" value="${paging.fromdate}"/>
          <input type="hidden" name="search_todate" value="${paging.todate}" />
          <input type="hidden" name="search_oppoteam" value="${paging.oppoteam}"/>
          <input type="hidden" id="weather" name="search_weather" value="${paging.weather}"/>
          <input type="hidden" name="search_location" value="${paging.location}"/>
          <input type="hidden" id="result" name="search_result" value="${paging.result}"/>
          <input type="hidden" id="formation" name="search_formation" value="${paging.formation}"/>
          <input type="hidden" id="exclass" name="search_exclass" value="${paging.exclass}"/>

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

<footer class="stm-footer" style="margin-top: 10px">
  <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
