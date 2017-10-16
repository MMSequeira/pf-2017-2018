Ball ball1;
Ball ball2;

void setup() {
  size(500, 500);
  background(255);
  
  ball1 = new Ball(50, width / 3, height / 2, 10, 17);
  ball2 = new Ball(50, width / 2, height / 3, 13, 11);
}

void draw() {
  background(255);
  
  ball1.move();
  ball2.move();
  
  if (ball1.isTouching(ball2))
    background(#FF0000);
  
  ball1.display();
  ball2.display();
}