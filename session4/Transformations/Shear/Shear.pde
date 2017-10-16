void setup() {
  size(500, 500);
}

void draw() {
  fill(192, 128);
  stroke(#000000);
  rect(100, 50, 100, 200);
     
  shearX(PI / 8);
  
  fill(192, 128);
  stroke(#0000FF);
  rect(100, 50, 100, 200);
}