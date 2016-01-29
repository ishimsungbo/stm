<%@ page import="javax.xml.ws.spi.http.HttpContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>선수등록</title>
    <link rel="stylesheet" href="/resources/stm.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
    <%--<link rel="stylesheet" href="/resources/jui-master/dist/jui.min.css" />--%>
    <%--<link rel="stylesheet" href="/resources/jui-master/dist/jennifer.theme.min.css" />--%>
    <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
    <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
    <script src="/resources/jui-master/dist/jui.min.js"></script>


    <script>
        var json = JSON.parse('${jsonList}');
        var pjson = JSON.parse('${plist}');

        console.log(pjson);

        var arry_exdate = [];
        for(var i in json){
            arry_exdate.push([json[i].exdate]);
        }

        var arry_exdatecon=[];

        for(var i in arry_exdate){
            arry_exdatecon.push(arry_exdate[i]);
        }

        //5개의 최근 평가를 보여준다. 5개 이상을 표현하면 그래픽이 보기 않좋다.
        if(arry_exdatecon.length < 5) {
            var v_conplit = 5 - arry_exdatecon.length;
            for (var i = 1; v_conplit >= i; i++) {
                arry_exdatecon.push('YYYYMMDD');

            };
        };

        //페이징
        function goPage(pageNo){
            document.listForm.pageNo.value = pageNo;
            document.listForm.submit();

            console.log("pageNo : " + pageNo);
        }

    </script>

</head>

<body class="jui">
<header>
    <%@ include file="../headerpage.jsp"%>
</header>

<article class="container" style="margin-top: 100px">

    <section class="page-subject">
        <h2>${playerName} <small>선수기록정보</small></h2>
    </section>


    <section>
        <c:if test="${list.size() == 0}">
            <section class="highlight">
                <h4>정기평가 기록이 존재 하지 않습니다.</h4>
            </section>
        </c:if>

        <c:if test="${list.size() > 1}">
            <div id="chart-content"></div>
        </c:if>

        <script>
            var chart = jui.include("chart.builder");

            chart("#chart-content", {
                width: 960,
                height : 350,
                axis : {
                    x : {
                        type : "fullblock",
                        domain : arry_exdatecon,
                        line : true
                    },
                    y : {
                        type : "range",
                        domain : function(d) {
                            return Math.max(d.dribble, d.kick, d.pass, d.shooting);
                        },
                        step : 10
                    },
                    data : pjson
                },
                brush : [{
                    type : "line",
                    animate : true
                }, {
                    type : "scatter",
                    hide : true
                }],
                widget : [
                    { type : "title", text : "선수개인평가 [LINE BAR]" },
                    { type : "legend" },
                    { type : "tooltip", brush : 2 }
                ]
            });
        </script>
    </section>

    <section>
       <c:if test="${list.size() == 1}">
        <div class="row" style="margin: auto">
            <div class="col col-4"><div id="chart"></div></div>
        </div>
        </c:if>
        <script id="tpl_tooltip" type="text/template">
            <div class="tooltip tooltip-top tooltip-black">
                <div class="anchor"></div>
                <div class="message"><!= obj.dataKey !>: <!= obj.data[obj.dataKey] !></div>
            </div>
        </script>

        <script>
            jui.ready([ "chart.builder" ], function(chart) {
                c = chart("#chart", {
                    width: 960,
                    height : 380,
                    theme : "jennifer",
                    axis : {
                        x : {
                            type : "block",
                            domain : arry_exdatecon
                        },
                        y : {
                            type : "range",
                            domain : "pass",
                            step : 5
                        },
                        c : {
                            type : "grid3d",
                            domain : [ "dribble", "kick", "pass","shooting" ]
                        },
                        data : pjson,
                        depth : 200,
                        degree : 45
                    },
                    brush : {
                        type : "clustercylinder3d",
                        topRate : 1,
                        outerPadding : 50,
                        innerPadding : 0.2
                    },
                    widget : [{type : "tooltip"},{ type : "title", text : "선수평가기록 [3D BAR]" }, { type : "legend"/*,orient: "top"*/ }]
                    ,
                    style : {
                        gridAxisBorderColor : "black",
                        gridBorderColor : "#dcdcdc"
                    }
                });
            })


        </script>
        <%
            String pid =  request.getParameter("playerid");
        %>
    </section>

    <c:if test="${list.size() != 0}">
    <div style="text-align: center">
        <form name="listForm" action="playerper" method="post">
            <div class="pagination">
                <input type="hidden" name="firstPageNo" value="${paging.firstPageNo}" />
                <input type="hidden" name="prevPageNo" value="${paging.prevPageNo}" />
                <input type="hidden" name="startPageNo" value="${paging.startPageNo}" />
                <input type="hidden" name="pageNo" value="${paging.pageNo}" />
                <input type="hidden" name="endPageNo" value="${paging.endPageNo}" />
                <input type="hidden" name="nextPageNo" value="${paging.nextPageNo}" />
                <input type="hidden" name="finalPageNo" value="${paging.finalPageNo}" />
                <input type="hidden" name="playerid" value="<%=pid%>" />

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
    </c:if>

</article>




<footer>
</footer>

</body>
</html>

