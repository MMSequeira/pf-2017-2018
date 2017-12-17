class Rectangle {
  private PVector position;
  private PVector size;
  
  Rectangle(PVector position, PVector size) {
    this.position = position.copy();
    this.size = size.copy();
  }
  
  Rectangle(float x, float y, float w, float h) {
    this.position = new PVector(x, y);
    this.size = new PVector(w, h);
  }
  
  PVector position() {
    return position.copy();
  }
  
  PVector size() {
    return size.copy();
  }
  
  PVector center() {
    return PVector.add(position, PVector.div(size, 2));
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    
    pushStyle();
    noStroke();
    fill(#00FFFF, 128);
    rect(0, 0, size.x, size.y);
    
    popMatrix();
  }
}