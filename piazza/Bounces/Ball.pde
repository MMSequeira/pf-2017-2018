// Algorithms based on Joe van den Heuvel and Miles Jackson, "Pool Hall Lessons: Fast,
// Accurate Collision Detection Between Circles or Spheres", Gamasutra, January 18, 2002.
// http://ubm.io/2l7HppD

class Ball {
  float radius;
  float m;
  PVector r;
  PVector v;
  
  Ball(float radius, float m, float x, float y, float vx, float vy) {
    this.radius = radius;
    this.m = m;
    r = new PVector(x, y);
    v = new PVector(vx, vy);
  }
  
  boolean isTouching(Ball ball) {
    return r.dist(ball.r) < radius + ball.radius;
  }

  boolean isTouching(ArrayList<Ball> balls) {
    for (Ball ball : balls)
      if (isTouching(ball))
        return true;
    return false;
  }

  boolean isTouchingLeftWall() {
    return r.x - radius <= 0;
  }

  boolean isTouchingRightWall() {
    return r.x + radius >= width;
  }

  boolean isTouchingTopWall() {
    return r.y - radius <= 0;
  }

  boolean isTouchingBottomWall() {
    return r.y + radius >= height;
  }

  boolean isTouchingAnyWall() {
    return isTouchingLeftWall() || isTouchingRightWall() || 
      isTouchingTopWall() || isTouchingBottomWall();
  }
  
  void move() {
    v.mult(drag);
    r.add(v);
    bounceOffWalls();
  }
  
  void bounceOffWalls() {
    if (isTouchingRightWall()) {
      r.x = width - radius;
      v.x = -v.x;
    } else if(isTouchingLeftWall()) {
      r.x = radius;
      v.x = -v.x;
    }
    if (isTouchingBottomWall()) {
      r.y = height - radius;
      v.y = -v.y;
    } else if(isTouchingTopWall()) {
      r.y = radius;
      v.y = -v.y;
    }
  }
  
  void display() {
    fill(map(m / (PI * radius * radius), 0, 1, 255, 0));
    ellipse(r.x, r.y, 2 * radius, 2 * radius);
  }
}

void bounce(Ball b1, Ball b2) {
  // First, find the normalized vector n from the center of b1 to the center of b2:
  PVector n = PVector.sub(b1.r,  b2.r).normalize();

  // Find the length of the component of each of the velocity vectors along n: 
  // a1 = v1 . n
  // a2 = v2 . n
  float a1 = b1.v.dot(n);
  float a2 = b2.v.dot(n);
  
  // Using the optimized version, 
  // optimizedP =  2(a1 - a2)
  //              -----------
  //                m1 + m2
  float optimizedP = 2.0 * (a1 - a2) / (b1.m + b2.m);
  
  // Calculate v1', the new velocity vector of b1:
  // v1' = v1 - optimizedP * m2 * n
  b1.v = PVector.sub(b1.v, PVector.mult(n, optimizedP * b2.m));
  
  // Calculate v2', the new velocity vector of b2:
  // v2' = v2 + optimizedP * m1 * n
  b2.v = PVector.add(b2.v, PVector.mult(n, optimizedP * b1.m));
}