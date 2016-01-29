
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Json 배열사용법 테스트</title>
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
    var arr = ['사과','큘','배','감'];

    var arrt=[
        {"패스":99,"슈팅":100},
        {"패스":99,"슈팅":88},
        {"패스":99,"슈팅":99}
            ];


    var content=[];

    for(var i in pjson){
        content.push(pjson[i]);
    }


    console.log(pjson);
    console.log(arrt);

</script>


</head>
<body>
<div class="row" style="margin: auto">
    <div class="col col-4"><div id="chart"></div></div>
</div>

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
            height : 400,
            theme : "jennifer",
            axis : {
                x : {
                    type : "block",
                    domain : ["1","2","3","4",'5','6']
                },
                y : {
                    type : "range",
                    domain : "pass",
                    step : 5
                },
                c : {
                    type : "grid3d",
                    domain : [ "1", "2","3","4"]
                },
                data : pjson,
                depth : 150,
                degree : 30
            },
            brush : {
                type : "clustercylinder3d",
                topRate : 1,
                outerPadding : 49,
                innerPadding : 0.2
            },
            widget : [{type : "tooltip"},{ type : "title", text : "선수평가 정보" }, { type : "legend"/*,orient: "top"*/ }]
            ,
            style : {
                gridAxisBorderColor : "black",
                gridBorderColor : "#dcdcdc"
            }
        });
    })
</script>
</body>
</html>
