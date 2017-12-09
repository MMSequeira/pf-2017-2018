// Algorithms based on: //<>// //<>//
//   https://gamedev.stackexchange.com/a/18459 (zacharmarz)
//   https://gamedev.stackexchange.com/a/47892 (Sam Hocevar)

// Represents a AABB (Axis Aligned Bounding Box):
class Box {
  float m; // mass
  PVector s; // size (x is width and y is height)
  PVector hs; // half size (x is width / 2 and y is height / 2)
  PVector r; // position
  PVector v; // velocity
  boolean verticalWallBounce; // true is the last collision detected was with a vertical wall
  int id;

  Box(PVector s, float m, PVector r, PVector v, int id) {
    this.s = s.copy();
    this.hs = PVector.div(s, 2);
    this.m = m;
    this.r = r.copy();
    this.v = v.copy();
    this.id = id;
  }

  // We need specialy versions of the the min() and max() function
  // dealing with NaN (which we'll see as indeterminacies). Notice
  // that NaN is the only value that is different from itself:

  float min(float v1, float v2) {
    if (v1 != v1 && v2 != v2)
      // Since both are NaN, we return NaN:
      return 0.0 / 0.0;
    if (v1 != v1)
      // If only v1 is NaN, assume the worst case:
      return Float.NEGATIVE_INFINITY;
    if (v2 != v2)
      // If only v1 is NaN, assume the worst case:
      return Float.NEGATIVE_INFINITY;
    if (v1 < v2)
      return v1;
    else
      return v2;
  }

  float max(float v1, float v2) {
    if (v1 != v1 && v2 != v2)
      return 0.0 / 0.0;
    if (v1 != v1)
      return Float.POSITIVE_INFINITY;
    if (v2 != v2)
      return Float.POSITIVE_INFINITY;
    if (v1 < v2)
      return v2;
    else
      return v1;
  }

  // Calculates when between the current time and time 1.0 the collision
  // between this box and the other box will occur. If no collision will
  // occur between the current time and 1.0, then it returns a value
  // larger than 1.0 or even ∞ (We use ∞ because… well it is certainly
  // larger the 1.0. :-)).
  //
  // Notice that time 0.0 is the time of the previous frame and time 1.0 is
  // the time of the current frame. Since the current time is always between
  // 0.0 and 1.0, this detects a collision occurring in between the previous
  // and the current frame.
  float nextCollisionWith(Box other) {
    // All calculations performed as if the other box were stopped. We thus 
    // change to a frame of reference attached to the other box. In this
    // frame of reference, the other box is stopped and this box has a
    // relative velocity which equals its absolute velocity subtracted
    // of the velocity of the other box:
    PVector rv = PVector.sub(this.v, other.v);

    // Checking for a colision between this box and the other box the same
    // as checking for a collision between this box reduced to a size of
    // zero and the other box with its size augmented by the size of this
    // ball. Make a few drawings to convince yourself that this works. we
    // call "relative size" the sum of the sizes of box boxes. 
    PVector rs = PVector.add(this.s, other.s);

    // This is just half the size, usefull to calculate the top-left and
    // bottom-right coordinates:
    PVector hrs = PVector.div(rs, 2);

    // The top-left coordinates of the other box with its "relative
    // size":
    PVector r1 = PVector.sub(other.r, hrs);
    // The bottom-right coordinates of the other box with its "relative
    // size":
    PVector r2 = PVector.add(other.r, hrs);

    // The inverse of the velocity components (may result in be ∞):
    float fracX = 1.0 / rv.x;
    float fracY = 1.0 / rv.y;

    // The time necessary for this box (reduced to a point) to cross the
    // left edge of the other box with its "relative size":   
    float timeX1 = (r1.x - this.r.x) * fracX;
    // The time necessary for this box (reduced to a point) to cross the
    // right edge of the other box with its "relative size":   
    float timeX2 = (r2.x - this.r.x) * fracX;
    // The time necessary for this box (reduced to a point) to cross the
    // top edge of the other box with its "relative size":   
    float timeY1 = (r1.y - this.r.y) * fracY;
    // The time necessary for this box (reduced to a point) to cross the
    // bottom edge of the other box with its "relative size":   
    float timeY2 = (r2.y - this.r.y) * fracY;

    // The code below handles well cases in which timeX1, timeX2, timeY1
    // or timeY2 take infinite values. In some cases, though, one of
    // timeX1 and timeX2 (not both, unless the two boxes are degenerate)
    // may take the NaN value. And the same for timeY1 and timeY2. The
    // NaN values will be treated as if they were infinite values the
    // min() (-∞) and max() (+∞) funcions above. A dirty trick, but is
    // seems to work well in practice.

    // The time of the first vertical edge crossing:
    float timeXEntry = min(timeX1, timeX2);
    // The time of the first horizontal edge crossing:
    float timeYEntry = min(timeY1, timeY2);
    // The time when the first horizontal and the first vertical edge
    // crossings are done:
    float timeEntry = max(timeXEntry, timeYEntry);

    // It the time for entry is negative, the collision occurred in the
    // past:
    if (timeEntry <= 0.0)
      return Float.POSITIVE_INFINITY;

    // The time of the second vertical edge crossing:
    float timeXExit = max(timeX1, timeX2);
    // The time of the second horizontal edge crossing:
    float timeYExit = max(timeY1, timeY2);
    // The time when the second horizontal *or* the second vertical edge
    // crossings are done:
    float timeExit = min(timeXExit, timeYExit);

    // In this case, there will be no collision:
    if (timeEntry > timeExit)
      return Float.POSITIVE_INFINITY;

    // Return the current time plus the time to the collision:
    return currentTime + timeEntry;
  }

