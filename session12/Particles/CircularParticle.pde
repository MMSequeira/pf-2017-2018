class CircularParticle extends Particle {  
  CircularParticle(PVector r, float angle, PVector v, float size) {
    super(r, angle, v, size);
  }
  
  void draw() {
    stroke(0, health);
    fill(0, health);
    ellipse(0, 0, size, size);
  }
}