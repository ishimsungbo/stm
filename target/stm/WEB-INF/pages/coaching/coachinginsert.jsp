<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring"
           uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib prefix="stm" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>선수등록</title>
    <link rel="stylesheet" href="/resources/stm.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
    <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
    <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

    <%--extend slider--%>
    <script type="text/javascript" src="/resources/jqueryextend/jquery-ui-1.10.3.custom.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/jqueryextend/jquery-ui.css">

    <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
    <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
    <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>


    <script>
        $(document).ready(function() {
            //슬라이더 부분
            $("#slider01").slider({
                range:"min",
                min:0,
                max:10,
                value:5,
                slide:function(event,ui){
                    $("#learnscore").val(ui.value)
                }
            });

            $("#learnscore").val($("#slider01").slider("value"));

        });
    </script>

</head>

<body class="stmbody">
<header>
    <%@ include file="../headerpage.jsp"%>
</header>


<article>

    <section class="page-subject">
        <h3>코칭정보 입력</h3>
    </section>

    <form  class="form-horizontal" action="/dbwork/coinsert" method="post" id="frm" name="frm">


        <section class="highlight">

            <div class="form-group">
                <label class="col-md-2 control-label" style="width: 100px">선수이름</label>
                <div class="col-md-4">
                    <spring:select path="CoachingVo" name="playerid" class="form-control">
                        <spring:options items="${poslist}" itemValue="playerid"
                                        itemLabel="playername" />
                    </spring:select>
                </div>
            </div>


            <div class="form-group">
                <label for="subject" class="col-md-2 control-label" style="width: 100px">제목</label>
                <div class="col-md-4">
                 <input type="text" class="form-control" id="subject" name="subject" required>
                </div>

                <label for="cdate" class="col-md-2 control-label" style="width: 100px">일자</label>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="cdate" name="cdate" required>
                    <script>
                        $('#cdate').datepicker({
                            format: "yyyy-mm-dd",
                            language: "ko",
                            autoclose: true,
                            todayHighlight: true
                        });
                    </script>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label" style="width: 100px">코칭유형</label>
                <div class="col-md-4">
                    <spring:select path="levelvo" name="coachinglevel" class="form-control">
                        <spring:options items="${coachinglevel}" itemValue="LookupCode"
                                        itemLabel="DescripTion" />
                    </spring:select>
                </div>

                <label class="col-md-2 control-label" style="width: 100px">코칭부분</label>
                <div class="col-md-4">
                    <spring:select path="typevo" name="coachingtype" class="form-control">
                        <spring:options items="${coachingtype}" itemValue="LookupCode"
                                        itemLabel="DescripTion" />
                    </spring:select>
                </div>
            </div>

            <div class="form-group">
                <label for="problem" class="col-md-2 control-label" style="width: 100px">문제점</label>
                <div class="col-md-4">
                 <textarea class="form-control" rows="5" name="problem" id="problem"></textarea>
                </div>

                <label for="cause" class="col-md-2 control-label" style="width: 100px">원인</label>
                <div class="col-md-4">
                    <textarea class="form-control" rows="5" name="cause" id="cause"></textarea>
                </div>
            </div>

            <div class="form-group">
                <label for="solution" class="col-md-2 control-label" style="width: 100px">해결방법</label>
                <div class="col-md-4">
                    <textarea class="form-control" rows="5" name="solution" id="solution"></textarea>
                </div>

                <label for="recoachingflag" class="col-md-2 control-label" style="width: 100px">반복여부</label>
                <div class="col-md-4">
                    <select name="recoachingflag" class="form-control" id="recoachingflag">
                        <option value="N">아니오</option>
                        <option value="Y">예</option>
                    </select>
                </div>

            </div>

            <div class="form-group">
                <label class="col-md-2 control-label" style="width: 100px">중요도</label>
                <div class="col-md-4">
                    <div id="slider01" style="width: 300px;float: left; margin-top: 10px"></div>
                </div>
                <div class="col-md-2">
                    <input class="form-control text-center" type="number" min="0" max="10" step="1" id="learnscore" name="learnscore">
                </div>
                <div class="col-md-4"></div>
            </div>
        </section>

        <input type="submit" value="등록" class="btn btn-default" style="width: 110px">
        <input type="reset" value="지우기" class="btn btn-default" style="width: 110px">
    </form>

</article>

<footer class="highlight" style="margin-top: 20px">
    <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
