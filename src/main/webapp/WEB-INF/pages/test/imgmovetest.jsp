<!doctype html>
<html>
<head>
  <link rel="stylesheet" type="text/css" media="all" href="css/reset.css" /> <!-- reset css -->
  <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

  <style>
    body{ background-color: ivory; }
    canvas{border:1px solid red;}
  </style>

  <script>
    $(function(){


      var img = new Image();

      var img1 = new Image();

      img.onload = function(){
        ctx.drawImage(img, 0,0);
      };

      img1.onload = function(){
        ctx.drawImage(img, 50,50);
      };

      img.src = "http://images.christmastimeclipart.com/images/2/1271716593176_1788/img_1271716593176_17881.jpg";
      img1.src = "http://images.christmastimeclipart.com/images/2/1271716593176_1788/img_1271716593176_17881.jpg";

      var canvas=document.getElementById("canvas");
      var ctx=canvas.getContext("2d");

      var canvasOffset=$("#canvas").offset();
      var offsetX=canvasOffset.left;
      var offsetY=canvasOffset.top;
      var canvasWidth=canvas.width;
      var canvasHeight=canvas.height;
      var isDragging=false;

      function handleMouseDown(e){
        canMouseX=parseInt(e.clientX-offsetX);
        canMouseY=parseInt(e.clientY-offsetY);
        // set the drag flag
        isDragging=true;
      }

      function handleMouseUp(e){
        canMouseX=parseInt(e.clientX-offsetX);
        canMouseY=parseInt(e.clientY-offsetY);
        // clear the drag flag
        isDragging=false;
      }

      function handleMouseOut(e){
        canMouseX=parseInt(e.clientX-offsetX);
        canMouseY=parseInt(e.clientY-offsetY);
        // user has left the canvas, so clear the drag flag
        //isDragging=false;
      }

      function handleMouseMove(e){
        canMouseX=parseInt(e.clientX-offsetX);
        canMouseY=parseInt(e.clientY-offsetY);
        // if the drag flag is set, clear the canvas and draw the image
        if(isDragging){
          ctx.clearRect(0,0,canvasWidth,canvasHeight);
          ctx.drawImage(img,canMouseX-128/2,canMouseY-120/2,128,120);
        }
      }

      $("#canvas").mousedown(function(e){handleMouseDown(e);});
      $("#canvas").mousemove(function(e){handleMouseMove(e);});
      $("#canvas").mouseup(function(e){handleMouseUp(e);});
      $("#canvas").mouseout(function(e){handleMouseOut(e);});

    }); // end $(function(){});
  </script>

</head>

<body>
<canvas id="canvas" width=400 height=300></canvas>
</body>
</html>