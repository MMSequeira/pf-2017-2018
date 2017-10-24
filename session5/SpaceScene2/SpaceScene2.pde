Starfield starfield;
Spaceship spaceship;

// Useful for making sure angles are always between -π and π:
float normalizedAngleOf(float angle) {
  return (angle + PI) % TWO_PI - PI;
}

void setup() {
  size(500, 500);
  
  starfield = new Starfield(500);
  spaceship = new Spaceship(width / 2, height / 2, 0, 1);
}

void draw() {
  background(0);

  float xDifference = mouseX - spaceship.x;
  float yDifference = mouseY - spaceship.y;
  float angleDifference = atan2(yDifference, xDifference) - (spaceship.angle - HALF_PI);
  angleDifference = normalizedAngleOf(angleDifference);
  
  spaceship.setScaleTo(0.999 * spaceship.scale);
  spaceship.moveBy(0.01 * xDifference, 0.01 * yDifference);
  spaceship.rotateBy(0.1 * angleDifference);
  
  starfield.display();
  spaceship.display();
}