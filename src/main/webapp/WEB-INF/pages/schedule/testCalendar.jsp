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

  <%--캘린더 셋팅--%>
  <link href='/resources/fullcalendar/fullcalendar.min.css' rel='stylesheet' />
  <link href='/resources/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
  <script src='/resources/fullcalendar/moment.min.js'></script>
  <script src='/resources/fullcalendar/fullcalendar.min.js'></script>
  <script src='/resources/fullcalendar/ko.js' charset="UTF-8"></script>
  <script>
    $(document).ready(function() {

      $('#calendar').fullCalendar({
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,basicWeek,basicDay'
        },
        defaultDate: "2015-12-02",
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        events: [
          {
            title: 'All Day Event',
            start: '2015-12-02',
            color: 'red',
            textColor: 'white',
            backgroundColor: 'blue'
          },
          {
            title: '연습경기 예정',
            start: '2015-11-18',
            end: '2015-11-20'
          },
          {
            id: 999,
            title: 'Repeating Event',
            start: '2015-02-09T16:00:00'
          },
          {
            id: 999,
            title: 'Repeating Event',
            start: '2015-02-16T16:00:00'
          },
          {
            title: 'Conference',
            start: '2015-02-11',
            end: '2015-02-13'
          },
          {
            title: 'Meeting',
            start: '2015-02-12T10:30:00',
            end: '2015-02-12T12:30:00'
          },
          {
            title: 'Lunch',
            start: '2015-02-12T12:00:00'
          },
          {
            title: 'Meeting',
            start: '2015-02-12T14:30:00'
          },
          {
            title: 'Happy Hour',
            start: '2015-02-12T17:30:00'
          },
          {
            title: 'Dinner',
            start: '2015-02-12T20:00:00'
          },
          {
            title: 'Birthday Party',
            start: '2015-02-13T07:00:00'
          },
          {
            title: 'Click for Google',
            url: 'http://google.com/',
            start: '2015-02-28'
          }
        ]
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
    <h2>팀 스케줄</h2>
  </section>


  <section class="highlight_white">

    <div id='calendar'></div>

  </section>

</article>


<footer>

</footer>

</body>
</html>
