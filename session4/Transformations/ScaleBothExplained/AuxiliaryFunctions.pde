int elementSize = 10;
int intervalLength = 50;

void drawCoordinateSystem(color axisColor, float width, float height) {  
  stroke(axisColor);
  fill(axisColor);
  
  line(0, 0, width, 0);
  line(width, 0, width - elementSize, -elementSize);
  line(width, 0, width - elementSize, +elementSize);
  
  textAlign(CENTER, TOP);
  for(float x = 0; x < width; x += intervalLength) {
    line(x, -elementSize, x, elementSize);
    text(round(x), x, elementSize);
  }
  text("X", width - elementSize, elementSize);
    
  line(0, 0, 0, height);
  line(0, height, -elementSize, height - elementSize);
  line(0, height, +elementSize, height - elementSize);
  
  textAlign(LEFT, CENTER);
  for(float y = 0; y < height; y += intervalLength) {
    line(-elementSize, y, elementSize, y);
    text(round(y), elementSize + 5, y);
  }
  text("Y", elementSize + 5, height - elementSize);
}

void drawTranslation(color translationColor, float x, float y) {
  strokeWeight(2);
  stroke(translationColor);
  fill(translationColor);
  
  line(0, 0, x, y);
  
  pushMatrix();
  
  translate(x, y);
  rotate(atan2(y, x));
  
  line(0, 0, -2 * elementSize, -elementSize);
  line(0, 0, -2 * elementSize, +elementSize);

  textAlign(CENTER, BOTTOM);
  text("(" + round(x) + ", " + round(y) + ")", -dist(0, 0, x, y) / 2, -elementSize / 2);

  popMatrix();

  strokeWeight(1);
}

void drawRotation(color rotationColor, float angle) {
  strokeWeight(2);
  stroke(rotationColor);
  noFill();
  
  float diameter = 4 * intervalLength;
  
  arc(0, 0, diameter, diameter, 0, angle);
  arc(0, 0, diameter, diameter, HALF_PI, HALF_PI + angle);
  
  fill(rotationColor);
  
  pushMatrix();
  
  rotate(angle / 2);
  translate(diameter / 2, 0);

  textAlign(LEFT, CENTER);
  text(round(degrees(angle)) + "º", 10, 0);

  popMatrix();
  
  pushMatrix();
  
  rotate(angle / 2 + HALF_PI);
  translate(diameter / 2, 0);

  textAlign(LEFT, CENTER);
  text(round(degrees(angle)) + "º", 10, 0);

  popMatrix();

  pushMatrix();
  
  rotate(angle);
  translate(diameter / 2, 0);
  
  line(0, 0, -elementSize, -2 * elementSize);
  line(0, 0, +elementSize, -2 * elementSize);

  popMatrix();

  pushMatrix();
  
  rotate(angle + HALF_PI);
  translate(diameter / 2, 0);
  
  line(0, 0, -elementSize, -2 * elementSize);
  line(0, 0, +elementSize, -2 * elementSize);

  popMatrix();

  strokeWeight(1);
}

void drawShearX(color shearXColor, float angle) {
  strokeWeight(2);
  stroke(shearXColor);
  noFill();
  
  float diameter = 6 * intervalLength;
  
  arc(0, 0, diameter, diameter, HALF_PI - angle, HALF_PI);
  
  fill(shearXColor);
  
  pushMatrix();
  
  rotate(HALF_PI - angle / 2);
  translate(diameter / 2, 0);

  textAlign(LEFT, CENTER);
  text(degrees(angle) + "º", 10, 0);

  popMatrix();

  pushMatrix();
  
  rotate(HALF_PI - angle);
  translate(diameter / 2, 0);
  
  line(0, 0, -elementSize, 2 * elementSize);
  line(0, 0, +elementSize, 2 * elementSize);

  popMatrix();

  strokeWeight(1);
}