  // The collision is considered to be totally elastic and the boxes considered
  // to be totally frictionless (and non-rotating, as all AABB are):
  void collideWith(Box other) {
    // This first part is just like the nextCollisionWith() method. The aim,
    // however, is not to get when the collision will occur, but rather, given
    // that the collision has occurred, to deal with it.
    PVector rv = PVector.sub(this.v, other.v);
    PVector rs = PVector.add(this.s, other.s);
    PVector hrs = PVector.div(rs, 2);
    PVector r1 = PVector.sub(other.r, hrs);
    PVector r2 = PVector.add(other.r, hrs);

    float fracX = 1.0 / rv.x;
    float fracY = 1.0 / rv.y;

    float timeX1 = (r1.x - this.r.x) * fracX;
    float timeX2 = (r2.x - this.r.x) * fracX;
    float timeY1 = (r1.y - this.r.y) * fracY;
    float timeY2 = (r2.y - this.r.y) * fracY;

    float timeXEntry = min(timeX1, timeX2);
    float timeYEntry = min(timeY1, timeY2);

    if (timeYEntry > timeXEntry)
      // Since the first horizontal edge crossing occurs after the first
      // vertical edge crossing, the collision of this box with the
      // other box is either from above or from below.
      //
      // At this point, we might compare timeY1, the time for crossing
      // the top edge, with timeY2, the time for for crossing the
      // bottom edge. If timeY1 < timeY2, then the collision of this
      // box with the other box is from above. Otherwise it is from
      // below.
      collideFromAboveOrBelowWith(other);
    else
      // Since the first vertical edge crossing occurs after the first
      // horizonal edge crossing, the collision of this box with the
      // other box is from the sides, either from the left or from
      // the right.
      //
      // At this point, we might compare timeX1, the time for crossing
      // the left edge, with timeX2, the time for for crossing the
      // right edge. If timeX1 < timeX2, then the collision of this
      // box with the other box is from the left. Otherwise it is from
      // the right.
      collideLaterallyWith(other);
  }

  // The physics of the collision is simpler in this case, since only the
  // y component of the velocities is affected. The result general case 
  // equations are just a one dimension version of the equations we got
  // for the collision of two balls. The special cases of one of the boxes
  // having infinite mass are also easy to get to: simply take the limit
  // of the general case when this mass or the other mass tend to infinity.
  // The case of both this and the other box with infinity mass is dealt
  // with assuming they have finite but equal mass, in which case the
  // velocities are simply exchanged:
  void collideFromAboveOrBelowWith(Box other) {
    if (this.m == Float.POSITIVE_INFINITY &&
      other.m == Float.POSITIVE_INFINITY) {
      float originalThisVY = this.v.y;
      this.v.y = other.v.y;
      other.v.y = originalThisVY;
    } else if (this.m == Float.POSITIVE_INFINITY) 
      other.v.y = 2 * this.v.y - other.v.y;
    else if (other.m == Float.POSITIVE_INFINITY) 
      this.v.y = 2 * other.v.y - this.v.y;
    else {
      float optimizedP = 2.0 * (this.v.y - other.v.y) / (this.m + other.m);
      this.v.y -= optimizedP * other.m;
      other.v.y += optimizedP * this.m;
    }
  }

