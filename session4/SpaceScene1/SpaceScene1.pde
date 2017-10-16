Starfield starfield;
Spaceship spaceship1;
Spaceship spaceship2;

// Useful for making sure angles are always between -π and π:
float normalizedAngleOf(float angle) {
  return (angle + PI) % TWO_PI - PI;
}

void setup() {
  size(500, 500);
  
  starfield = new Starfield(500);
  spaceship1 = new Spaceship(width / 3, height / 2, 0, 0.5);
  spaceship2 = new Spaceship(2 * width / 3, height / 2, 0, 0.5);
}

void draw() {
  background(0);

  spaceship1.setScaleTo(float(mouseY) / height);
  spaceship1.moveTo(mouseX, mouseY);
  spaceship1.rotateTo(map(mouseX, 0, width, QUARTER_PI, -QUARTER_PI));

  spaceship2.setScaleTo(float(height - mouseY) / height);
  spaceship2.moveTo(width - mouseX, height - mouseY);
  spaceship2.rotateTo(map(mouseX, 0, width, -QUARTER_PI, QUARTER_PI));
  
  starfield.display();
  spaceship1.display();
  spaceship2.display();
}