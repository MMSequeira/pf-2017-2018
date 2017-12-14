class RotatingParticle extends Particle {
  float angleV;
  
  RotatingParticle(PVector r, float angle, PVector v, float size, float angleV) {
    super(r, angle, v, size);
    this.angleV = angleV;
  }
  
  void update() {
    rotateBy(angleV);
    super.update();
  }
}