  // The same ideas apply here, though to the x component of
  // the velocity, instead of to the y component:
  void collideLaterallyWith(Box other) {
    if (this.m == Float.POSITIVE_INFINITY && 
      other.m == Float.POSITIVE_INFINITY) {
      float originalThisVX = this.v.x;
      this.v.x = other.v.x;
      other.v.x = originalThisVX;
    } else if (this.m == Float.POSITIVE_INFINITY) 
      other.v.x = 2 * this.v.x - other.v.x;
    else if (other.m == Float.POSITIVE_INFINITY) 
      this.v.x = 2 * other.v.x - this.v.x;
    else {
      float optimizedP = 2.0 * (this.v.x - other.v.x) / (this.m + other.m);
      this.v.x -= optimizedP * other.m;
      other.v.x += optimizedP * this.m;
    }
  }

  // Walls should actually be considered as four independent infinite
  // mass objects. We're simplifying this, since our purpose with this
  // code is mainly to talk about the collision of boxes with other boxes:
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
    return currentTime - (r.x - hs.x) / v.x;
  }

  float nextCollisionWithRightWall() {
    if (v.x <= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime + (width - (r.x + hs.x)) / v.x;
  }

  float nextCollisionWithTopWall() {
    if (v.y >= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime - (r.y - hs.y) / v.y;
  }

  float nextCollisionWithBottomWall() {
    if (v.y <= 0)
      return Float.POSITIVE_INFINITY;
    return currentTime + (height - (r.y + hs.y)) / v.y;
  }

  void collideWithWall() {
    if (verticalWallBounce)
      v.x = -v.x;
    else
      v.y = -v.y;
  }

  void moveTill(float time) {
    r.add(PVector.mult(v, time - currentTime));
  }

  boolean isTouching(Box other) {
    return this.r.x - this.hs.x <= other.r.x + other.hs.x &&
      this.r.x + this.hs.x >= other.r.x - other.hs.x &&
      this.r.y - this.hs.y <= other.r.y + other.hs.y &&
      this.r.y + this.hs.y >= other.r.y - other.hs.y;
  }

  boolean isTouching(ArrayList<Box> others) {
    for (Box other : others)
      if (isTouching(other))
        return true;
    return false;
  }

  boolean isTouchingLeftWall() {
    return r.x - hs.x <= 0;
  }

  boolean isTouchingRightWall() {
    return r.x + hs.x >= width;
  }

  boolean isTouchingTopWall() {
    return r.y - hs.y <= 0;
  }

  boolean isTouchingBottomWall() {
    return r.y + hs.y >= height;
  }

  boolean isTouchingAnyWall() {
    return isTouchingLeftWall() || isTouchingRightWall() || 
      isTouchingTopWall() || isTouchingBottomWall();
  }

  void display() {
    pushMatrix();
    translate(r.x, r.y);

    pushStyle();

    if (m == Float.POSITIVE_INFINITY) {
      if (v.mag() == 0.0) {
        fill(#FF0000);
        stroke(#FF0000);
      } else {
        fill(#00FF00);
        stroke(#00FF00);
      }
    } else {
      fill(map(m, 500, 5000, 192, 0));
      stroke(map(m, 500, 5000, 192, 0));
    }

    rectMode(CENTER);
    rect(0, 0, s.x, s.y);

    if (showId) {
      textAlign(CENTER, CENTER);
      textMode(SHAPE);
      textSize(12 * s.x / textWidth(str(id)));
      fill(255);
      text(id, 0, 0);
    }

    popStyle();

    popMatrix();
  }
}