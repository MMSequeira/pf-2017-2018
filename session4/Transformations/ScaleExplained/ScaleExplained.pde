void setup() {
  size(500, 500);
}

void draw() {
  drawCoordinateSystem(#000000, 500, 500);
  fill(192, 128);
  stroke(#000000);
  rect(100, 50, 100, 200);
     
  scale(0.5, 1);
  
  drawCoordinateSystem(#FFFF00, 1000, 500);
  fill(192, 128);
  stroke(#FFFF00);
  rect(100, 50, 100, 200);
}