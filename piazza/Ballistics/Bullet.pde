// This class is very similar to the Particle classe shown in class.

class Bullet {
  PVector position; // position
  PVector velocity; // velocity
  float angle; // angle
  
  Bullet(PVector initialPosition, PVector initialVelocity) {
    // Set the inicial position and velocity of the bullet
    position = initialPosition.copy();
    velocity = initialVelocity.copy();
  }
  
  void update() {
    // The bullet is subject to the acceleration of gravity. This is a vector pointing
    // down:
    PVector acceleration = new PVector(0, 0.02);
    // The acceleration of gravity was chosen manually, so that the bullet would follow a
    // nice parabolic trajectory. 0.1 means 0.1 pixels per frame squared.
    
    // Since a = d v / d t, where a is the acceleration, v the velocity, and t the time,
    // we may approximate and get delta v = a * delta t, where delta v is the change in
    // velocity after a time interval of delta t. If the time interval is one frame,
    // delta t = 1 and thus delta v = a. That is, the velocity in the current frame is
    // equal to the velocity in the previous frame plus the acceleration:
    velocity.add(acceleration);
    
    // Since v = d r / d t, v is the velocity, r the position, and t the time, we may
    // approximate and get delta r = v * delta t, where delta r is the change in
    // position after a time interval of delta t. If the time interval is one frame,
    // delta t = 1 and thus delta r = v. That is, the position in current frame is equal
    // to the position in the previous frame plus the velocity:
    position.add(velocity);
    
    // We assume the angle of the bullet to be the same as the angle of its velocity
    // vector, so the the lenght of the bullet is always a tangent to the trajectory.
    // This does not have to be this way, it just looks nice:
    angle = velocity.heading();
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    
    pushStyle();
    stroke(0);
    line(0, 0, 40, 0);
    line(40, 0, 30, -10);
    line(40, 0, 30, 10);
    popStyle();
    
    popMatrix();
  }
  
}