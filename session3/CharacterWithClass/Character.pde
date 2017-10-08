// Now that we are using a class, x, y, and the scale are object properties.
// These properties are changed through appropriate methods (functions in a
// class are called methods). The original drawCharacter() function is now
// method display(), which uses the properties x, y, and scale, that is, the
// position and scale of the object.
class Character {
  float x;
  float y;
  float scale;
  
  Character(float x, float y, float scale) {
    this.x = x;
    this.y = y;
    this.scale = scale;
  }
  
  void moveTo(float newX, float newY) {
    x = newX;
    y = newY;
  }
  
  void setScale(float newScale) {
    scale = newScale;
  }
  
  void display() {
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
}