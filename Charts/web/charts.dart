import 'dart:html';
import 'dart:math' as math;

void main() {

  List data = new List(5);
  data[0] = 75;
  data[1] = 68;
  data[2] = 32;
  data[3] = 95;
  data[4] = 20;
  
  List colors = new List(5);
  colors[0] = "#7E3817";
  colors[1] = "#C35817";
  colors[2] = "#307D7E";
  colors[3] = "#A0C544";
  colors[4] = "#348017";
    
  DrawPieChart(data, colors);
  DrawChartDetails(data, colors);
  
}

void DrawPieChart(List dataValues, List colors){
  CanvasElement context = query('#canvasId');
  CanvasRenderingContext ctx =  context.context2D;
  
  var x = context.width / 2;
  var y = context.height / 2;
  
  var radius = context.width / 3;  
  var lastPosition = 0, total = 0;
  
  dataValues.forEach((value){
    total +=value;
  });

  for (var i = 0; i < dataValues.length; i++) {

    ctx.fillStyle = colors[i];

    ctx.beginPath();

    ctx.moveTo(x,y);

    ctx.arc(x,y,radius,lastPosition,lastPosition+(math.PI*2*(dataValues[i]/total)),false);

    ctx.fill();

    lastPosition += math.PI*2*(dataValues[i]/total);

  }
}

void DrawChartDetails(List dataValues, List colors){
  CanvasElement context = query('#canvasId');
  CanvasRenderingContext ctx =  context.context2D;
  
  for (var i = 0; i < dataValues.length; i++) {

    ctx.fillStyle = colors[i];

    ctx.beginPath();

    ctx.rect(context.width - 30, context.height - 10* (i+1), 10, 10);
    
    ctx.fillText(dataValues[i].toString(),context.width - 20, context.height - 10* i);
    ctx.fill();
    ctx.closePath();
  }
}