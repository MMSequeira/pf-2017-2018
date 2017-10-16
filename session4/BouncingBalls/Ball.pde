class Ball {
  float radius;
  float x;
  float y;
  float vx;
  float vy;
  
  Ball(float radius, float x, float y, float vx, float vy) {
    this.radius = radius;
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
  }
  
  void move() {
    x += vx;
    y += vy;
    bounce();
  }
  
  void bounce() {
    if (x + radius > width) {
      x = width - radius;
      vx = -vx;
    } else if(x - radius < 0) {
      x = radius;
      vx = -vx;
    }
    if (y + radius > height) {
      y = height - radius;
      vy = -vy;
    } else if(y - radius < 0) {
      y = radius;
      vy = -vy;
    }
  }
  
  void display() {
    fill(0);
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}