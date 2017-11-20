// A bullet (actually, it looks a lot more with an arrow :-)) shot with a given initial
// velocity from a given initial position and subject to the acceleration of gravity.

Bullet bullet;

void setup() {
  size(500, 500);
  
  bullet = new Bullet(new PVector(50, 450), new PVector(1, -4));
}

void draw() {
  background(255);
  
  bullet.update();
  
  bullet.display();
}