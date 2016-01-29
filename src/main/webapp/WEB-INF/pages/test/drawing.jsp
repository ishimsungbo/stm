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



            //이미지 저장을 위한 코딩

            formElement = document.getElementById("createImageData");
            formElement.addEventListener("click", createImageDataPressed, false);


            formElement = document.getElementById("test");
            formElement.addEventListener("click", test, false);
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


    <input type="button" id="test" value="그림">

</div>
<canvas id="canvas1" width="960" height="500"></canvas>
</body>
</html>