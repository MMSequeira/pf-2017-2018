class ParticleSystem {
  PVector r;
  ArrayList<Particle> particles;

  ParticleSystem(PVector r) {
    this.r = r.copy();
    particles = new ArrayList<Particle>();
  }

  void update() {
    if (random(1) < 0.9) {
      float angle = random(-PI, PI);
      PVector velocity = PVector.random2D().mult(4);
      Particle p;
      int type = int(random(3));
      if (type == 0)
        p = new Particle(r, angle, velocity, 10);
      else if (type == 1)
        p = new CircularParticle(r, angle, velocity, 10);
      else
        p = new RotatingParticle(r, angle, velocity, 5, 0.1);
      particles.add(p);
    }

    ArrayList<Particle> deadParticles = new ArrayList<Particle>();

    for (Particle particle : particles) {
      particle.update();

      if (particle.isDead() || particle.isOutOfScreen())
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