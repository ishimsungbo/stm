<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>팀스케줄</title>

    <link rel="stylesheet" href="/resources/stm.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
    <script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>
    <script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="/resources/datepicker/css/bootstrap-datepicker3.min.css">
    <script src="/resources/datepicker/js/bootstrap-datepicker.min.js" charset="UTF-8"></script>
    <script src="/resources/datepicker/locales/bootstrap-datepicker.ko.min.js" charset="UTF-8"></script>


    <%--캘린더 셋팅--%>
    <%--<link href='/resources/ace/assets/css/ace.min.css' rel='stylesheet' />--%>
    <link href='/resources/fullcalendar/fullcalendar.min.css' rel='stylesheet' />
    <link href='/resources/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
    <script src='/resources/fullcalendar/moment.min.js'></script>
    <script src='/resources/fullcalendar/fullcalendar.min.js'></script>
    <script src='/resources/fullcalendar/ko.js' charset="UTF-8"></script>



    <script type="text/javascript">

        $(document).ready(function() {

            //서버에서 가져온 값
            var lvjson = JSON.parse('${jsonList}');

            console.log(lvjson);

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth()+1; //모다냐..왜 한달빠져서 나온다냥...
            var y = date.getFullYear();

            var today = y+'-'+m+'-'+d;




            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,basicWeek,basicDay'
                },
                eventColor: 'red',
                selectable: true,
                selectHelper: true,
                editable: true,
                eventLimit: true, // allow "more" link when too many events
                events: lvjson,
                dayClick: function(date, jsEvent, view) {
                    var modal =
                            '<div class="modal fade">\
                              <div class="modal-dialog">\
                               <div class="modal-content">\
                                 <div class="modal-body">\
                                   <button type="button" class="close" data-dismiss="modal" style="margin-top:-10px;">&times;</button>\
                           <form class="no-margin" action="/schedule/addday" modelAttribute="CalendarVo" method="POST">\
                            <div class="form-group">\
                               <label for="text" class="control-label">스케줄 시작일자</label>\
                                <input type="date" class="form-control" name="start" id="start" value="' + date.format() + '" required/>\
                              </div>\
                              <div class="form-group">\
                                 <label for="end" class="control-label">스케줄 종료일자</label>\
                                  <input type="date" class="form-control" name="end" id="end" value="' + date.format() + '" required/>\
                              </div>\
                              <div class="form-group">\
                                 <label for="title" class="control-label">스케줄 제목</label>\
                                 <input type="text" class="form-control" id="title" name="title" required>\
                              </div>\
                                <div class="form-group">\
                                <label for="color" class="control-label">스케줄색상</label>\
                                <input type="color" name="color" id="color" style="width: 100px">\
                                </div>\
                              <div style="margin-top: 5px">\
                              <input type="submit" value="등록" class="btn btn-default" style="width: 110px">\
                              <input type="reset" value="지우기" class="btn btn-default" style="width: 110px">\
                              </div>\
                             </form>\
                                  </div>\
                                </div>\
                              </div>\
                              </div>';

                    var modal = $(modal).appendTo('body');

                    modal.find('form').on('submit', function(ev){
                        //ev.preventDefault();
                        modal.modal("hide");
                    });
                    modal.find('button[data-action=delete]').on('click', function() {
                        modal.modal("hide");
                    });

                    modal.modal('show').on('hidden', function(){
                        modal.remove();
                    });

                },
                eventClick: function(calEvent, jsEvent, view) {

                    var content = calEvent.content;
                    var start = calEvent.start.format('YYYY-MM-DD');

                    var end;
                    var calendarid = calEvent.calendarid;

                    //alert(calEvent.end);
                    if(calEvent.end !=null){
                        //alert(1);
                        end = calEvent.end.format('YYYY-MM-DD');
                    }else{
                        //alert(2);
                        end = calEvent.start.format('YYYY-MM-DD');
                    }

                    var modal =
                            '<div class="modal fade">\
                              <div class="modal-dialog">\
                               <div class="modal-content">\
                                 <div class="modal-body">\
                                   <button type="button" class="close" data-dismiss="modal" style="margin-top:-10px;">&times;</button>\
                           <form class="no-margin" action="/schedule/modify" modelAttribute="CalendarVo" method="POST" >\
                            <div class="form-group">\
                               <label for="text" class="control-label">스케줄 시작일자</label>\
                                <input type="date" class="form-control" name="start" id="start" value="'+start+'" required/>\
                              </div>\
                              <div class="form-group">\
                                 <label for="end" class="control-label">스케줄 종료일자</label>\
                                  <input type="date" class="form-control" name="end" id="end" value="'+end+'" required/>\
                              </div>\
                              <div class="form-group">\
                                 <label for="title" class="control-label">스케줄 제목</label>\
                                 <input type="text" class="form-control" id="title" name="title" value="'+ calEvent.title +'" required>\
                              </div>\
                              <div class="form-group">\
                              <input type="hidden" name="calendarid" id="calendarid" value="'+calendarid+'">\
                            <div class="form-group">\
                                <label for="color" class="control-label">스케줄색상</label>\
                                <input type="color" name="color" id="color" style="width: 100px" value="'+calEvent.color+'">\
                                </div>\
<div>\
<select class="form-control" name="flag" style="margin-bottom: 10px; width: 110px;" >\
<option>변경</option>\
<option>삭제</option>\
</select>\
                              <input id="update" type="submit" value="적용" class="btn btn-default" style="width: 110px;"></div>\
                             </form>\
                                  </div>\
                                </div>\
                              </div>\
                              </div>';

                    var modal = $(modal).appendTo('body');

                    modal.find('form').on('submit', function(ev){
                        //ev.preventDefault();
                        modal.modal("hide");
                    });
                    modal.find('button[data-action=delete]').on('click', function() {
                        modal.modal("hide");
                    });

                    modal.modal('show').on('hidden', function(){
                        modal.remove();
                    });

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
        <h3>팀 스케줄</h3>
    </section>


    <section class="highlight_white">

        <div id='calendar' class="fc fc-ltr"></div>

    </section>


</article>


<footer class="stm-footer" style="margin-top: 10px">
    <%@ include file="../footer.jsp"%>
</footer>

</body>
</html>
