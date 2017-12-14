class Lighting {
  private PGraphics lighting;
  private PVector position;
  private float radius;
  
  Lighting(PVector position, float radius) {
    this.position = position.copy();
    this.radius = radius;
    
    int size = min(width, height) / 4;
    
    lighting = createGraphics(size, size);
    lighting.beginDraw();
    lighting.loadPixels();
    float radiusOfNormal = size / 4.0;
    for (int line = 0; line != lighting.height; line++)
      for (int column = 0; column != lighting.width; column++) {
        int pixel = line * lighting.width + column;
        float distance = dist(column, line, lighting.width / 2, lighting.height / 2);
        float factor = exp(-sqr(distance / radiusOfNormal));
        lighting.pixels[pixel] = color(factor * 255);
      }
    lighting.updatePixels();
    lighting.endDraw();
  }
  
  void update() {
    position.set(player.position());
    radius -= 0.5;
    if (radius < 0)
      radius = 0;
  }
  
  void apply() {
    pushStyle();
    rectMode(CORNER);
    fill(0);
    stroke(0);
    if (position.y - radius > 0)
      rect(0, 0, width, position.y - radius);
    if (position.y + radius < height)
      rect(0, position.y + radius, width, height - position.y - radius);
  
    if (position.x - radius > 0)
      rect(0, 0, position.x - radius, height);
    if (position.x + radius < width)
      rect(position.x + radius, 0, width - position.x - radius, height);
    blendMode(MULTIPLY);
    imageMode(CENTER);
    image(lighting, position.x, position.y, 2 * radius, 2 * radius);
    popStyle();
  }
}