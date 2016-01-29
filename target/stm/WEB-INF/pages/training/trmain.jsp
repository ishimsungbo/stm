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

      $('#search_trtype').val($('#trtype').val());
      $('#search_exclass').val($('#exclass').val());
      $('#search_injurypotential').val($('#injurypotential').val());
      $('#search_importance').val($('#importance').val());
      $('#search_strength').val($('#strength').val());



    });
  </script>
</head>

<body class="stmbody">
<header>
  <%@ include file="../headerpage.jsp"%>
</header>

<article>
  <section class="page-subject">
    <h3>훈련프로그램</h3>
  </section>

  <c:if test="${upflag == 'D'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[삭제]</strong> 훈련프로그램이 삭제되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'I'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[생성]</strong> 훈련프로그램이 저장되었습니다.
    </div>
  </c:if>

  <c:if test="${upflag == 'U'}">
    <div class="alert alert-success alert-dismissible" role="alert" id="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong>[변경]</strong> 훈련프로그램이 변경되었습니다.
    </div>
  </c:if>

  <section class="highlight">
    <form class="form-horizontal" action="/training/trmain" method="POST"  name="search">
      <%--1열--%>
      <div class="form-group">
        <label for="search_trname" class="col-md-2 control-label">훈련제목</label>
        <div class="col-md-6">
          <input type="text" class="form-control" id="search_trname" name="search_trname" value="${trainingProDto.trname}">
        </div>
        <div class="col-md-4">
          <button type="submit" class="btn btn-default" style="width: 110px">검색</button>
          <a class="btn btn-default" href="/training/trinsert" style="width: 110px">입력</a>
        </div>
      </div>

        <div class="form-group">
          <label for="search_trtype" class="col-md-2 control-label">유형</label>
          <div class="col-md-2">
            <select  class="form-control" id="search_trtype" name="search_trtype">
              <option value="">모두</option>
              <option value="A">경기</option>
              <option value="B">패스</option>
              <option value="C">슈팅</option>
              <option value="D">드리블</option>
              <option value="E">체력</option>
              <option value="F">코디네이션</option>
              <option value="G">레크레이션</option>
            </select>
          </div>

          <label for="search_exclass" class="col-md-2 control-label">선수레벨</label>
          <div class="col-md-2">
            <select  class="form-control" id="search_exclass" name="search_exclass">
              <option value="" selected>모두</option>
              <option value="O">전체대상</option>
              <option value="A">Class A</option>
              <option value="B">Class B</option>
              <option value="C">Class C</option>
              <option value="D">Class D</option>
            </select>
          </div>

            <label class="col-md-2 control-label" for="search_trruletime">훈련시간(분이상)</label>
            <div class="col-md-2">
              <input type="number" id="search_trruletime" name="search_trruletime" class="form-control"min="0" max="180" step="5" value="${trainingProDto.trruletime}">
            </div>

        </div>

        <div class="form-group">
          <label class="col-md-2 control-label" for="search_injurypotential">부상위험도</label>
          <div class="col-md-2">
            <select  class="form-control" id="search_injurypotential" name="search_injurypotential">
              <option value="G">상</option>
              <option value="F">중</option>
              <option value="P">하</option>
              <option value="" selected>모두</option>
              <%--Good, fair, poor--%>
            </select>
          </div>

          <label class="col-md-2 control-label" for="search_importance">훈련중요도</label>
          <div class="col-md-2">
            <select  class="form-control" id="search_importance" name="search_importance">
              <option value="G">상</option>
              <option value="F">중</option>
              <option value="P">하</option>
              <option value="" selected>모두</option>
              <%--Good, fair, poor--%>
            </select>
          </div>

          <label class="col-md-2 control-label" for="search_strength">훈련강도</label>
          <div class="col-md-2">
            <select  class="form-control" id="search_strength" name="search_strength">
              <option value="G">상</option>
              <option value="F">중</option>
              <option value="P">하</option>
              <option value="" selected>모두</option>
              <%--Good, fair, poor--%>
            </select>
          </div>
        </div>
    </form>
  </section>

  <section class="highlight_white">

    <table class="table table-hover">
      <thead>
      <tr>
        <th>훈련제목</th>
        <th>훈련활용횟수</th>
        <th>유형</th>
        <th>선수레벨</th>
        <th>훈련중요도</th>
        <th>훈련강도</th>
        <th>부상위험도</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${trprolist.size()!=0}">
        <c:forEach items="${trprolist}" var="list">
          <tr>
            <td><a href="/training/trview?trainingid=${list.trainingid}">${list.trname}</a></td>
            <td>${list.trcount}</td>
            <td>
              <c:choose>
                <c:when test="${list.trtype== 'A'}">
                  경기
                </c:when>
                <c:when test="${list.trtype== 'B'}">
                  패스
                </c:when>
                <c:when test="${list.trtype== 'C'}">
                  슈팅
                </c:when>
                <c:when test="${list.trtype== 'D'}">
                  드리블
                </c:when>
                <c:when test="${list.trtype== 'E'}">
                  체력
                </c:when>
                <c:when test="${list.trtype== 'F'}">
                  코디네이션
                </c:when>
                <c:when test="${list.trtype== 'G'}">
                  레크레이션
                </c:when>
                <c:otherwise>
                  전체
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${list.exclass== 'A'}">
                  Class A
                </c:when>
                <c:when test="${list.exclass== 'B'}">
                  Class B
                </c:when>
                <c:when test="${list.exclass== 'C'}">
                  Class C
                </c:when>
                <c:when test="${list.exclass== 'D'}">
                  Class D
                </c:when>
                <c:otherwise>
                  전체
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${list.importance== 'G'}">
                  상
                </c:when>
                <c:when test="${list.importance== 'F'}">
                  중
                </c:when>
                <c:when test="${list.importance== 'P'}">
                  하
                </c:when>
                <c:otherwise>
                  없음
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${list.strength== 'G'}">
                  상
                </c:when>
                <c:when test="${list.strength== 'F'}">
                  중
                </c:when>
                <c:when test="${list.strength== 'P'}">
                  하
                </c:when>
                <c:otherwise>
                  없음
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${list.injurypotential== 'G'}">
                  상
                </c:when>
                <c:when test="${list.injurypotential== 'F'}">
                  중
                </c:when>
                <c:when test="${list.injurypotential== 'P'}">
                  하
                </c:when>
                <c:otherwise>
                  없음
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </c:if>
      <c:if test="${trprolist.size()==0}">
        <tr>
          <td colspan="10" style="text-align: center" class="warning">등록된 훈련프로그램이 존재하지 않습니다.</td>
        </tr>
      </c:if>
      </tbody>
    </table>


    <div style="text-align: center">
      <form name="listForm" action="/training/trmain" method="post">
        <div class="pagination">
          <input type="hidden" name="firstPageNo" value="${trainingProDto.firstPageNo}" />
          <input type="hidden" name="prevPageNo" value="${trainingProDto.prevPageNo}" />
          <input type="hidden" name="startPageNo" value="${trainingProDto.startPageNo}" />
          <input type="hidden" name="pageNo" value="${trainingProDto.pageNo}" />
          <input type="hidden" name="endPageNo" value="${trainingProDto.endPageNo}" />
          <input type="hidden" name="nextPageNo" value="${trainingProDto.nextPageNo}" />
          <input type="hidden" name="finalPageNo" value="${trainingProDto.finalPageNo}" />

          <input type="hidden" id="trname" name="finalPageNo" value="${trainingProDto.trname}" />
          <input type="hidden" id="trtype" name="finalPageNo" value="${trainingProDto.trtype}" />
          <input type="hidden" id="exclass" name="finalPageNo" value="${trainingProDto.exclass}" />
          <input type="hidden" id="injurypotential" name="finalPageNo" value="${trainingProDto.injurypotential}" />
          <input type="hidden" id="importance" name="finalPageNo" value="${trainingProDto.importance}" />
          <input type="hidden" id="strength" name="finalPageNo" value="${trainingProDto.strength}" />
          <input type="hidden" id="trruletime" name="finalPageNo" value="${trainingProDto.trruletime}" />

          <li class="previous"><a href="javascript:goPage(${trainingProDto.firstPageNo})"><span aria-hidden="true"></span>처음</a></li>
          <li><a href="javascript:goPage(${trainingProDto.prevPageNo})" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
          <li>
            <c:forEach var="i" begin="${trainingProDto.startPageNo}" end="${trainingProDto.endPageNo}" step="1">
              <c:choose>
                <c:when test="${i eq trainingProDto.pageNo}">
                  <a href="javascript:goPage(${i})" class="selected">${i}</a>
                </c:when>
                <c:otherwise>
                  <a href="javascript:goPage(${i})">${i}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>
          </li>
          <li><a href="javascript:goPage(${trainingProDto.nextPageNo})" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
          <li class="next"><a href="javascript:goPage(${trainingProDto.finalPageNo})">마지막<span aria-hidden="true"></span></a></li>
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
