class RotatingParticle {
  PVector r;
  float angle;
  PVector v;
  float size;
  float health;
  float angleV;
  
  RotatingParticle(PVector r, float angle, PVector v, float size, float angleV) {
    this.r = r.copy();
    this.angle = angle;
    this.v = v.copy();
    this.size = size;
    health = 255;
    this.angleV = angleV;
  }
  
  boolean isDead() {
    return health <= 0;
  }
  
  void update() {
    angle += angleV;
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
    
    stroke(0, health);
    fill(0, health);
    rectMode(CENTER);
    rect(0, 0, size, size);
    
    popMatrix();
  }
}