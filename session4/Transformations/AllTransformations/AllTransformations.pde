void setup() {
  size(500, 500);
}

void draw() {
  fill(192, 128);
  stroke(#000000);
  rect(100, 50, 100, 200);
     
  translate(150, 100);
  
  fill(192, 128);
  stroke(#FF0000);
  rect(100, 50, 100, 200);
  
  rotate(QUARTER_PI);
  
  fill(192, 128);
  stroke(#00FF00);
  rect(100, 50, 100, 200);
  
  shearX(PI / 8);
  
  fill(192, 128);
  stroke(#0000FF);
  rect(100, 50, 100, 200);

  scale(0.5, 1);
  
  fill(192, 128);
  stroke(#FFFF00);
  rect(100, 50, 100, 200);
}