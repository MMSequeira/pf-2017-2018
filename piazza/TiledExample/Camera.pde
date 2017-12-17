class Camera {
  private final PVector positionInDisplay;
  private PVector position;
  private float zoom;
  private float rotation;
  private final float followMargin = 100.0;

  Camera(PVector position) {
    positionInDisplay = new PVector(width / 2, height / 2);
    this.position = position.copy();
    zoom = 1.0;
    rotation = 0.0;
  }

  void zoomBy(float factor) {
    zoom *= factor;
  }

  void rotateBy(float rotationChange) {
    rotation += rotationChange;
  }

  void reset() {
    zoom = pow(zoom, 0.95);
    rotation *= 0.95;
    position.add(PVector.sub(ball.position(), position).mult(0.05));
  }

  void update() {
    float margin = followMargin / zoom; 
    PVector ballPosition = ball.position();
    if (position.x > ballPosition.x + margin)
      position.x = ballPosition.x + margin;
    else if (position.x < ballPosition.x - margin)
      position.x = ballPosition.x - margin;
    if (position.y > ballPosition.y + margin)
      position.y = ballPosition.y + margin;
    else if (position.y < ballPosition.y - margin)
      position.y = ballPosition.y - margin;
  }

  void apply() {
    PVector originInWorld = originInWorld();
    translate(positionInDisplay.x, positionInDisplay.y);
    rotate(-rotation);
    scale(zoom);
    translate(-positionInDisplay.x / zoom, -positionInDisplay.y / zoom);
    translate(-originInWorld.x, -originInWorld.y);
  }

  PVector originInWorld() {
    return PVector.sub(position, PVector.div(positionInDisplay, zoom));
  }

  PVector asWorld(PVector display) {
    return PVector.add(PVector.div(PVector.sub(display, positionInDisplay).rotate(rotation).add(positionInDisplay), zoom), originInWorld());
  }

  // Not correct. Should account for rotation.
  //PVector asDisplay(PVector world) {
  //  return PVector.sub(world, originInWorld()).mult(zoom);
  //}

  PVector mouseInDisplay() {
    return new PVector(mouseX, mouseY);
  }

  PVector mouse() {
    return asWorld(mouseInDisplay());
  }
}