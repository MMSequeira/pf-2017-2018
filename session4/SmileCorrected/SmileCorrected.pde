void drawSmile() {
  fill(#AD2530);
  ellipse(0, 0, 200, 200);
  fill(0);
  float size = 200;
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
  translate(200, 200);
  rotate(QUARTER_PI);
  drawSmile();
}