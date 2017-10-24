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

    for (int i = 0; i != images.length; i++) {
      images[i] = loadImage("Child " + (i + 1) + ".png");
      images[i].resize(int(scale * images[i].width), int(scale * images[i].height));
    }
  }
  
  void walkBy(float dx) {
    distance += abs(dx);
    right = dx >= 0;
    x += dx;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
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