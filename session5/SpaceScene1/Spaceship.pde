class Spaceship {
  float x;
  float y;
  float angle;
  float scale;
  PImage alien;
  PImage scaledAlien;
  
  Spaceship(float x, float y, float angle, float scale) {
    this.x = x;
    this.y = y;
    this.angle = normalizedAngleOf(angle);
    alien = loadImage("alien.png");
    setScaleTo(scale);
  }
  
  void setScaleTo(float newScale) {
    scale = newScale;
    int newAlienWidth = int(scale * alien.width / 30);
    int newAlienHeight = int(scale * alien.height / 30);
    if (newAlienWidth == 0 || newAlienHeight == 0)
      scaledAlien = null;
    else if (scaledAlien == null || newAlienWidth != scaledAlien.width || newAlienHeight != scaledAlien.height) {
      scaledAlien = alien.get();
      scaledAlien.resize(newAlienWidth, newAlienHeight);
    }
  }
  
  void rotateTo(float newAngle) {
    angle = normalizedAngleOf(newAngle);
  }
  
  void rotateBy(float angleVariation) {
    rotateTo(angle + angleVariation);
  }
  
  void moveTo(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  void moveBy(float dx, float dy) {
    x += dx;
    y += dy;
  }
  
  void wonder() {
    moveBy(random(-1, 1), random(-1, 1));
  }
    
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);

    pushMatrix();
    scale(scale);
    
    noStroke();
    fill(192);
    arc(0, 0, 200, 100, 0, PI);
    fill(255);
    ellipse(0, 0, 200, 50);
    fill(0);
    ellipse(0, 0, 80, 20);
    fill(200, 64);
    
    popMatrix();

    if (scaledAlien != null) {
      imageMode(CENTER);
      image(scaledAlien, 0, -25 * scale);
    }

    scale(scale);

    rect(-40, -50, 80, 50);
    arc(0, -50, 80, 80, -PI, 0);
    arc(0, 0, 80, 20, 0, PI);

    popMatrix();
  }
}