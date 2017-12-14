class Particle {
  private PVector r;
  private float angle;
  private PVector v;
  private float size;
  private float health;

  Particle(PVector r, float angle, PVector v, float size) {
    this.r = r.copy();
    this.angle = angle;
    this.v = v.copy();
    this.size = size;
    health = 255;
  }

  PVector position() {
    return r.copy();
  }
  
  float angle() {
    return angle;
  }
  
  PVector velocity() {
    return v.copy();
  }
  
  float size() {
    return size;
  }
  
  float health() {
    return health;
  }
  
  boolean isDead() {
    return health <= 0;
  }

  boolean isOutOfScreen() {
    return r.x + size / 2 < 0 || r.x - size / 2 > width ||
      r.y + size / 2 < 0 || r.y - size / 2 > height;
  }

  void rotateBy(float rotation) {
    angle += rotation;
  }

  void update() {
    PVector a = PVector.mult(v, -drag);
    a.add(g);
    v.add(a);
    r.add(v);
    health -= 2;
  }

  void display() {
    pushMatrix();
    translate(r.x, r.y);
    rotate(angle);

    draw();

    popMatrix();
  }

  void draw() {
    stroke(0, health);
    fill(0, health);
    rectMode(CENTER);
    rect(0, 0, size, size);
  }
}