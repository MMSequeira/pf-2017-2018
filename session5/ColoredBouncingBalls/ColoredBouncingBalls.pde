Ball ball1;
Ball ball2;

void setup() {
  size(500, 500);
  background(255);
  
  ball1 = new Ball(50, #FF0000, width / 3, height / 2, 10, 17);
  ball2 = new Ball(50, #00FF00, width / 2, height / 3, 13, 11);
}

void draw() {
  background(255);
  
  ball1.move();
  ball2.move();
  
  ball1.display();
  ball2.display();
}