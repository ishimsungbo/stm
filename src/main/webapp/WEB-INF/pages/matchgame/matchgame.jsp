<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>STMsoccer 대회정보</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
  <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
  <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>

  <script>
    //jquery start
    $(document).ready(function() {

      setTimeout(function () {
        $('#alert').alert('close');
      }, 3000);

      $('#search_matchid').val($('#matchid').val());
      $('#search_weather').val($('#weather').val());
      $('#search_result').val($('#result').val());
      $('#search_formation').val($('#formation').val());
      $('#search_exclass').val($('#exclass').val());
      $('#search_location').val($('#location').val());

    });

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
    <h3>대회경기조회</h3>
  </section>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>경기 정보가 정상적으로 생성 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>경기 정보가 정상적으로 삭제 되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[성공]</strong>경기 정보가 정상적으로 변경 되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="#" method="POST"  name="search">
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
          <a class="btn btn-default" href="/matchgame/matchgnew" style="width: 110px">경기입력</a>
        </div>
      </div>

      <div class="form-group">

        <label for="search_matchid" class="col-md-2 control-label">대회명</label>
        <div class="col-md-4">
          <spring:select path="matchsVo" name="search_matchid" id="search_matchid" class="form-control">
            <spring:option value="">전체</spring:option>
            <spring:options items="${matchList}" itemValue="matchid" itemLabel="name" />
          </spring:select>
        </div>

        <label for="search_location" class="col-md-2 control-label">장소</label>
        <div class="col-md-4">
          <input class="form-control" id="search_location" name="search_location" >
        </div>

      </div>

      <div class="form-group">
        <label for="search_exclass" class="col-md-2 control-label">선수구성레벨</label>
        <div class="col-md-4">
          <select  class="form-control" id="search_exclass" name="search_exclass">
            <option value="">전체</option>
            <option value="A">Class A</option>
            <option value="B">Class B</option>
            <option value="C">Class C</option>
            <option value="D">Class D</option>
          </select>
        </div>
        <div class="col-md-6"></div>
      </div>
    </form>
  </section>

  <section class="highlight_white">

    <table class="table table-hover">
      <thead>
      <tr>
        <th>경기일자</th>
        <th>상대팀명</th>
        <th>선수구성레벨</th>
        <th>스코어</th>
        <th>경기결과</th>
        <th>장소</th>
        <th>대회명</th>
        <th class="text-center">선수기록</th>
        <th class="text-center">평가입력</th>
      </tr>
      </thead>
      <!-- db data view -->
      <tbody>
      <c:if test="${list.size() != 0}">
        <c:forEach items="${list}" var="game">
          <tr>
            <td><fmt:formatDate value="${game.gamedate}" pattern="yyyy년 MM월 dd일"/></td>
            <td><a href="matchgameup?gameid=${game.gameid}">${game.oppoteam}</a></td>
            <td>
              <c:choose>
                <c:when test="${game.exclass== 'A'}">
                  Class A
                </c:when>
                <c:when test="${game.exclass== 'B'}">
                  Class B
                </c:when>
                <c:when test="${game.exclass== 'C'}">
                  Class C
                </c:when>
                <c:otherwise>
                  Class D
                </c:otherwise>
              </c:choose>
            </td>
            <td>${game.fhwrecord+game.shwrecord} : ${game.fhorecord+game.shorecord}</td>
            <td>
              <c:choose>
                <c:when test="${game.result== 'W'}">
                  승
                </c:when>
                <c:when test="${game.result== 'L'}">
                  패
                </c:when>
                <c:when test="${game.result== 'E'}">
                  무
                </c:when>
              </c:choose>
            </td>
            <td>${game.location}</td>
            <td>${game.matchname}</td>
            <td class="text-center">${game.playercount}</td>
            <td style="text-align: center; vertical-align: middle">
              <a class="btn btn-sm btn-info"  data-toggle="tooltip" data-placement="left" title="출전선수들의 경기기록[입력/수정]"
                 href="/matchgame/gameplayer?gameid=${game.gameid}&playercount=${game.playercount}">선수기록</a>
            </td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${list.size() == 0}">
        <tr>
          <td colspan="8" style="text-align: center" class="warning">등록된 경기 정보가 없습니다</td>
        </tr>
      </c:if>
      </tbody>
    </table>

    <div style="text-align: center">
      <form name="listForm" action="matchgame" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
          <input type="hidden" name="pageNo" value="${paging.pageNo}" />
          <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />

          <input type="hidden" id="matchid" name="search_matchid" value="${paging.matchid}"/>
          <input type="hidden" name="search_fromdate" value="${paging.fromdate}"/>
          <input type="hidden" name="search_todate" value="${paging.todate}" />
          <input type="hidden" name="search_oppoteam" value="${paging.oppoteam}"/>
          <input type="hidden" id="weather" name="search_weather" value="${paging.weather}"/>
          <input type="hidden" id="location" name="search_location" value="${paging.location}"/>
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
