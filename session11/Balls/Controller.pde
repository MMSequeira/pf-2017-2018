class Controller {
  boolean gravityRight = false;
  boolean gravityLeft = false; 
  boolean gravityUp = false; 
  boolean gravityDown = false; 
  float keyGravity = 0.1;

  boolean windRight = false;
  boolean windLeft = false; 
  boolean windUp = false; 
  boolean windDown = false; 
  float keyWind = 10;

  void act() {
    gravity = new PVector(0, 0);
    if (gravityRight)
      gravity.add(new PVector(keyGravity, 0)); 
    if (gravityLeft)
      gravity.add(new PVector(-keyGravity, 0)); 
    if (gravityUp)
      gravity.add(new PVector(0, -keyGravity)); 
    if (gravityDown)
      gravity.add(new PVector(0, keyGravity)); 
      
    wind = new PVector(0, 0);
    if (windRight)
      wind.add(new PVector(keyWind, 0)); 
    if (windLeft)
      wind.add(new PVector(-keyWind, 0)); 
    if (windUp)
      wind.add(new PVector(0, -keyWind)); 
    if (windDown)
      wind.add(new PVector(0, keyWind)); 
  }

  void keyPressed(char key, int keyCode) {
    if (key == CODED) {
      if (keyCode == RIGHT)
        gravityRight = true;
      else if (keyCode == LEFT)
        gravityLeft = true;
      else if (keyCode == UP)
        gravityUp = true;
      else if (keyCode == DOWN)
        gravityDown = true;
    } else if (key == 'm')
      showMass = !showMass;
    else if (key == 'd') 
        windRight = true;
    else if (key == 'a') 
        windLeft = true;
    else if (key == 'w') 
        windUp = true;
    else if (key == 's') 
        windDown = true;
  }
  
  void keyReleased(char key, int keyCode) {
    if (key == CODED) {
      if (keyCode == RIGHT)
        gravityRight = false;
      else if (keyCode == LEFT)
        gravityLeft = false;
      else if (keyCode == UP)
        gravityUp = false;
      else if (keyCode == DOWN)
        gravityDown = false;
    } else if (key == 'd') 
        windRight = false;
    else if (key == 'a') 
        windLeft = false;
    else if (key == 'w') 
        windUp = false;
    else if (key == 's') 
        windDown = false;
  }
}