class Snake {
  float size;
  ArrayList<Ring> rings;  
  
  Snake(float x, float y, float size) {
    this.size = size;
    rings = new ArrayList<Ring>();
    // Add head ring:
    rings.add(new Ring(x, y));
  }
  
  void moveRight() {
    moveBy(size, 0);
  }
  
  void moveLeft() {
    moveBy(-size, 0);
  }
  
  void moveUp() {
    moveBy(0, -size);
  }
  
  void moveDown() {
    moveBy(0, size);
  }
  
  void moveBy(float dx, float dy) {
    if (!isDead()) {
      if (random(1) < 0.5) {
        Ring tailTip = rings.get(rings.size() - 1);
        rings.add(new Ring(tailTip.x, tailTip.y));
      }
      moveTail();
      Ring head = rings.get(0);
      head.moveBy(dx, dy);
    }
  }
  
  void moveTail() {
    for (int i = rings.size() - 1; i != 0; i--) {
      Ring inFront = rings.get(i - 1);
      rings.get(i).moveTo(inFront.x, inFront.y);
    }
  }
  
  boolean isDead() {
    Ring head = rings.get(0);
    for (int i = 1; i != rings.size(); i++)
      if (head.x == rings.get(i).x && head.y == rings.get(i).y)
        return true;
    return false;
  }
  
  void display() {
    rings.get(0).display(#FF0000);
    for (int i = 1; i != rings.size(); i++) {
      float opacity = map(i, 0, rings.size() - 1, 255, 64);
      rings.get(i).display(color(255, opacity));
    }
  }
  
  class Ring {
    float x;
    float y;
    
    Ring(float x, float y) {
      this.x = x;
      this.y = y;
    }
    
    void moveTo(float x, float y) {
      this.x = x;
      this.y = y;
    }
    
    void moveBy(float dx, float dy) {
      x += dx;
      y += dy;
    }
    
    void display(color ringColor) {
      if (isDead()) {
        noFill();
        stroke(ringColor);
      } else {
        noStroke();
        fill(ringColor);
      }
      ellipse(x, y, size, size);
    }
  }
}