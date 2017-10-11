color backgroundColor = color(255, 255, 255); // or #FFFFFF

void setup() {
  size(500, 500);
}

void draw() {
  background(backgroundColor);
}

void mouseClicked() {
  if (mouseX < width / 2) {
    backgroundColor = color(255, 0, 0); // #FF0000
  } else {
    backgroundColor = color(0, 255, 0); // #00FF00
  }
}