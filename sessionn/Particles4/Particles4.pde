PVector g = new PVector(0, 0.05);
float drag = 0.01;

ParticleSystem ps;

void setup() {
  size(500, 500);
  
  ps = new ParticleSystem(new PVector(width / 2, height / 4));
}

void draw() {
  background(255);
  
  ps.update();
  
  ps.display();
}