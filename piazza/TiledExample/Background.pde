class Background {
  private color myColor;
  private ArrayList<Ball> balls;

  Background(color myColor, int numberOfBalls, PVector start, PVector end) {
    this.myColor = myColor;
    balls = new ArrayList<Ball>();
    for (int i = 0; i != numberOfBalls; i++) {
      float diameter = random(0, 50);
      color ballColor = color(random(0, 255), random(0, 255), 
        random(0, 255), random(0, 255));
      balls.add(new Ball(new PVector(random(start.x, end.x), random(start.y, end.y)), 
        new PVector(0, 0), new PVector(0, 0), diameter, ballColor, #FFFFFF));
    }
  }

  void update() {
  }

  void display() {
    background(myColor);

    for (Ball ball : balls)
      ball.display();
  }
}