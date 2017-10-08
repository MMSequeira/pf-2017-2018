// Since we have a class, we may have several objects (instances) of that
// class:
Character character1;
Character character2;

void setup() {
  // Set display window size:
  size(500, 500);
  
  // Paint background white:
  background(255);
  
  // Create the two characters (instantiating the class):
  character1 = new Character(width / 2, width / 2, 0.5);
  character2 = new Character(width / 2, width / 2, 0.5);
}

void draw() {
  // Paint background white:
  background(255);

  // Move and scale the characters interestingly:
  character1.moveTo(mouseY, width / 2);
  character2.moveTo(mouseX, mouseY);
  character2.setScale(float(mouseY) / height);

  // Display the characters:
  character1.display();
  character2.display();
}