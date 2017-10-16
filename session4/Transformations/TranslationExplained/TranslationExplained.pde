void setup() {
  size(500, 500);
}

void draw() {
  drawCoordinateSystem(#000000, 500, 500);
  fill(192, 128);
  stroke(#000000);
  rect(100, 50, 100, 200);
     
  drawTranslation(#FF0000, 150, 100);
  translate(150, 100);
  
  drawCoordinateSystem(#FF0000, 350, 400);
  fill(192, 128);
  stroke(#FF0000);
  rect(100, 50, 100, 200);
}