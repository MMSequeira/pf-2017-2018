Snake snake;

void setup() {
  size(500, 500);
  
  snake = new Snake(width / 2, height / 2, 10); 
}

void draw() {
  background(0);
    
  snake.display();
}

void keyPressed() {
  if (key == CODED)
    if (keyCode == RIGHT)
      snake.moveRight();
    else if (keyCode == LEFT)
      snake.moveLeft();
    else if (keyCode == UP)
      snake.moveUp();
    else if (keyCode == DOWN)
      snake.moveDown();
}