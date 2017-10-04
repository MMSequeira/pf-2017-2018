// The original character was always drawn centered in
// the display window, that is, at (250, 250), with a
// height of 390. The center is conventional, since we
// might have chosen a somewhat different center point.
// The height of 390 was also considered the normal
// scale, i.e., scale 1.

// In order to make the drawing of the character more
// generic, we changed the code so that it is drawn
// centered in position (x, y), where x and y are
// parameters of the drawCharacter() function, and so
// that it is drawn with the given scale, which os also
// a parameter of the function. Notice that calling
// drawCharacter(250, 250, 1) draws exactly the same
// character as the original code.
//
// Notice that:
// - Positions are now all relative to x and y.
// - All sizes and distances, including offsets from x
// and y, are now proportional to the scale
//
// Notice also that the code can be greatly improved
// by using other variables to store, e.g., the size of
// the eyes, etc.
void drawCharacter(float x, float y, float scale) {
  // Set white fill so that the following shapes are
  // filled with white (until the next call to fill()):
  fill(255);

  // Set all lines and borders to black until the next
  // call to stroke():
  stroke(0);

  // Draw the head circle:
  ellipse(x, y - scale * 150, scale * 80, scale * 80);

  // Set black fill for the eyes:
  fill(0);

  // Draw the eyes:
  ellipse(x - scale * 30, y - scale * 150, scale * 15, scale * 15);
  ellipse(x + scale * 20, y - scale * 150, scale * 15, scale * 15);

  // Set white fill again to draw the torso:
  fill(255);

  // Draw the torso rectangle:
  rect(x - scale * 10, y - scale * 110, scale * 20, scale * 160);

  // Draw the left leg:
  line(x - scale * 10, y + scale * 50, x - scale * 50, y + scale * 200);

  // Draw the right leg:
  line(x + scale * 10, y + scale * 50, x + scale * 50, y + scale * 200);

  // Draw the right arm top:
  line(x + scale * 10, y - scale * 90, x + scale * 50, y - scale * 50);

  // Draw the right arm bottom:
  line(x + scale * 50, y - scale * 50, x, y - scale * 10);
  
  // Draw the left arm top:
  line(x - scale * 10, y - scale * 90, x - scale * 50, y - scale * 70);
  
  // Draw the left arm bottom:
  line(x - scale * 50, y - scale * 70, x - scale * 100, y - scale * 90);

  // Draw the fingers:
  line(x - scale * 97, y - scale * 100, x - scale * 105, y - scale * 120);
  line(x - scale * 97, y - scale * 100, x - scale * 92, y - scale * 120);

  fill(255);
  
  // Draw the hand circle:
  ellipse(x - scale * 100, y - scale * 95, scale * 15, scale * 15);
}

void setup() {
  // Set display window size:
  size(500, 500);
  
  // Paint background white:
  background(255);
}

void draw() {
  // Paint background white:
  background(255);

  // Draw the character at the position of the mouse
  // with the scale increasing from 0 to 1.0 from the
  // top to the bottom border of the display window,
  // producing a depth efect:
  drawCharacter(mouseX, mouseY, float(mouseY) / height);
}