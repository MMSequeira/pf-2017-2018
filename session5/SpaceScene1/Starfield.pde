class Starfield {
  PImage image;

  Starfield(int numberOfStars) {
    PGraphics graphics = createGraphics(width, height);
    graphics.beginDraw();
    graphics.background(0);
    graphics.noFill();
    graphics.stroke(255);
    for (int i = 0; i != numberOfStars; i++) {
      graphics.strokeWeight(random(1, 4));
      graphics.point(random(0, width), random(0, height));
    }
    graphics.endDraw();
    image = graphics.get();
  }
  
  void display() {
    imageMode(CORNER);
    image(image, 0, 0);
  }
}