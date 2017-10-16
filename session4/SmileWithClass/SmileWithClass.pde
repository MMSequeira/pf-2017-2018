Smile smile;

void setup() {
  size(400, 400);
  background(#4264BC);
  
  smile = new Smile(200, 200, QUARTER_PI, 1.5);
}

void draw() {
  background(#4264BC);

  smile.display();
}