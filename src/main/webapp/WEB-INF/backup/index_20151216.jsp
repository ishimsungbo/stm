<%@ page import="com.sun.net.httpserver.HttpsServer" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>


<!DOCTYPE html>

<html lang="ko">
<head>
  <title>Sport Team Manager</title>
  <link rel="stylesheet" href="/resources/stm.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
  <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
</head>

<body class="stmbody">


<header>
  <%@ include file="headerpage.jsp"%>
</header>

<article>
  <c:choose>
    <c:when test="${curlogname!='anonymousUser'}">

      <c:if test="${pageContext.request.userPrincipal.name != null}">

        <c:if test="${teamCount == 0}">
          <%--    <h4>관리하실 팀을 생성하시거나 특정팀에 소속요청을 하셔야 사용하실 수 있습니다.</h4>
              <a href="/team/teamjoin"><button type="button" class="btn btn-primary">팀생성</button><a/>
              <a href="/team/requestp"><button type="button" class="btn btn-primary">팀소속요청</button></a>--%>

          <div style="margin: 200px 10px 200px auto; float: left; width: 480px; height: 400px">
            <h2 style="text-align: center"><a href="/team/teamjoin">팀생성</a></h2>
          </div>
          <div style="margin: 200px 10px 200px auto; float: left; width: 480px; height: 400px">
            <h2>무제</h2>
          </div>

        </c:if>

        <c:if test="${teamCount != 0}">
          <%--팀메인페이지  --%>

          <section class="jumbotron highlight">
            <div class="row" style="text-align: center">
              <div class="col-sm-4">
                <p>팀정보1</p>
              </div>

              <div class="col-sm-4">
                <p>팀정보2</p>
              </div>

              <div class="col-sm-4">
                <p>팀정보3</p>
              </div>
            </div>
          </section>

          <section class="highlight_white">

            <div class="row">
              <div class="col-md-2">팀명</div>
              <div class="col-md-3">
                  ${teamvo.name}
              </div>
            </div>

            <div class="row">
              <div class="col-md-2">2015 소속 선수</div>
              <div class="col-md-3">
                  ${playerallcount}
              </div>
            </div>

            <div class="row">
              <div class="col-md-2">현재 부상선수</div>
              <div class="col-md-3">
                4
              </div>
            </div>

            <div class="row">
              <div class="col-md-2">2015시즌 대회 경기 수</div>
              <div class="col-md-3">
                25
              </div>
            </div>

            <div class="row">
              <div class="col-md-2">2015시즌 연습경기 수</div>
              <div class="col-md-3">
                93
              </div>
            </div>

            <div class="row">
              <div class="col-md-2">2015년 목표</div>
              <div class="col-md-3">
                미등록
              </div>
            </div>

            <div class="row">
              <div class="col-md-2">현 분기 목표</div>
              <div class="col-md-3">
                수비 지역 실수를 줄이자!
              </div>
            </div>
          </section>

          <section class="highlight">

          </section>

        </c:if>
      </c:if>
    </c:when>

    <%--로그인을 하지 않은 경우--%>
    <c:when test="${curlogname=='anonymousUser'}">
      <div class="container">

        <a data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
          <h5>Sport Team Manager 시작하기</h5>
          <h4>Sport Team Manager 시작하기</h4>
          <h3>Sport Team Manager 시작하기</h3>
          <h2>Sport Team Manager 시작하기</h2>
          <h1>Sport Team Manager 시작하기</h1>
        </a>



        <c:if test="${not empty param.fail}">
          <div style="text-align: center; color: red">
            에러사유는  : ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
            <c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION" />
          </div>
        </c:if>

        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="exampleModalLabel">로그인 및 회원가입</h4>
              </div>

              <c:url value="j_spring_security_check" var="loginUrl"/>
              <form action="${loginUrl}" method="post" id="loginmodal" value="loginfrm">

                <div class="modal-body">
                  <div class="form-group">
                    <label for="userid" class="control-label">아이디</label>
                    <input type="text" class="form-control" id="userid" name="userid">
                  </div>
                  <div class="form-group">
                    <label for="pwd" class="control-label">비밀번호</label>
                    <input type="password" class="form-control" id="pwd" name="pwd">
                  </div>
                </div>

                <div class="modal-footer" id="footerA">
                  <div class="text-center">
                    <input type="submit"    class="btn btn-primary" value="로그인" style="width: 100px"/>
                    <a href="userjoin"     class="btn btn-primary" style="width: 100px">회원가입</a>
                    <a href="user/findinfo"     class="btn btn-primary" style="width: 100px">ID/PW 찾기</a>
                  </div>
                </div>
                <div class="modal-footer" id="footerB">
                  <div class="row">
                    <div class="col-md-6"><h4>소셜계정으로 STM서비스이용</h4></div>
                    <div class="col-md-4">
                      <a href="/oauth/login"><img src="/resources/systemimg/naver.png" width="40" height="40"></a>
                      <a href="#"><img src="/resources/systemimg/facebook.png" width="40" height="40"></a>
                      <a href="#"><img src="/resources/systemimg/google.png" width="40" height="40"></a>
                    </div>
                    <div class="col-md-2"></div>
                  </div>
                </div>
              </form>

            </div>
          </div>
        </div>

      </div>
    </c:when>

  </c:choose>
</article>

<footer>

</footer>

</body>
</html>
