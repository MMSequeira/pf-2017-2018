class Background {
  private color myColor;
  private int numberOfBalls;
  private final int seed = 3456;
  
  Background(color myColor, int numberOfBalls) {
    this.myColor = myColor;
    this.numberOfBalls = numberOfBalls;
  }
  
  void update() {
  }
  
  void display() {
    background(myColor);
    randomSeed(seed);
    
    pushStyle();
    noStroke();
    for (int i = 0; i != numberOfBalls; i++) {
      fill(color(random(0, 255), random(0, 255),
        random(0, 255)), random(0, 255));
      float diameter = random(0, 50);
      ellipse(random(0, width), random(0, height), diameter, diameter);
    }
    popStyle();
  }
}