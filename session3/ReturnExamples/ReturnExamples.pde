float radiansOf(float angleInDegrees) {
  return PI / 180 * angleInDegrees;
}

void myArc(float x, float y, float width, float height, 
  float startAngle, float endAngle) {
  arc(x, y, width, height, radiansOf(startAngle), radiansOf(endAngle));
  return;
}

void setup() {
  size(400, 200);
}

void draw() {
  noStroke();
  fill(255, 0, 0);
  myArc(width / 2, height / 2, width / 2, height / 2, 0, 180);
}