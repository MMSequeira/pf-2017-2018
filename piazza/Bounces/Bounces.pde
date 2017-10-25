// This still allows balls to overlap, which has some strange effects. :-)

ArrayList<Ball> balls;
int n = 10;
float drag = 1.0;

void setup() {
  //randomSeed(7451232);
  size(500, 500);
  background(255);

  balls = new ArrayList<Ball>();
  
  for (int i = 0; i != n; i++) {
    float radius = random(5, 50);
    float mass = random(0.1, 1) * PI * radius * radius;
    
    Ball ball;
    do {
      ball = new Ball(radius, mass, random(0, width), random(0, height), random(0, 10), random(0, 10));
    } while(ball.isTouchingAnyWall() || ball.isTouching(balls));
    
    balls.add(ball);
  }
}

void draw() {
  background(255);
  
  for (Ball ball : balls)
    ball.move();

  for (int i = 0; i != n; i++)
    for (int j = i + 1; j != n; j++)
      if (balls.get(i).isTouching(balls.get(j))) {
        bounce(balls.get(i), balls.get(j));
      }
  
  for (Ball ball : balls)
    ball.display();
}