// A very simple example of a timed spaceship shield. Only the
// part about the shield timer is complete. Check the Spaceship
// class.
Spaceship spaceship;

void setup() {
  size(500, 500);
  
  spaceship = new Spaceship();
}

void draw() {
  background(0);
  
  spaceship.update();
  
  spaceship.display();
}