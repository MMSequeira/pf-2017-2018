class Controller {
  private boolean moveBallLeft;
  private boolean moveBallRight;
  private boolean moveBallUp;
  private boolean moveBallDown;
  private final float ballSpeed = 5.0;

  private boolean cameraZoomUp;
  private boolean cameraZoomDown;
  private final float cameraZoomFactor = 1.01;

  private boolean cameraRotateLeft;
  private boolean cameraRotateRight;
  private final float cameraRotationSpeed = 0.01;
  
  private boolean cameraReset;

  Controller() {
    moveBallLeft = false;
    moveBallRight = false;
    moveBallUp = false;
    moveBallDown = false;

    cameraZoomUp = false;
    cameraZoomDown = false;

    cameraRotateLeft = false;
    cameraRotateRight = false;
    
    cameraReset = false;
  }

  void apply() {
    if (moveBallLeft)
      ball.moveBy(-ballSpeed, 0);
    if (moveBallRight)
      ball.moveBy(ballSpeed, 0);
    if (moveBallUp)
      ball.moveBy(0, -ballSpeed);
    if (moveBallDown)
      ball.moveBy(0, ballSpeed);

    if (cameraZoomDown)
      camera.zoomBy(1.0 / cameraZoomFactor);
    if (cameraZoomUp)
      camera.zoomBy(cameraZoomFactor);

    if (cameraRotateLeft)
      camera.rotateBy(-cameraRotationSpeed);
    if (cameraRotateRight)
      camera.rotateBy(cameraRotationSpeed);
      
    if (cameraReset)
      camera.reset();
  }

  void keyPressed(char key, int keyCode) {
    if (key == CODED) {
      if (keyCode == LEFT)
        moveBallLeft = true;
      else if (keyCode == RIGHT)
        moveBallRight = true;
      else if (keyCode == UP)
        moveBallUp = true;
      else if (keyCode == DOWN)
        moveBallDown = true;
    } else if (key == 'x')
      cameraZoomDown = true;
    else if (key == 'z')
      cameraZoomUp = true;
    else if (key == '<')
      cameraRotateLeft = true;
    else if (key == '>')
      cameraRotateRight = true;
    else if (key == 'r')
      cameraReset = true;
  }

  void keyReleased(char key, int keyCode) {
    if (key == CODED) {
      if (keyCode == LEFT)
        moveBallLeft = false;
      else if (keyCode == RIGHT)
        moveBallRight = false;
      else if (keyCode == UP)
        moveBallUp = false;
      else if (keyCode == DOWN)
        moveBallDown = false;
    } else if (key == 'x')
      cameraZoomDown = false;
    else if (key == 'z')
      cameraZoomUp = false;
    else if (key == '<')
      cameraRotateLeft = false;
    else if (key == '>')
      cameraRotateRight = false;
    else if (key == 'r')
      cameraReset = false;
  }
}