// This is a more sophisticated version of the ball collision code,
// including a coefficient of restitution for the collision of balls
// with the walls, air resistance, as well as control over the direction
// of the gravity and wind. Also, velocity vectors are shown as well as
// gravity. The mass of the balls is shown if key 'm' is pressed.


Controller controller;

int numberOfBalls = 10;
ArrayList<Ball> balls;
float currentTime;
boolean showMass = false;

PVector gravity = new PVector(0, 0);
PVector wind = new PVector(0, 0);

void setup() {
  //randomSeed(7451232);
  size(1000, 1000, P2D);
  background(255);
  smooth(8);
  frameRate(60);

  controller = new Controller();
  
  balls = new ArrayList<Ball>();
  
  // Create the required number of balls such that no ball is
  // touching any wall or any other ball:
  for (int i = 0; i != numberOfBalls; i++) {
    float radius = random(5, 50);
    float mass = random(500, 5000);
    PVector v = new PVector(random(-10, 10), random(-10, 10));
    
    Ball ball;
    do {
      PVector r = new PVector(random(0, width), random(0, height));
      ball = new Ball(radius, mass, r, v);
    } while(ball.isTouchingAnyWall() || ball.isTouching(balls));
    
    balls.add(ball);
  }
}

void draw() {
  background(255);
  
  // First we let the (keyboard) controller act:
  controller.act();
  
  // Then we start by applying gravity and air drag, as if they had their
  // effect only at the (end of) the previous frame:
  for (Ball ball : balls) {
    ball.applyGravity();
    ball.applyDrag();
  }

  // If the previous frame corresponds to time 0.0, then the current frame
  // corresponds to time 1.0. Between the two frames, multiple collision 
  // may have occurred. How do we deal with them? Basically, one by one,
  // in increasing time. This means we must check which collision occurs
  // first, deal with that collision, and redo the whole process until all
  // the successive collisions between the two frames have been dealt with:
  
  currentTime = 0.0;

  do {
    // At first, since no collisions were found, there are no culprit
    // balls. Also, since no collisions were found, the next collision
    // time is ∞:
    Ball culpritBall1 = null;
    Ball culpritBall2 = null;
    float nextCollisionTime = 1.0;
    
    // Now go through all balls:
    for (int i = 0; i != balls.size(); i++) {
      // For each ball, check whether its next collision with any wall
      // occurs before the current value of the next collision time: 
      Ball ball1 = balls.get(i);
      float nextCollisionWithWall = ball1.nextCollisionWithWall();
      if (nextCollisionWithWall < nextCollisionTime) {
        // Since the next collision of the current ball with any wall
        // occurs before the current value of the next collision time,
        // the next collision time must be is updated, as well as the
        // culprit ball 1. The culprit ball 2 is set to null because
        // this was a collision with a wall, and thus there is no
        // second ball involved:
        culpritBall1 = ball1;
        culpritBall2 = null;
        nextCollisionTime = nextCollisionWithWall;
      }
      // For each ball, go through all the other balls following it
      // in the array list (since we don't want to double check).
      for (int j = i + 1; j != balls.size(); j++) {
        // For each pair of balls, check whether their next collision
        // occurs before the current value of the next collision time: 
        Ball ball2 = balls.get(j);
        float nextCollisionOfBallPair = ball1.nextCollisionWith(ball2);
        if (nextCollisionOfBallPair < nextCollisionTime) {
          // Since the next collision of the current pair of balls
          // occurs before the current value of the next collision time,
          // the next collision time must be is updated, as well as the
          // culprit ball 1 and the culprit ball 2:
          culpritBall1 = ball1;
          culpritBall2 = ball2;
          nextCollisionTime = nextCollisionOfBallPair;
        }
      }
    }
    // If no collisions are found, then the next "collision" time will be
    // have remained with 1.0!
    
    // Go through all balls moving them until the next collision time
    // calculated:
    for (Ball ball : balls)
      ball.moveTill(nextCollisionTime);
  
    // If there were any collisions, there must have been a culprit:
    if (culpritBall1 != null) {
      // If there were any collisions, the previous movement took us
      // exacly to the moment of collision (no overlaps occured, which
      // is the whole point). We must handle the collision here.
      
      if (culpritBall2 != null)
        // If there are two culprits, then the collision was of a ball
        // with another ball:
        culpritBall1.collideWith(culpritBall2); 
      else
        // If there is a single culprit, then the collision was of a
        // ball with a wall:
        culpritBall1.collideWithWall(); 
    }
    
    // Since we moved the balls to the next collision time and handle the
    // occurring collision, the current time must be updated:
    currentTime = nextCollisionTime;
  } while(currentTime < 1.0);
  // We keep updating the current time until it reaches 1.0, which is the
  // current frame.

  // Now display the balls. Notice a lot may happen between the last
  // frame and the current frame, as per the previous look. Lots of
  // collisions may have occurred. We only see the final position of
  // the balls, though:
  for (Ball ball : balls)
    ball.display();
}

void keyPressed() {
  controller.keyPressed(key, keyCode);
}

void keyReleased() {
  controller.keyReleased(key, keyCode);
}