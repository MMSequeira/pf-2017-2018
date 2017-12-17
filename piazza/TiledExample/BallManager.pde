class BallManager {
  private ArrayList<Ball> balls;

  BallManager() {
    balls = new ArrayList<Ball>();
  }

  void spawn() {
    for (Rectangle object : map.objects()) {
        color ballColor = color(random(0, 255), random(0, 255), 
          random(0, 255), random(0, 255));
        balls.add(new Ball(object.center(), PVector.random2D().mult(0.5), 
          new PVector(0, 0.01), 10, ballColor, #FFFFFF));
        if (balls.size() > 1000)
          balls.remove(balls.get(0));
      }
  }

  void update() {
    println("Balls: " + balls.size());
    for (Ball ball : balls)
      ball.update();
  }

  void display() {
    for (Ball ball : balls)
      ball.display();
  }
}