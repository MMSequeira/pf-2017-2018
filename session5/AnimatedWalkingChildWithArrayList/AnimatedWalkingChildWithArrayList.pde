Child child;

float basicDisplacement = 4.0;

boolean walkRight = false;
boolean walkLeft = false;
boolean walkUp = false;
boolean walkDown = false;
boolean run = false;

void setup() {
  size(500, 500);
  
  child = new Child(width / 2, height / 2, 0.25);
}

void draw() {
  background(128);
  
  float scale = map(child.y, 0, height, 0, 0.5);
  float displacement = scale * (run ? 5 : 1) * basicDisplacement;
  
  child.setScaleTo(scale);
  
  if (walkRight != walkLeft)
    if (walkRight)
      child.walkBy(displacement);
    else if (walkLeft)
      child.walkBy(-displacement);
  
  if (walkUp != walkDown)
    if (walkUp)
      child.walkVerticallyBy(-displacement);
    else if (walkDown)
      child.walkVerticallyBy(displacement);

  child.display();
}

void keyPressed() {
  if (key == CODED)
    if (keyCode == RIGHT)
      walkRight = true;
    else if (keyCode == LEFT)
      walkLeft = true;
    else if (keyCode == UP)
      walkUp = true;
    else if (keyCode == DOWN)
      walkDown = true;
    else if (keyCode == SHIFT)
      run = true;
}

void keyReleased() {
  if (key == CODED)
    if (keyCode == RIGHT)
      walkRight = false;
    else if (keyCode == LEFT)
      walkLeft = false;
    else if (keyCode == UP)
      walkUp = false;
    else if (keyCode == DOWN)
      walkDown = false;
    else if (keyCode == SHIFT)
      run = false;
}