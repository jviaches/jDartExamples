import 'dart:html';

CanvasElement context = query("#canvasImage");
CanvasRenderingContext2D ctx = context.context2D;

ImageElement image = new ImageElement(src: "slava.jpg");

void main() {
  drawImage();
  
}

void applyFilter(){
  ImageData imageData = ctx.getImageDataHD(0, 0, 400, 600);
  var pixels = imageData.data;  
  var numPixels = imageData.width * imageData.height;
  
  for (var i = 0; i < numPixels; i++) {  
    pixels[i*4] = 255-pixels[i*4]; // Red  
    pixels[i*4+1] = 255-pixels[i*4+1]; // Green  
    pixels[i*4+2] = 255-pixels[i*4+2]; // Blue  
};  

  ctx.fillStyle = "white";
  
ctx.beginPath();
ctx.clearRect(0, 0, context.width, context.height);
ctx.fill();
ctx.closePath();

ctx.putImageData(imageData, 80, 80);

}

void drawImage(){
 
  var x = context.width / 2;
  var y = context.height /2;
  
  image.onLoad.listen(onData, onError: onError, onDone: onDone, cancelOnError: true);  
}

onData(Event e) {
  print("success: ");
  ctx.drawImage(image, 0, 0);
  
  applyFilter();
}

onError(Event e) {
  print("error: $e");
}

onDone() {
  print("done");
}