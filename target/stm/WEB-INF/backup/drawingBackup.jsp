<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<!DOCTYPE html>

<html lang="ko">
<head>
  <title>그래픽 에디터 테스트</title>
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.css">
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
  <%--<script src="/resources/bootstrap-3.3.2-dist/js/jquery-1.11.3.min.js"></script>--%>
  <%--<script src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>--%>

  <script type="text/javascript">

    $(document).ready(function(){
      alert(1);
    });

    (function(){
      //간단한 상속 처리
      Object.prototype.extends = function(obj) {
        for (var i in obj) {
          if (obj.hasOwnProperty(i)) {
            this[i] = obj[i];
          }
        }
      };

    })();


    var _ACTIVEBOX_OFFSET_ = -2;
    var _ADJBOX_OFFSET_ = -3;

    // 객체 생성
    var $Class = function(_c) {

      function  _obj() {
        this.$constructor.apply(this, arguments);
      }

      _obj.prototype = _c;
      _obj.prototype.constructor = _obj;
      return _obj;
    }

    //사각형... 나중에 Object 형으로 개발해야할듯...
    var Rect = $Class({


      //생성자
      $constructor : function(config){

        this._config = {

          x:100, //x포인트
          y:100, // y포인트
          priority: null, // 우선도.. 차후 구현.
          width:100, // 크기
          height:100,
          color:'yellow',  // 색상
          offsetX: 0, // 오프셋
          offsetY:0
        };
        //설정이 없는경우 디폴트값 셋팅
        this._config.extends(config);
        this.selectionHandles=new Array();
        this.selectionHandles.push({x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0});


      },
      // 도형 그리기
      draw: function(ctx){

        var adj_x = (this._config.x)-2, adj_y= (this._config.y)-2, adj_width=(this._config.width)+4, adj_height=(this._config.height)+4;

        this.selectionHandles[0].x =adj_x+_ADJBOX_OFFSET_;
        this.selectionHandles[0].y =adj_y+_ADJBOX_OFFSET_;

        this.selectionHandles[1].x = adj_x+_ADJBOX_OFFSET_+adj_width/2;
        this.selectionHandles[1].y = adj_y+_ADJBOX_OFFSET_;

        this.selectionHandles[2].x = adj_x+_ADJBOX_OFFSET_+adj_width;
        this.selectionHandles[2].y = adj_y+_ADJBOX_OFFSET_;

        this.selectionHandles[3].x =adj_x+_ADJBOX_OFFSET_;
        this.selectionHandles[3].y = adj_y+_ADJBOX_OFFSET_+adj_height/2;

        this.selectionHandles[4].x =adj_x+_ADJBOX_OFFSET_+adj_width;
        this.selectionHandles[4].y =adj_y+_ADJBOX_OFFSET_+adj_height/2;

        this.selectionHandles[5].x = adj_x+_ADJBOX_OFFSET_;
        this.selectionHandles[5].y =adj_y+_ADJBOX_OFFSET_+adj_height;

        this.selectionHandles[6].x =adj_x+_ADJBOX_OFFSET_+adj_width/2;
        this.selectionHandles[6].y =adj_y+_ADJBOX_OFFSET_+adj_height;

        this.selectionHandles[7].x =adj_x+_ADJBOX_OFFSET_+adj_width;
        this.selectionHandles[7].y =adj_y+_ADJBOX_OFFSET_+adj_height;
        ctx.strokeStyle = this._config.color;
        ctx.strokeRect(this._config.x,this._config.y,this._config.width,this._config.height);
        if(this.selected){
          ctx.strokeStyle ='darkred';
          ctx.strokeRect(adj_x,adj_y,adj_width,adj_height);
          ctx.fillStyle ='darkred';
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_,adj_y+_ADJBOX_OFFSET_,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width/2,adj_y+_ADJBOX_OFFSET_,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width,adj_y+_ADJBOX_OFFSET_,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_, adj_y+_ADJBOX_OFFSET_+adj_height/2,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_,adj_y+_ADJBOX_OFFSET_+adj_height,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width/2,adj_y+_ADJBOX_OFFSET_+adj_height,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width,adj_y+_ADJBOX_OFFSET_+adj_height,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width,adj_y+_ADJBOX_OFFSET_+adj_height/2,6,6);

        }

      },

    });

    var Img = $Class({

      selected: false,
      onload : false,
      $constructor : function(config){

        this._config = {

          x:100,
          y:100,
          priority: null,
          width:100,
          height:100,
          offsetX: 0,
          offsetY:0
        };

        this._config.extends(config);
        this.selectionHandles=new Array();
        this.selectionHandles.push({x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0});


      },

      draw: function(ctx){


        var adj_x = (this._config.x)-2, adj_y= (this._config.y)-2, adj_width=(this._config.width)+4, adj_height=(this._config.height)+4;

        this.selectionHandles[0].x =adj_x+_ADJBOX_OFFSET_;
        this.selectionHandles[0].y =adj_y+_ADJBOX_OFFSET_;

        this.selectionHandles[1].x = adj_x+_ADJBOX_OFFSET_+adj_width/2;
        this.selectionHandles[1].y = adj_y+_ADJBOX_OFFSET_;

        this.selectionHandles[2].x = adj_x+_ADJBOX_OFFSET_+adj_width;
        this.selectionHandles[2].y = adj_y+_ADJBOX_OFFSET_;

        this.selectionHandles[3].x =adj_x+_ADJBOX_OFFSET_;
        this.selectionHandles[3].y = adj_y+_ADJBOX_OFFSET_+adj_height/2;

        this.selectionHandles[4].x =adj_x+_ADJBOX_OFFSET_+adj_width;
        this.selectionHandles[4].y =adj_y+_ADJBOX_OFFSET_+adj_height/2;

        this.selectionHandles[5].x = adj_x+_ADJBOX_OFFSET_;
        this.selectionHandles[5].y =adj_y+_ADJBOX_OFFSET_+adj_height;

        this.selectionHandles[6].x =adj_x+_ADJBOX_OFFSET_+adj_width/2;
        this.selectionHandles[6].y =adj_y+_ADJBOX_OFFSET_+adj_height;

        this.selectionHandles[7].x =adj_x+_ADJBOX_OFFSET_+adj_width;
        this.selectionHandles[7].y =adj_y+_ADJBOX_OFFSET_+adj_height;

        /*if(this.onload){
         var imgData = ctx.getImageData(this._config.x, this._config.y, this._config.width, this._config.height);

         ctx.putImageData(imgData, this._config.x,this._config.y);
         }else{
         var img = document.getElementById(this._config.url);
         img.crossOrigin="anonymous";
         ctx.drawImage(img, this._config.x, this._config.y, this._config.width, this._config.height);
         this.onload = true;

         }*/
        var img = document.getElementById(this._config.url);
        img.crossOrigin="anonymous";
        ctx.drawImage(img, this._config.x, this._config.y, this._config.width, this._config.height);
        if(this.selected){
          ctx.strokeStyle ='darkred';
          ctx.strokeRect(adj_x,adj_y,adj_width,adj_height);
          ctx.fillStyle ='darkred';
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_,adj_y+_ADJBOX_OFFSET_,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width/2,adj_y+_ADJBOX_OFFSET_,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width,adj_y+_ADJBOX_OFFSET_,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_, adj_y+_ADJBOX_OFFSET_+adj_height/2,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_,adj_y+_ADJBOX_OFFSET_+adj_height,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width/2,adj_y+_ADJBOX_OFFSET_+adj_height,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width,adj_y+_ADJBOX_OFFSET_+adj_height,6,6);
          ctx.fillRect(adj_x+_ADJBOX_OFFSET_+adj_width,adj_y+_ADJBOX_OFFSET_+adj_height/2,6,6);
        }



        //	 this.onload = true;

      },

    });

    var Canvas = {

      canvas : null, //캔바스
      ctx : null, //컨텍스트
      queue : [], // 오브젝트 큐
      isDrag : false, // 마우스누르기 플래그
      isActive: false, //활성화여부
      isResize : false, //사이즈조절 여부
      direction : -1, //사이즈조절방향
      mouseX: 0,
      mouseY: 0,

      //초기화
      init : function(c){
        this.canvas=document.getElementById(c);
        this.ctx =  canvas.getContext('2d');
        //캔바스 이벤트 바인드 및 소유권 전달
        this.canvas.addEventListener("mousedown", this.mouseDown.bind(this),false);
        this.canvas.addEventListener("mousemove", this.moveMouse.bind(this),false);
        this.canvas.addEventListener("mouseup", this.mouseUp.bind(this),false);
        //this.canvas.addEventListener("click", this.mouseClick.bind(this),false);
      },
      //마우스이벤트
      mouseUp: function (){

        this.isDrag = false;
        this.isResize = false;
        return;

      },

      mouseDown : function (e){


        this.isDrag = true;
        //사이즈 조절시에는 리턴
        if(this.isResize) return;
        this.isActive = false;
        this.inActive();
        this.active();

        this.drawCanvase();
        return;
      },
      //비활성화
      inActive: function(){

        for(var i=0;i <  this.queue.length;i++)
        {
          var r=  this.queue[i];
          r.selected = false;

        }
      },
      active: function(){
        for(var i=0;i <  this.queue.length;i++)
        {
          var r=  this.queue[i];
          //포인터가 오브젝트 범위안에 있음.
          if( this.mouseX >r._config.x &&  this.mouseX<(r._config.width+r._config.x)
                  &&  this.mouseY > r._config.y &&  this.mouseY<(r._config.height+r._config.y) ){
            r.selected = true;
            r._config.offsetX  = Math.abs(r._config.x- this.mouseX)  //mousePoint
            r._config.offsetY  = Math.abs(r._config.y- this.mouseY)  //mousePoint
            this.isActive = true;
            return;
          }
        }

      },


      //캔바스를 그린다.
      drawCanvase : function (){
        this.ctx.clearRect(0,0,960,600);
        for(var i=0;i < this.queue.length;i++)
        {
          var r= this.queue[i];

          if(r.selected){
            if(this.isResize== false){
              r._config.x =  this.mouseX -r._config.offsetX;
              r._config.y =  this.mouseY -r._config.offsetY ;
            }

          }
          r.draw(this.ctx);
        }

      },



      moveMouse: function(e) {

        var element = this.canvas, offsetX = 0, offsetY = 0;

        if (element.offsetParent) {
          do {
            offsetX += element.offsetLeft;
            offsetY += element.offsetTop;
          } while ((element = element.offsetParent));
        }

        this.mouseX = e.pageX - offsetX;
        this.mouseY= e.pageY - offsetY
        //이동
        if(this.isDrag && !this.isResize ){
          this.drawCanvase();
          return;
        }
        //오브젝트 활성화일때만.
        if(this.isActive){
          this.resizeCursor();
        }
        //크기조절
        if(this.isResize && this.isDrag){

          this.resize();
          this.drawCanvase();

        }
      },
      resize : function(){

        for(var i=0;i <  this.queue.length;i++)
        {
          var r=  this.queue[i];
          if(r.selected){
            // 0  1  2
            // 3     4
            // 5  6  7
            switch (this.direction) {
              case 0:
                r._config.width += r._config.x - this.mouseX;
                r._config.height += r._config.y - this.mouseY;
                r._config.x= this.mouseX;
                r._config.y = this.mouseY;
                break;
              case 1:

                r._config.height += 	r._config.y  - this.mouseY;
                r._config.y = this.mouseY;
                break;
              case 2:
                r._config.height += r._config.y - this.mouseY;
                r._config.width = this.mouseX - r._config.x;
                r._config.y = this.mouseY;

                break;
              case 3:

                r._config.width += r._config.x - this.mouseX;
                r._config.x = this.mouseX;
                break;
              case 4:
                r._config.width = this.mouseX - r._config.x;
                break;
              case 5:

                r._config.width += r._config.x - this.mouseX;
                r._config.height = this.mouseY - r._config.y;
                r._config.x = this.mouseX;
                break;
              case 6:
                r._config.height = this.mouseY - r._config.y;
                break;
              case 7:
                r._config.width = this.mouseX - r._config.x;
                r._config.height = this.mouseY - r._config.y;
                break;
            }
          }
        }


      },
      resizeCursor : function (){
        //드래그이벤트일경우 발생하지 않음.
        if(this.isDrag) return;

        for(var i=0;i <  this.queue.length;i++)
        {
          var r=  this.queue[i];
          if(r.selected){

            for (var i = 0; i < 8; i++) {
              if(r.selectionHandles[i].x <  this.mouseX && r.selectionHandles[i].x +6 >  this.mouseX
                      && r.selectionHandles[i].y <  this.mouseY && r.selectionHandles[i].y+6  >  this.mouseY){
                switch (i) {
                  case 0:
                    this.canvas.style.cursor='nw-resize';
                    break;
                  case 1:
                    this.canvas.style.cursor='n-resize';
                    break;
                  case 2:
                    this.canvas.style.cursor='ne-resize';
                    break;
                  case 3:
                    this.canvas.style.cursor='w-resize';
                    break;
                  case 4:
                    this.canvas.style.cursor='e-resize';
                    break;
                  case 5:
                    this.canvas.style.cursor='sw-resize';
                    break;
                  case 6:
                    this.canvas.style.cursor='s-resize';
                    break;
                  case 7:
                    this.canvas.style.cursor='se-resize';
                    break;
                  default:
                    this.canvas.style.cursor='auto';
                    break;
                }
                this.isResize = true;
                this.direction = i;
                return;
              }else{
                //이외는 다시 포인터로 변경
                this.canvas.style.cursor='auto';
                this.isResize = false;
                this.direction = -1;
              }
            }
          }
        }

      },
      //오브젝트를 큐에 넣는다.
      addObject: function (o){
        this.queue.push(o);
      }
    };


    function init(){
      Canvas.init("canvas");
      formElement = document.getElementById("createImageData");
      formElement.addEventListener("click", createImageDataPressed, false);

      /* 초기 그림설정시 사용한다.
       var rect1 = new Rect({x:200,y:200,width:100,height:100,color:'red'});
       var rect2 = new Rect({x:50,y:50,width:100,height:100,color:'blue'	});
       var rect3 = new Rect({x:300,y:500,width:100,height:100,color:'yellow'});

       var img = new Img({x:300,y:100,width:100,height:100,url: "img"});
       var img2 = new Img({x:500,y:100,width:100,height:100,url: "img"});
       var img3 = new Img({x:10,y:10,width:50,height:50,url: "img"});
       var ball = new Img({x:10,y:10,width:50,height:50,url: "ball"});

       Canvas.addObject(rect1);
       Canvas.addObject(rect2);
       Canvas.addObject(img);
       Canvas.addObject(img2);
       Canvas.addObject(img3);
       Canvas.addObject(ball);*/

      //var img = new Img({x:300,y:100,width:100,height:100,url: "img"});
      //Canvas.addObject(img);
      //var ball = new Img({x:10,y:10,width:50,height:50,url: "ball"});
      //Canvas.addObject(ball);
      //Canvas.drawCanvase();
      init();

    }

    function removeCanvas(){
      Canvas.ctx.clearRect(0,0,960,500);
    }

    function loadCanvas(){
      Canvas.ctx.clearRect(0,0,960,500);
      Canvas.inActive();
      Canvas.drawCanvase();

    }
    function addObject(param){

      Canvas.inActive();

      if(param=='op'){
        var op = new Img({x:0,y:0,width:70,height:70,url: "op"});
        Canvas.addObject(op);
      }
      if(param=='dp'){
        var dp = new Img({x:0,y:0,width:70,height:70,url: "dp"});
        Canvas.addObject(dp);
      }
      if(param=='ball'){
        var ball = new Img({x:0,y:0,width:35,height:35,url: "ball"});
        Canvas.addObject(ball);
      }

      Canvas.drawCanvase();
    }



    function createImageDataPressed(e) {

      alert('이미지를 생성합니다.');

      var imageDataDisplay = document.getElementById("imageDataDisplay");

      var theCanvas = document.getElementById("canvas");

      imageDataDisplay.value = theCanvas.toDataURL();
      window.open(imageDataDisplay.value,"canavsImage","left=0,top=0,width=" + theCanvas.width + ",height=" + theCanvas.height +",toolbar=0,resizable=0");

    }



  </script>

  <style>
    #canvas
    {
      /*background:url("/resources/editer/football-game4.svg");*/
      border: 1px solid black;
    }
  </style>

