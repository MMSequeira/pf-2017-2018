// Algorithms based on Joe van den Heuvel and Miles Jackson, "Pool Hall Lessons: Fast,
// Accurate Collision Detection Between Circles or Spheres", Gamasutra, January 18, 2002.
// http://ubm.io/2l7HppD

class Ball {
  float radius;
  float m; // mass
  PVector r; // position
  PVector v; // velocity
  boolean verticalWallBounce; // true is the last collision detected was with a vertical wall

  Ball(float radius, float m, PVector r, PVector v) {
    this.radius = radius;
    this.m = m;
    this.r = r.copy();
    this.v = v.copy();
  }

  // Calculates when between the current time and time 1.0 the collision
  // between this ball and the other ball will occur. If no collision will
  // occur between the current time and 1.0, then it returns ∞ (We use ∞
  // because… well it is certainly larger the 1.0. :-)).
  //
  // Notice that time 0.0 is the time of the previous frame and time 1.0 is
  // the time of the current frame. Since the current time is always between
  // 0.0 and 1.0, this detects a collision occurring in between the previous
  // and the current frame.
  float nextCollisionWith(Ball other) {
    // All calculations performed as if the other ball were stopped. We thus 
    // change to a frame of reference attached to the other ball. In this
    // frame of reference, the other ball is stopped and this ball as a
    // relative velocity which equals its absolute velocity subtracted
    // of the velocity of the other ball:
    PVector rv = PVector.sub(this.v, other.v);

    // We are checking for collisions from the current time till the end
    // of the frame, at time 1.0. During that time, the total relative
    // displacement of this ball is given by the product of the time passed
    // and the relative velocity:
    PVector rd = PVector.mult(rv, 1.0 - currentTime);

    // We will need to know the magnitude of the relative displacement,
    // so we calculate it now:
    float displacement = rd.mag();

    // We will also need to know the minimum possible distance between
    // the centers of this ball and the other ball, which is the sum of
    // their radii:
    float minimumPossibleCenterDistance = this.radius + other.radius;

    // Also important to know is the initial distance between the two balls,
    // which is the distance between their centers minus the sum of their
    // radii (which is also the minimum possible distance between their
    // centers):
    float distance = this.r.dist(other.r) - minimumPossibleCenterDistance;

    // If the distance between the balls is larger than the magnitude of
    // the relative displacement, no collision will ocurr up to the current
    // frame (time 1.0):
    if (distance > displacement)
      return Float.POSITIVE_INFINITY;

    // Let's calculate a vector c that goes from the center of this ball
    // to the center of the other ball:
    PVector c = PVector.sub(other.r, this.r);

    // Now lets obtain the normalized (unit) displacement vector:
    PVector n = rd.copy().normalize();

    // The displacement, along the relative displacement, for which the distance
    // between the centers of this ball and the other ball is minimal, is
    // given by the projection of c over n, i.e., by the dot product between
    // n and c (or vice-versa):
    float displacementForMinimalCenterDistance = n.dot(c);

    // If the displacement for the minimal center distance is smaller than or
    // equal to 0, then there is no actual displacement of this ball towards
    // the other ball:
    if (displacementForMinimalCenterDistance <= 0)
      return Float.POSITIVE_INFINITY;

    // Now we calculate the square of the minimal distance between the centers
    // of the balls along the relative displacement of this ball. This is an
    // application of the Pythagorean theorem:
    float minimumCenterDistanceSquared = 
      sqr(c.mag()) - sqr(displacementForMinimalCenterDistance);

    // We will also need to know the square of the the minimum possible distance
    // between the centers of this ball and the other ball, i.e., the square of
    // the sum of the radii of the two balls:
    float minimumPossibleCenterDistanceSquared = sqr(minimumPossibleCenterDistance);

    // We now check to see whether the two balls actually would overlap at their
    // closest point along the relative displacement of this ball. If they don't,
    // there can be no collision between the two balls:
    if (minimumCenterDistanceSquared > minimumPossibleCenterDistanceSquared)
      return Float.POSITIVE_INFINITY;

    // Given that we now know the two balls would overlap at the closest point
    // between their centers, then we also know they must collide before that
    // would occur. Thus, we may calculate the reduction in the displacement
    // for minimal center distance necessary for the two balls to be just
    // touching. This is again an application of the Pythagorean theorem:
    float displacementReduction = 
      sqrt(minimumPossibleCenterDistanceSquared - minimumCenterDistanceSquared);

    // Now we can calculate the actual displacement, along the relative
    // displacement of this ball, necessary for the two balls to be just
    // touching:
    float displacementUntilCollision = 
      displacementForMinimalCenterDistance - displacementReduction;

    // If the magnitude of the relative displacement is not enough to reach the
    // displacement necessary for the two balls to touch, then the two balls
    // do not touch from the current time to time 1.0 (current frame):
    if (displacement < displacementUntilCollision)
      return Float.POSITIVE_INFINITY;

    // At last we are ready to calculate the time at which the collision will
    // occur. We know the possible displacement until collision is between 0 and
    // the magnitude of the relative displacement. Since we are assuming the velocity
    // does not change between frames (we simulate acceleration only in discrete
    // times), the percentage of the relative movement corresponding to the 
    // possible displacement until collision is also the percentage of the time
    // between the current time and 1.0 that must pass, since the current time,
    // for the collision to occur:
    return currentTime + 
      displacementUntilCollision / displacement * (1.0 - currentTime);
  }

