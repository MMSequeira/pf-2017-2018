class ParticleSystem {
  PVector r;
  ArrayList<Particle> particles;

  ParticleSystem(PVector r) {
    this.r = r.copy();
    particles = new ArrayList<Particle>();
  }

  void update() {
    if (random(1) < 0.5)
      particles.add(new Particle(r, random(-PI, PI), 
        PVector.random2D().mult(2), 10));
    
    ArrayList<Particle> deadParticles = new ArrayList<Particle>();
    
    for (Particle particle : particles) {
      particle.update();
      
      if (particle.isDead())
        deadParticles.add(particle);
    }
    
    for (Particle particle : deadParticles)
      particles.remove(particle); 
  }

  void display() {
    for (Particle particle : particles)
      particle.display();
  }
}