void setup() {
  size(500, 500);
}

void draw() {
  drawSnake();
}

void drawSnake() {
  drawSnakeBody();
  drawSnakeHead();
}

void drawSnakeBody() {
  fill(255);
  for (int i = 0; i < 6; i++) {
    ellipse(250, 250 + i * 40, 40, 40);
  }
}

void drawSnakeHead() {
  stroke(0);
  line(250, 190, 250, 170);
  line(250, 170, 230, 150);
  line(250, 170, 270, 150);
  fill(0);
  rect(230, 210 - 20, 40, 40);
  fill(255);
  ellipse(240, 210, 10, 10);
  ellipse(260, 210, 10, 10);
}

void drawSnakeBodyAttempt5() {
  fill(255);
  int i = 0;
  while (i < 6) {
    ellipse(250, 250 + i * 40, 40, 40);
    i++;
  }
}

void drawSnakeBodyAttempt4() {
  fill(255);
  int ring = 0;
  while (ring < 6) {
    ellipse(250, 250 + ring * 40, 40, 40);
    ring++;
  }
}

void drawSnakeBodyAttempt3() {
  fill(255);
  float ringY = 250;
  while (ringY < 250 + 6 * 40) {
    ellipse(250, ringY, 40, 40);
    ringY += 40;
  }
}

void drawSnakeBodyAttempt2() {
  fill(255);
  float ringY = 250;
  ellipse(250, ringY, 40, 40);
  ringY += 40;
  ellipse(250, ringY, 40, 40);
  ringY += 40;
  ellipse(250, ringY, 40, 40);
  ringY += 40;
  ellipse(250, ringY, 40, 40);
  ringY += 40;
  ellipse(250, ringY, 40, 40);
  ringY += 40;
  ellipse(250, ringY, 40, 40);
  ringY += 40;
}

void drawSnakeBodyAttempt1() {
  fill(255);
  ellipse(250, 250, 40, 40);
  ellipse(250, 250 + 1 * 40, 40, 40);
  ellipse(250, 250 + 2 * 40, 40, 40);
  ellipse(250, 250 + 3 * 40, 40, 40);
  ellipse(250, 250 + 4 * 40, 40, 40);
  ellipse(250, 250 + 5 * 40, 40, 40);
}