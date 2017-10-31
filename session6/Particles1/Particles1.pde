float g = 0.05;
float drag = 0.01;

Particle particle;

void setup() {
  size(500, 500);
  
  particle = new Particle(width / 2, height / 4, random(-PI, PI), random(-2, 2), random(-2, 2), 10);
}

void draw() {
  background(255);
  
  particle.update();
  
  particle.display();
}