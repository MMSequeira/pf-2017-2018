void setup() {
  size(500, 500);
}

void draw() {
  drawCoordinateSystem(#000000, 500, 500);
  fill(192, 128);
  stroke(#000000);
  rect(100, 50, 100, 200);
       
  drawRotation(#00FF00, QUARTER_PI);
  rotate(QUARTER_PI);
  
  drawCoordinateSystem(#00FF00, 650, 200);
  fill(192, 128);
  stroke(#00FF00);
  rect(100, 50, 100, 200);
}