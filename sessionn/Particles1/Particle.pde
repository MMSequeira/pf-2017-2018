class Particle {
  float x, y;
  float angle;
  float vx, vy;
  float size;
  float health;
  
  Particle(float x, float y, float angle, float vx, float vy, float size) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.vx = vx;
    this.vy = vy;
    this.size = size;
    health = 255;
  }
  
  boolean isDead() {
    return health <= 0;
  }
  
  void update() {
    float ax = - drag * vx;
    float ay = - drag * vy + g;
    vx += ax;
    vy += ay;
    x += vx;
    y += vy;
    health -= 2;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    
    stroke(0, health);
    fill(0, health);
    rectMode(CENTER);
    rect(0, 0, size, size);
    
    popMatrix();
  }
}