class Snake {
  float x, y;
  float diameter;
  int numberOfRings;
  
  Snake(int numberOfRings, float x, float y, float scale) {
    this.numberOfRings = numberOfRings;
    this.x = x;
    this.y = y;
    setScale(scale);
  }
  
  void moveTo(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  void setScale(float scale) {
    diameter = scale * 40;
  }
  
  void display() {
    displayBody();
    displayHead();
  }

  void displayBody() {
    fill(255);
    for (int i = 0; i < numberOfRings; i++) {
      ellipse(x, y + i * diameter, diameter, diameter);
    }
  }

  void displayHead() {
    float radius = diameter / 2;
    float headY = y - diameter;
    stroke(0);
    line(x, headY - radius, x, headY - 2 * radius);
    line(x, headY - 2 * radius, x - radius, headY - 3 * radius);
    line(x, headY - 2 * radius, x + radius, headY - 3 * radius);
    fill(0);
    rect(x - radius, headY - radius, diameter, diameter);
    fill(255);
    ellipse(x - radius / 2, headY, radius / 2, radius / 2);
    ellipse(x + radius / 2, headY, radius / 2, radius / 2);
  }
}