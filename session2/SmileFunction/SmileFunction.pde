void drawSmile(float x, float y, float size) {
  fill(#AD2530);
  ellipse(x, y, size, size);
  fill(0);
  float eyeSize = size / 5;
  float mouthSize = size / 2.5;
  ellipse(x - size / 5, y - size / 10, eyeSize, eyeSize);
  ellipse(x + size / 5, y - size / 10, eyeSize, eyeSize);
  arc(x, y + 10, mouthSize, mouthSize, 0, PI);
}

void setup() {
  size(400, 400);
  background(#4264BC);
}

void draw() {
  drawSmile(mouseX, mouseY, 50);
  drawSmile(mouseX + 100, mouseY + 100, 100);
}