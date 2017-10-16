void setup() {
  size(500, 500);
}

void draw() {
  drawCoordinateSystem(#000000, 500, 500);
  fill(192, 128);
  stroke(#000000);
  rect(100, 50, 100, 200);
       
  drawShearX(#0000FF, PI / 8);
  shearX(PI / 8);
  
  drawCoordinateSystem(#0000FF, 500, 500);
  fill(192, 128);
  stroke(#0000FF);
  rect(100, 50, 100, 200);
}