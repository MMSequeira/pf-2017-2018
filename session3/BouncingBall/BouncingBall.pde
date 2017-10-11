float diameter;
float x;
float y;
float vx;
float vy;

void setup() {
  size(500, 500);
  background(255);
  
  diameter = 100;
  x = width / 2;
  y = height / 2;
  vx = 10;
  vy = 17;
}

void draw() {
  background(255);
  
  x += vx;
  y += vy;
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
  
  fill(0);
  ellipse(x, y, diameter, diameter);
}