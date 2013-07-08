import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';

void main() {
  
  RoundedClockWidget clock = new RoundedClockWidget('red', 'canvas');
  clock.ShowRefrashableTime();
}

class RoundedClockWidget{
  
  num _x,_y;
  var _backGroundColor;
  String _canvasId;

  CanvasElement _canvas;
  CanvasRenderingContext2D _context;
  
  RoundedClockWidget(backGroundColor, canvasId){

    setCanvasId(canvasId);    
    _canvas =  document.query(_canvasId);
    _context = _canvas.getContext('2d');
    
    setX(_canvas.width / 2);
    setY(_canvas.height / 2);
    
    setBackgroundColor(backGroundColor);
  }
  
  setX(num newX)=> _x = newX;
  
  setY(num newY)=> _y = newY;
  
  setCanvasId(String newCanvasId) =>  _canvasId = '#' + newCanvasId;
  
  setBackgroundColor(newBackGroundColor) => _backGroundColor = newBackGroundColor;
  
  void ShowRefrashableTime() { 
    
    new Timer.periodic(new Duration(seconds: 1), (_) {

      var now = new DateTime.now();
      var formatter = new DateFormat('HH:mm:ss');
      String formatted = formatter.format(now);
      
      drawHours(now) ;
      drawMinutes(now);
      drawSeconds(now);
      
      drawTextTime(formatted);
    });
  }
  
  void drawTextTime(String formattedTime){
    
    var backGroundColor = '#F8F8F8';    
    clearCanvasText(_context, backGroundColor, _x-30, _y-20);
    
    _context.fillStyle = 'black';
    _context.font='14pt bold Calibri';
    _context.fillText(formattedTime, _x-30, _y);
    
    _context.fillText(formattedTime, _x-30, _y);
  }
  
  void drawHours(now) {

    var radius = 45;
    var startAngle = 0 * PI;
    var endAngle = (2.0 * PI)/24 * now.hour;
    var counterClockwise = false;
    
    if(now.hour == 0){
      var backGroundColor = '#F8F8F8';
      clearArc(_canvas, _context, counterClockwise,backGroundColor, radius);
    }
    
    _context.beginPath();
    _context.arc(_x, _y, radius, startAngle, endAngle, counterClockwise);
    _context.lineWidth = 9;

    var grad = _context.createRadialGradient(_x,_y,5,90,60,100);
    grad.addColorStop(0,'#FF7F50');
    grad.addColorStop(1,'#C35817');
    _context.strokeStyle = grad;
    
    _context.stroke();
  }  
  
  void drawMinutes(now) {

    var radius = 55;
    var startAngle = 0 * PI;
    var endAngle = (2.0 * PI)/60 * now.minute;
    var counterClockwise = false;
    
    if(now.minute == 0){      
      var backGroundColor = '#F8F8F8';
      clearArc(_canvas, _context, counterClockwise,backGroundColor, radius);
    }
    
    _context.beginPath();
    _context.arc(_x, _y, radius, startAngle, endAngle, counterClockwise);
    _context.lineWidth = 7;
    
    var grad = _context.createRadialGradient(_x,_y,5,90,60,100);
    grad.addColorStop(0,'lime');
    grad.addColorStop(1,'green');
    _context.strokeStyle = grad;
    
    _context.stroke();
  }
  
  void drawSeconds(now) {

    var radius = 65;
    var startAngle = 0 * PI;
    var endAngle = (2.0 * PI)/60 * now.second;
    var counterClockwise = false;
    
    if(now.second == 0){
      var backGroundColor = '#F8F8F8';
      clearArc(_canvas, _context, counterClockwise,backGroundColor, radius);
    }
    
    _context.beginPath();
    _context.arc(_x, _y, radius, startAngle, endAngle, counterClockwise);
    _context.lineWidth = 5;
    
    var grad = _context.createRadialGradient(_x,_y,5,90,60,100);
    grad.addColorStop(0,'red');
    grad.addColorStop(1,'yellow');
    _context.strokeStyle = grad;
    
    _context.stroke();
  }
  
  void clearCanvasText(CanvasRenderingContext2D context, backGroundColor, x, y) {
    context.fillStyle = backGroundColor;
    context.fillRect (x, y, 62, 30);
  }
  
  void clearArc(CanvasElement canvas, CanvasRenderingContext2D context, counterClockwise,backGroundColor, arcRadius) {

    var radius = arcRadius;
    var startAngle = 0 * PI;
    var endAngle = 2.0 * PI;
    
    context.beginPath();
    context.arc(_x, _y, radius, startAngle, endAngle, counterClockwise);
    context.lineWidth = 14;
    context.strokeStyle = backGroundColor;
    context.stroke();
  }
}
