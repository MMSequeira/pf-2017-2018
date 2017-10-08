Snake snake;

void setup() {
  size(500, 500);
  
  snake = new Snake(0, 0, 1);
}

void draw() {
  background(255);

  snake.moveTo(mouseX, mouseY);
  snake.setScale(float(mouseY) / height);
  snake.display();
}