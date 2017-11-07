PVector g = new PVector(0, 0.05);
float drag = 0.01;

Particle particle;

void setup() {
  size(500, 500);

  particle = new Particle(new PVector(width / 2, height / 4), random(-PI, PI), 
    PVector.random2D().mult(2), 10);
  background(255);
}

void draw() {
//  background(255);

  particle.update();

  particle.display();
}