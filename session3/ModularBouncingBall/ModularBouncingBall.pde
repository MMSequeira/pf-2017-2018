float diameter;
float x;
float y;
float vx;
float vy;

void initialize(float diameter, float x, float y, float vx, float vy) {
  this.diameter = diameter;
  this.x = x;
  this.y = y;
  this.vx = vx;
  this.vy = vy;
}

void move() {
  x += vx;
  y += vy;
  bounce();
}

void bounce() {
  if (x + diameter / 2 > width) {
    x = width - diameter / 2;
    vx = -vx;
  } else if(x - diameter / 2 < 0) {
    x = diameter / 2;
    vx = -vx;
  }
  if (y + diameter / 2 > height) {
    y = height - diameter / 2;
    vy = -vy;
  } else if(y - diameter / 2 < 0) {
    y = diameter / 2;
    vy = -vy;
  }
}

void display() {
  fill(0);
  ellipse(x, y, diameter, diameter);
}

void setup() {
  size(500, 500);
  background(255);
  
  initialize(100, width / 2, height / 2, 10, 17);
}

void draw() {
  background(255);
  
  move();
  
  display();
}