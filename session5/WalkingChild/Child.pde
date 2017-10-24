// Original images: http://bit.ly/2zOxLvo
class Child {
  float x, y;
  float scale;
  boolean right;
  
  PImage image;
  
  Child(float x, float y, float scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
    right = true;

    image = loadImage("Child 1.png");
    image.resize(int(scale * image.width), int(scale * image.height));
    
  }
  
  void walkBy(float dx) {
    right = dx >= 0;
    x += dx;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    if (right)
      scale(-1, 1);
    
    imageMode(CENTER);
    image(image, 0, 0);
    
    popMatrix();
  }
}