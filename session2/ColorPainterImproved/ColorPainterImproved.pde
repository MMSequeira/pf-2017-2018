boolean mouseIsDown = false;

void setup() {
  size(400, 400);
  background(#4264BC);
}

void draw() {
  if (mouseIsDown) {
    fill(#AD2530);
    ellipse(mouseX, mouseY, 50, 50);
  }
}

void mousePressed() {
  mouseIsDown = true;
}

void mouseReleased() {
  mouseIsDown = false;
}