void setup() {
  size(500, 500);
  background(255);
}

void draw() {
}

void mouseClicked() {
  if (mouseX < width / 2) {
    // background(255, 0, 0);
    background(#FF0000);
  } else {
    background(#00FF00);
  }
}