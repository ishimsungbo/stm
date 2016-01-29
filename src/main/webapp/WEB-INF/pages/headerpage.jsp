<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>

  $(document).ready(function() {
    $("#logo").hover(function(){
      $(this).attr("src","/resources/systemimg/stmlogo_hover.svg");
    }, function(){
      $(this).attr("src","/resources/systemimg/stmlogo.svg");
    });

    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })

    $('#cheangelang').change(function(){
      var lang = $(this).val();
      window.location = $(':selected',this).attr('href');
    });

  });

  function formSubmit() {
    /*
     로그인 유저가 stm에서 sns(naver.facebook,google)에서 가입했느냐에 따라 분기해준다. 서버에서 코딩해도 될듯하다.
     */
    $.ajax({
      url : "/oauth/logout",
      type: "get",
      success : function(data){
        $("#ajax").remove();

        if(!data){
          alert("존재하지 않는 ID입니다");
          return false;
        }
        console.log(data);
      }
    });

    document.getElementById("logoutForm").submit();
  }


</script>

<style>
  #team ,#anal ,#player,#ex ,#eval{
    margin-top: 16px;
    width: 120px;
  }


</style>


<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">

    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>

      <a class="navbar-brand" style="padding: 0px" href="/">
        <img id="logo"  data-toggle="tooltip" data-placement="right" title="메인 페이지로 이동합니다"
             src="/resources/systemimg/stmlogo.svg" width="100px" height="50px"/>
      </a>
    </div>



    <div class="collapse navbar-collapse" id="myNavbar">
      <c:if test="${teamCount != 0}">
        <ul class="nav navbar-nav">

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="width: 80px">팀<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="/schedule/schedulemain">팀스케줄</a></li>
              <%--<li><a href="/season/seasonMain">시즌정보</a></li>--%>
              <li><a href="/sptr/sptrmain">전지훈련</a></li>
              <li><a href="/meeting/meetmain">회의</a></li>
            </ul>
          </li>

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="width: 80px">선수<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="/player/playermain">선수정보</a></li>
            </ul>
          </li>

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="width: 80px">훈련<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="/trjournals/trjournalmain">훈련일지</a></li>
              <li><a href="/training/trmain">훈련프로그램</a></li>
            </ul>
          </li>

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">대회/연습경기<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="/match/matchmain">대회정보</a></li>
              <li><a href="/matchgame/matchgame">대회경기</a></li>
              <li><a href="/exgame/exgamemain">연습경기</a></li>
            </ul>
          </li>

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" >정기평가<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="/evaluation/physical_main">기술평가</a></li>
              <li><a href="/evaluation/phyplayermain">선수신체정보</a></li>
            </ul>
          </li>

          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="width: 80px">코칭<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="/coaching/coachingmain">코칭기록</a></li>
            </ul>
          </li>
        </ul>
      </c:if>
      <ul class="nav navbar-nav navbar-right">
        <c:if test="${pageContext.request.userPrincipal.name != null}">
          <li><a href="javascript:formSubmit()"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
        </c:if>
      </ul>

<%--      <ul class="nav navbar-nav navbar-right">
        <c:if test="${pageContext.request.userPrincipal.name != null}">
          <li><a href="javascript:formSubmit()"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
        </c:if>
        <li style="margin-top: 7px">
          <select id="cheangelang" class="form-control">
            <option value="">언어선택</option>
            <option href="/changeLanguage?lang=ko">한국어</option>
            <option href="/changeLanguage?lang=en">영어</option>
          </select>
        </li>
      </ul>--%>

    </div>

  </div>
</nav>
<c:url value="j_spring_security_logout" var="logoutUrl" />
<form action="${logoutUrl}" method="post" id="logoutForm">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>