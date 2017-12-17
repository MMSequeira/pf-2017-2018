class Ball {
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float diameter;
  private color normalColor;
  private color highlightColor;
  
  Ball(PVector position, PVector velocity, PVector acceleration,
    float diameter, color normalColor, color highlightColor) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.acceleration = acceleration.copy();
    this.diameter = diameter;
    this.normalColor = normalColor;
    this.highlightColor = highlightColor;
  }
  
  PVector position() {
    return position.copy();
  }
  
  void moveBy(PVector displacement) {
    position.add(displacement);
  }
  
  void moveBy(float dx, float dy) {
    position.add(dx, dy);
  }

  void update() {
    velocity.add(acceleration).mult(0.999);
    position.add(velocity);
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    
    pushStyle();
    noStroke();
    if (camera.mouse().dist(position) < diameter / 2)
      fill(highlightColor);
    else
      fill(normalColor);
    ellipse(0, 0, diameter, diameter);
    
    popMatrix();
  }
}