</head>
<body onload='init()'>

<h4>그래픽 에디터 테스트</h4>

<div id="editer">
  <img  id="op" 	src="/resources/editer/uniform.svg"  width="70" height="70" onclick="addObject('op');">
  <img  id="dp" 	src="/resources/editer/clothing.svg"  width="70" height="70" onclick="addObject('dp');">
  <img  id="ball" 	src="/resources/editer/ball.svg"  width="35" height="35" onclick="addObject('ball');">
  <p></p>
  <canvas id="canvas" width="960" height="500"></canvas>
  <p>
    <button id="btn_delete" onclick="javascript:removeCanvas();" >지우기</button>
    <input type="button" id="createImageData" value="이미지저장">
  </p>
  <p>
    <textarea id="imageDataDisplay" rows=10 cols=30></textarea>
  </p>
  <p>저장된 이미지 사용방법</p>
  <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA8AAAAH0CAYAAADyokQJAAAgAElEQVR4Xu3dTbIbZZYG4M8rKGoFwAqAOREUKzC9AswKoAbUtIppewC1AmAFhVcARNBjYAXACqBW4I5zrTSybko3pcyUMvN9FOFwNZYyv/Ocow69yh89ah4ECBAgQIAAAQIECBAgQCBA4FFAjUokQIAAAQIECBAgQIAAAQJNADYEBAgQIECAAAECBAgQIBAhIABHtFmRBAgQIECAAAECBAgQICAAmwECBAgQIECAAAECBAgQiBAQgCParEgCBAgQIECAAAECBAgQEIDNAAECBAgQIECAAAECBAhECAjAEW1WJAECBAgQIECAAAECBAgIwGaAAAECBAgQIECAAAECBCIEBOCINiuSAAECBAgQIECAAAECBARgM0CAAAECBAgQIECAAAECEQICcESbFUmAAAECBAgQIECAAAECArAZIECAAAECBAgQIECAAIEIAQE4os2KJECAAAECBAgQIECAAAEB2AwQIECAAAECBAgQIECAQISAABzRZkUSIECAAAECBAgQIECAgABsBggQIECAAAECBAgQIEAgQkAAjmizIgkQIECAAAECBAgQIEBAADYDBAgQIECAAAECBAgQIBAhIABHtFmRBAgQIECAAAECBAgQICAAmwECBAgQIECAAAECBAgQiBAQgCParEgCBAgQIECAAAECBAgQEIDNAAECBAgQIECAAAECBAhECAjAEW1WJAECBAgQIECAAAECBAgIwGaAAAECBAgQIECAAAECBCIEBOCINiuSAAECBAgQIECAAAECBARgM0CAAAECBAgQIECAAAECEQICcESbFUmAAAECBAgQIECAAAECArAZIECAAAECBAgQIECAAIEIAQE4os2KJECAAAECBAgQIECAAAEB2AwQIECAAAECBAgQIECAQISAABzRZkUSIECAAAECBAgQIECAgABsBggQIECAAAECBAgQIEAgQkAAjmizIgkQIECAAAECBAgQIEBAADYDBAgQIECAAAECBAgQIBAhIABHtFmRBAgQIECAAAECBAgQICAAmwECBAgQIECAAAECBAgQiBAQgCParEgCBAgQIECAAAECBAgQEIDNAAECBAgQIECAAAECBAhECAjAEW1WJAECBAgQIECAAAECBAgIwGaAAAECBAgQIECAAAECBCIEBOCINiuSAAECBAgQIECAAAECBARgM0CAAAECBAgQIECAAAECEQICcESbFUmAAAECBAgQIECAAAECArAZIECAAAECBAgQIECAAIEIAQE4os2KJECAAAECBAgQIECAAAEB2AwQIECAAAECBAgQIECAQISAABzRZkUSIECAAAECBAgQIECAgABsBggQIECAAAECBAgQIEAgQkAAjmizIgkQIECAAAECBAgQIEBAADYDBAgQIECAAAECBAgQIBAhIABHtFmRBAgQIECAAAECBAgQICAAmwECBAgQIECAAAECBAgQiBAQgCParEgCBAgQIECAAAECBAgQEIDNAAECBAgQIECAAAECBAhECAjAEW1WJAECBAgQIECAAAECBAgIwGaAAAECBAgQIECAAAECBCIEBOCINiuSAAECBAgQIECAAAECBARgM0CAAAECBAgQIECAAAECEQICcESbFUmAAAECBAgQIECAAAECArAZIECAAAECBAgQIECAAIEIAQE4os2KJECAAAECBAgQIECAAAEB2AwQIECAAAECBAgQIECAQISAABzRZkUSIECAAAECBAgQIECAgABsBggQIECAAAECBAgQIEAgQkAAjmizIgkQIECAAAECBAgQIEBAADYDBAgQIECAAAECBAgQIBAhIABHtFmRBAgQIECAAAECBAgQICAAmwECBAgQIECAAAECBAgQiBAQgCParEgCBAgQIECAAAECBAgQEIDNAAECBAgQIECAAAECBAhECAjAEW1WJAECBAgQIECAAAECBAgIwGaAAAECBAgQIECAAAECBCIEBOCINiuSAAECBAgQIECAAAECBARgM0CAAAECBAgQIECAAAECEQICcESbFUmAAAECBAgQIECAAAECArAZIECAAAECBAgQIECAAIEIAQE4os2KJECAAAECBAgQIECAAAEB2AwQIECAAAECBAgQIECAQISAABzRZkUSIECAAAECBAgQIECAgABsBggQIECAAAECBAgQIEAgQkAAjmizIgkQIECAAAECBAgQIEBAADYDBAgQIECAAAECBAgQIBAhIABHtFmRBAgQIECAAAECBAgQICAAmwECBAgQIECAAAECBAgQiBAQgCParEgCBAgQIECAAAECBAgQEIDNAAECBAgQIECAAAECBAhECAjAEW1WJAECBAgQIECAAAECBAgIwGaAAAECBAgQIECAAAECBCIEBOCINiuSAAECBAgQIECAAAECBARgM0CAAAECBAgQIECAAAECEQICcESbFUmAAAECBAgQIECAAAECArAZuCfwtLXnfSyftnb2vDxt7Z+ttX8dbu95a5/9o+e/P9SOKdf20L78OwECBAgQIECAAAEC2xI4O9Bsq3zV9AlMGTIFYDNGgAABAgQIECBAgMBSBATgpXRiQes4FoDrqO25y3zU2nuttb/1vO675619f8H26ojyvcclR6fP3bfnEyBAgAABAgQIECCwbgEBeN39m2X11wrArbXvLijg3unUtQ0B+AJJLyFAgAABAgQIECAQJiAAhzV8SLlOgR6i5DkECBAgQIAAAQIECKxNQABeW8eusN6JAvDbrbXHj1t78m5rbxwu+4fWfn3W2lettWettZ+GljXR2obuzvMIECBAgAABAgQIENiQgAC8oWZOXcr/7u7SfMbdml9rrX3cWvufXaitU5y/aa390bO2CsWft9Y+aK392l6E4X8fee69l9fNtZ639uiMtU3NY3vbE6iZfH2vrN92s3mNSuta+cPH2dfIX2Oh9kGAAAECBAgQWLOAALzm7s289jMDcN2cqoLvF7swe2p1FZT/03NzrArKdY1vBeGTDwH4ISH/PkCgzlL4sLVWf/fdqK02UTd+673ufMD2hzyl9v1ta63eE32P+nKovkiqddT/9iBAgAABAgQIEBghIACPwNv6SwcG4PrgXh/g61Tm/aBQ/72OatUR3jqydixg9DHWKdHvnzoaLABvffpmra9msr6wqfA55FGzeMkN24Zs+8cz1lFr+EgQHsLqOQQIECBAgACBfgEB2GQcFRgQgLujV3Xktk517o7cVriokFGnkO6fBt1d61thuJ7/lyM7r+39d7eN3uuDBWCDe4FAzV3N5jlfxtRuaoYrBE/9eNJa+/KCjdZZFnVEuO/Sggs25yUECBAgQIAAgRwBATin12dX+kAArvBbR6/6Hl/vToU+dXOren0Fi2MhuMJ0PeeTvptkCcBntzP5BXUGQgXfCpyXPuY4CvzL7uyIS9ZUp0PX0eC5jkxfsiavIUCAAAECBAgsXkAAXnyLbrfAEwG4Tm+uD++H1y3WEd868jv0rs6nQnAd3Xpnd6S4jti9crRLAL7dXKxszxV860uUY9fYDi1n6qPAlx79PVxvnUnxd6dFD22j5xEgQIAA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AE/jaCsECBAgQIAAAQIECJwQEICNxxIEBOAldMEaCBAgQIAAAQIECGxcQADeeINXUp4AvJJGWSYBAgQIECBAgACBNQsIwGvu3nbWLgBvp5cqIUCAAAECBAgQILBYAQF4sa2JWpgAHNVuxRIgQIAAAQIECBC4jYAAfBt3e31VQAA2EQQIECBAgAABAgQIzC4gAM9ObAcDBATgAUieQoAAAQIECBAgQIDAOAEBeJyfV08jIABP42grBAgQIECAAAECBAicEBCAjccSBATgJXTBGggQIECAAAECBAhsXEAA3niDV1KeALySRlkmAQIECBAgQIAAgTULCMBr7t521i4Ab6eXKiFAgAABAgQIECCwWAEBeLGtiVqYABzVbsUSIECAAAECBAgQuI2AAHwbd3t9VaAvAH/VWvt1IVBvtNaeHKzl/dbadwtZn2UQIECAAAECBAgQIDBAQAAegOQpswv0BeDZdzpyBwLwSEAvJ0CAAAECBAgQIHBtAQH42uL21ycgAJsLAgQIECBAgAABAgRmFxCAZye2gwECAvAAJE8hQIAAAQIECBAgQGCcgAA8zs+rpxEQgKdxtBUCBAgQIECAAAECBE4ICMDGYwkC7gK9hC5YAwECBAgQIECAAIGNCwjAG2/wSsoTgFfSKMskQIAAAQIECBAgsGYBAXjN3dvO2vsC8CettZ8WUuLbrbUvDtbiLtALaY5lECBAgAABAgQIEBgqIAAPlfK8OQVcAzynrm0TIECAAAECBAgQIHAnIAAbhCUICMBL6II1ECBAgAABAgQIENi4gAC88QavpLw1BuB3FnSK9krabJkECBAgQIAAAQIEbisgAN/W397/FPimtfZ4JSBft9aerGStlkmAAAECBAgQIECAwE5AADYKSxKom029tqQF9azlD0d+F94hyyNAgAABAgQIECBwREAANhoECBAgQIAAAQIECBAgECEgAEe0WZEECBAgQIAAAQIECBAgIACbAQIECBAgQIAAAQIECBCIEBCAI9qsSAIECBAgQIAAAQIECBAQgM0AAQIECBAgQIAAAQIECEQICMARbVYkAQIECBAgQIAAAQIECAjAZoAAAQIECBAgQIAAAQIEIgQE4Ig2K5IAAQIECBAgQIAAAQIEBGAzQIAAAQIECBAgQIAAAQIRAgJwRJsVSYAAAQIECBAgQIAAAQICsBkgQIAAAQIE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">

</div>

</body>
</html>