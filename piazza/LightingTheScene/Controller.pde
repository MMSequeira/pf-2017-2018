class Controller {
  private float speed = 10;
  private boolean left;
  private boolean right;
  private boolean up;
  private boolean down;

  Controller(float speed) {
    this.speed = speed;
    left = right = up = down = false;
  }
  
  void apply() {
    if (left)
      player.moveBy(-speed, 0);
    if (right)
      player.moveBy(speed, 0);
    if (up)
      player.moveBy(0, -speed);
    if (down)
      player.moveBy(0, speed);
  }
  
  void keyPressed(char key, int keyCode) {
    if (key == 'a')
      left = true;
    if (key == 'd')
      right = true;
    if (key == 'w')
      up = true;
    if (key == 's')
      down = true;
  }

  void keyReleased(char key, int keyCode) {
    if (key == 'a')
      left = false;
    if (key == 'd')
      right = false;
    if (key == 'w')
      up = false;
    if (key == 's')
      down = false;
  }
}