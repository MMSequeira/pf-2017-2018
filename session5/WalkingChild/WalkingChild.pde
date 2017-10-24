Child child;

boolean walkRight = false;
boolean walkLeft = false;
boolean run = false;

void setup() {
  size(500, 500);
  
  child = new Child(width / 2, height / 2, 0.25);
}

void draw() {
  background(128);
  
  if (walkRight != walkLeft)
    if (walkRight)
      child.walkBy(run ? 5 : 1);
    else if (walkLeft)
      child.walkBy(run ? -5 : -1);
    
  child.display();
}

void keyPressed() {
  if (key == CODED)
    if (keyCode == RIGHT)
      walkRight = true;
    else if (keyCode == LEFT)
      walkLeft = true;
    else if (keyCode == SHIFT)
      run = true;
}

void keyReleased() {
  if (key == CODED)
    if (keyCode == RIGHT)
      walkRight = false;
    else if (keyCode == LEFT)
      walkLeft = false;
    else if (keyCode == SHIFT)
      run = false;
}