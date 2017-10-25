// Original images: http://bit.ly/2zOxLvo
class Child {
  float x, y;
  float scale;
  float distance;
  boolean right;

  float stepSize;
  int numberOfImages;
  int numberOfSteps;
  
  PImage[] images;
  
  Child(float x, float y, float scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
    distance = 0;
    right = true;

    stepSize = 320;
    numberOfImages = 10;
    numberOfSteps = 2;
    
    images = new PImage[numberOfImages];

    for (int i = 0; i != images.length; i++)
      images[i] = loadImage("Child " + (i + 1) + ".png");
  }
  
  void setScaleTo(float newScale) {
    scale = newScale;
  }
  
  void walkBy(float dx) {
    distance += abs(dx);
    right = dx >= 0;
    x += dx;
  }
  
  void walkVerticallyBy(float dy) {
    distance += abs(dy);
    y += dy;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    scale(scale);
    if (right)
      scale(-1, 1);
    
    int imagesPerStep = numberOfImages / numberOfSteps;
    float distancePerImage = scale * stepSize / imagesPerStep;
    int i = int(distance / distancePerImage) % images.length;

    imageMode(CENTER);
    image(images[i], 0, 0);
    
    popMatrix();
  }
}