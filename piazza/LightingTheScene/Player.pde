class Player {
  private PVector position;
  private float size;
  private color myColor;
  
  Player(PVector position, float size, color myColor) {
    this.position = position.copy();
    this.size = size;
    this.myColor = myColor;
  }
  
  PVector position() {
    return position.copy();
  }
  
  void moveBy(float x, float y) {
    position.add(x, y);
  }
  
  void update() {
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    
    pushStyle();
    fill(myColor);
    rectMode(CENTER);
    rect(0, 0, size, size);
    popStyle();
    
    popMatrix();
  }
}