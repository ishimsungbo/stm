
<!DOCTYPE html>
<html lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta charset="utf-8" />
  <title>Full Calendar - Ace Admin</title>

  <meta name="description" content="with draggable and editable events" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

  <!-- bootstrap & fontawesome -->
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
  <link rel="stylesheet" href="/resources/ace/assets/css/font-awesome.min.css" />

  <!-- page specific plugin styles -->
  <link rel="stylesheet" href="/resources/ace/assets/css/jquery-ui.custom.min.css" />

  <!-- text fonts -->
  <link rel="stylesheet" href="/resources/ace/assets/css/ace-fonts.css" />

  <!-- ace styles -->
  <link rel="stylesheet" href="/resources/ace/assets/css/ace.min.css" id="main-ace-style" />

  <!--[if lte IE 9]>

  <![endif]-->


  <!--[if lte IE 9]>

  <![endif]-->

  <!-- inline styles related to this page -->


  <![endif]-->

</head>

<body class="no-skin">



  <div class="main-content">


    <!-- /section:basics/content.breadcrumbs -->
    <div class="page-content">

      <!-- /section:settings.box -->
      <div class="page-content-area">
        <div class="page-header">
          <h1>
            Full Calendar
            <small>
              <i class="ace-icon fa fa-angle-double-right"></i>
              with draggable and editable events
            </small>
          </h1>
        </div><!-- /.page-header -->

        <div class="row">
          <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div class="row">
              <div class="col-sm-9">
                <div class="space"></div>

                <!-- #section:plugins/data-time.calendar -->
                <div id="calendar"></div>

                <!-- /section:plugins/data-time.calendar -->
              </div>


            </div>

            <!-- PAGE CONTENT ENDS -->
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.page-content-area -->
    </div><!-- /.page-content -->
  </div><!-- /.main-content -->



<!-- basic scripts -->

<!--[if !IE]> -->
<script type="text/javascript">
  window.jQuery || document.write("<script src='/resources/ace/assets/js/jquery.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
  window.jQuery || document.write("<script src='../assets/js/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
  if('ontouchstart' in document.documentElement) document.write("<script src='../assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="/resources/ace/assets/js/bootstrap.min.js"></script>

<!-- page specific plugin scripts -->
<script src="/resources/ace/assets/js/jquery-ui.custom.min.js"></script>
<script src="/resources/ace/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="/resources/ace/assets/js/date-time/moment.min.js"></script>
<script src="/resources/ace/assets/js/fullcalendar.min.js"></script>
<script src="/resources/ace/assets/js/bootbox.min.js"></script>

<!-- ace scripts -->
<script src="/resources/ace/assets/js/ace-elements.min.js"></script>
<script src="/resources/ace/assets/js/ace.min.js"></script>

<!-- inline scripts related to this page -->
<script type="text/javascript">
  jQuery(function($) {

    /* initialize the external events
     -----------------------------------------------------------------*/

    $('#external-events div.external-event').each(function() {

      // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
      // it doesn't need to have a start or end
      var eventObject = {
        title: $.trim($(this).text()) // use the element's text as the event title
      };

      // store the Event Object in the DOM element so we can get to it later
      $(this).data('eventObject', eventObject);

      // make the event draggable using jQuery UI
      $(this).draggable({
        zIndex: 999,
        revert: true,      // will cause the event to go back to its
        revertDuration: 0  //  original position after the drag
      });

    });




    /* initialize the calendar
     -----------------------------------------------------------------*/

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();


    var calendar = $('#calendar').fullCalendar({
      //isRTL: true,
      buttonHtml: {
        prev: '<i class="ace-icon fa fa-chevron-left"></i>',
        next: '<i class="ace-icon fa fa-chevron-right"></i>'
      },

      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      events: [
        {
          title: 'All Day Event',
          start: new Date(y, m, 1),
          className: 'label-important'
        },
        {
          title: 'Long Event',
          start: new Date(y, m, d-5),
          end: new Date(y, m, d-2),
          className: 'label-success'
        },
        {
          title: 'Some Event',
          start: new Date(y, m, d-3, 16, 0),
          allDay: false
        }
      ]
      ,
      editable: true,
      droppable: true, // this allows things to be dropped onto the calendar !!!
      drop: function(date, allDay) { // this function is called when something is dropped

        // retrieve the dropped element's stored Event Object
        var originalEventObject = $(this).data('eventObject');
        var $extraEventClass = $(this).attr('data-class');


        // we need to copy it, so that multiple events don't have a reference to the same object
        var copiedEventObject = $.extend({}, originalEventObject);

        // assign it the date that was reported
        copiedEventObject.start = date;
        copiedEventObject.allDay = allDay;
        if($extraEventClass) copiedEventObject['className'] = [$extraEventClass];

        // render the event on the calendar
        // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

        // is the "remove after drop" checkbox checked?
        if ($('#drop-remove').is(':checked')) {
          // if so, remove the element from the "Draggable Events" list
          $(this).remove();
        }

      }
      ,
      selectable: true,
      selectHelper: true,
      select: function(start, end, allDay) {

        bootbox.prompt("New Event Title:", function(title) {
          if (title !== null) {
            calendar.fullCalendar('renderEvent',
                    {
                      title: title,
                      start: start,
                      end: end,
                      allDay: allDay
                    },
                    true // make the event "stick"
            );
          }
        });


        calendar.fullCalendar('unselect');
      }
      ,
      eventClick: function(calEvent, jsEvent, view) {

        //display a modal
        var modal =
                '<div class="modal fade">\
                  <div class="modal-dialog">\
                   <div class="modal-content">\
                     <div class="modal-body">\
                       <button type="button" class="close" data-dismiss="modal" style="margin-top:-10px;">&times;</button>\
                       <form class="no-margin">\
                          <label>Change event name &nbsp;</label>\
                          <input class="middle" autocomplete="off" type="text" value="' + calEvent.title + '" />\
					 <button type="submit" class="btn btn-sm btn-success"><i class="ace-icon fa fa-check"></i> Save</button>\
				   </form>\
				 </div>\
				 <div class="modal-footer">\
					<button type="button" class="btn btn-sm btn-danger" data-action="delete"><i class="ace-icon fa fa-trash-o"></i> Delete Event</button>\
					<button type="button" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-times"></i> Cancel</button>\
				 </div>\
			  </div>\
			 </div>\
			</div>';


        var modal = $(modal).appendTo('body');
        modal.find('form').on('submit', function(ev){
          ev.preventDefault();

          calEvent.title = $(this).find("input[type=text]").val();
          calendar.fullCalendar('updateEvent', calEvent);
          modal.modal("hide");
        });
        modal.find('button[data-action=delete]').on('click', function() {
          calendar.fullCalendar('removeEvents' , function(ev){
            return (ev._id == calEvent._id);
          })
          modal.modal("hide");
        });

        modal.modal('show').on('hidden', function(){
          modal.remove();
        });


        //console.log(calEvent.id);
        //console.log(jsEvent);
        //console.log(view);

        // change the border color just for fun
        //$(this).css('border-color', 'red');

      }

    });


  })
</script>


</body>
</html>
