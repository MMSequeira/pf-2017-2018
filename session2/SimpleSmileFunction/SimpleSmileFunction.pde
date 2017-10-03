void drawSmile() {
  fill(#AD2530);
  ellipse(mouseX, mouseY, 50, 50);
  fill(0);
  ellipse(mouseX - 10, mouseY - 5, 10, 10);
  ellipse(mouseX + 10, mouseY - 5, 10, 10);
  arc(mouseX, mouseY + 10, 20, 20, 0, PI);
}

void setup() {
  size(400, 400);
  background(#4264BC);
}

void draw() {
  // background(#4264BC);
  drawSmile();
}