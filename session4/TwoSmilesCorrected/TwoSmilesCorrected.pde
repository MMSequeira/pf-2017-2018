void drawSmile(float size) {
  fill(#AD2530);
  ellipse(0, 0, size, size);
  fill(0);
  float eyeSize = size / 5;
  float mouthSize = size / 2.5;
  ellipse(-size / 5, -size / 10, eyeSize, eyeSize);
  ellipse(size / 5, -size / 10, eyeSize, eyeSize);
  arc(0, 10, mouthSize, mouthSize, 0, PI);
}

void setup() {
  size(400, 400);
  background(#4264BC);
}

void draw() {
  background(#4264BC);
  
  pushMatrix();
  
  translate(100, 100);
  rotate(QUARTER_PI);  
  drawSmile(50);
  
  popMatrix();
  
  translate(200, 200);
  rotate(-QUARTER_PI);
  drawSmile(50);
}