  // The collision is considered to be totally elastic and the balls considered
  // to be totally frictionless:
  void collideWith(Ball other) {
    // First, find the normalized vector n from the center of this ball
    // to the center of the other :
    PVector n = PVector.sub(other.r, this.r).normalize();

    // Find the length of the component of each of the velocity vectors
    // along n: 
    // aThis = this.v . n
    // aOther = other.v . n
    float aThis = this.v.dot(n);
    float aOther = other.v.dot(n);

    // Using the optimized version, 
    // optimizedP =  2(aThis - aOther)
    //              -----------
    //                this.m + other.m
    float optimizedP = 2.0 * (aThis - aOther) / (this.m + other.m);

    // Calculate this.v', the new velocity vector of this:
    // this.v' = this.v - optimizedP * other.m * n
    this.v = PVector.sub(this.v, PVector.mult(n, optimizedP * other.m));

    // Calculate other.v', the new velocity vector of other:
    // other.v' = other.v + optimizedP * this.m * n
    other.v = PVector.add(other.v, PVector.mult(n, optimizedP * this.m));
  }

  // Walls should actually be considered as four independent infinite
  // mass objects. We're simplifying this, since our purpose with this
  // code is mainly to talk about the collision of balls with other balls:
  float nextCollisionWithWall() {
    float nextCollisionWithVerticalWall =
      min(nextCollisionWithLeftWall(), nextCollisionWithRightWall());
    float nextCollisionWithHorizontalWall =
      min(nextCollisionWithTopWall(), nextCollisionWithBottomWall());
    verticalWallBounce =
      nextCollisionWithVerticalWall <= nextCollisionWithHorizontalWall;
    return verticalWallBounce ?
      nextCollisionWithVerticalWall : 
      nextCollisionWithHorizontalWall;
  }

  float nextCollisionWithLeftWall() {
    if (v.x >= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime - (r.x - radius) / v.x;
  }

  float nextCollisionWithRightWall() {
    if (v.x <= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime + (width - (r.x + radius)) / v.x;
  }

  float nextCollisionWithTopWall() {
    if (v.y >= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime - (r.y - radius) / v.y;
  }

  float nextCollisionWithBottomWall() {
    if (v.y <= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime + (height - (r.y + radius)) / v.y;
  }

  void collideWithWall() {
    if (verticalWallBounce)
      v.x = -v.x;
    else
      v.y = -v.y;
  }

  // Moves this ball from the current time until the given time:
  void moveTill(float time) {
    // The time passed is the given time subtracted of the current time. This velocity
    // multiplied be the time passed is the actual movement, which must be added to 
    // the position of this ball:
    r.add(PVector.mult(v, time - currentTime));
  }

  boolean isTouching(Ball other) {
    return r.dist(other.r) < radius + other.radius;
  }

  boolean isTouching(ArrayList<Ball> others) {
    for (Ball other : others)
      if (isTouching(other))
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

  void display() {
    pushMatrix();
    translate(r.x, r.y);

    pushStyle();

    fill(map(m, 500, 5000, 192, 0));
    noStroke();

    ellipse(0, 0, 2 * radius, 2 * radius);

    popStyle();

    popMatrix();
  }

}