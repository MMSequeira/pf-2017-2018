class ParticleSystem {
  PVector r;
  ArrayList<Particle> particles;
  ArrayList<CircularParticle> circularParticles;
  ArrayList<RotatingParticle> rotatingParticles;

  ParticleSystem(PVector r) {
    this.r = r.copy();
    particles = new ArrayList<Particle>();
    circularParticles = new ArrayList<CircularParticle>();
    rotatingParticles = new ArrayList<RotatingParticle>();
  }

  void update() {
    if (random(1) < 0.5) {
      float angle = random(-PI, PI);
      PVector velocity = PVector.random2D().mult(2);
      int type = int(random(3));
      if (type == 0)
        particles.add(new Particle(r, angle, velocity, 10));
      else if (type == 1)
        circularParticles.add(new CircularParticle(r, angle, velocity, 10));
      else if (type == 2)
        rotatingParticles.add(new RotatingParticle(r, angle, velocity, 5, 0.1));
    }
    
    ArrayList<Particle> deadParticles = new ArrayList<Particle>();
    
    for (Particle particle : particles) {
      particle.update();
      
      if (particle.isDead())
        deadParticles.add(particle);
    }
    
    for (Particle particle : deadParticles)
      particles.remove(particle);
    
    ArrayList<CircularParticle> deadCircularParticles = new ArrayList<CircularParticle>();
    
    for (CircularParticle circularParticle : circularParticles) {
      circularParticle.update();
      
      if (circularParticle.isDead())
        deadCircularParticles.add(circularParticle);
    }
    
    for (CircularParticle CircularParticle : deadCircularParticles)
      circularParticles.remove(CircularParticle);

    ArrayList<RotatingParticle> deadRotatingParticles = new ArrayList<RotatingParticle>();
    
    for (RotatingParticle rotatingParticle : rotatingParticles) {
      rotatingParticle.update();
      
      if (rotatingParticle.isDead())
        deadRotatingParticles.add(rotatingParticle);
    }
    
    for (RotatingParticle rotatingParticle : deadRotatingParticles)
      rotatingParticles.remove(rotatingParticle);
  }

  void display() {
    for (Particle particle : particles)
      particle.display();
    for (CircularParticle circularParticle : circularParticles)
      circularParticle.display();
    for (RotatingParticle rotatingParticle : rotatingParticles)
      rotatingParticle.display();
  }
}