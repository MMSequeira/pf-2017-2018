class Spaceship {
  // Add the attributes here, i.e., the variables which store each starship
  // properties
  
  // Complete the class constructor, which receives the x and y coordinates
  // of the initial spaceship position, the initial angle (relative to the
  // horizontal X axis) of the spaceship, and the initial scale of the
  // spaceship, which controls the size with which it is drawn (a scale of 1.0
  // meaning it is drawn with the default size).
  Spaceship(float x, float y, float angle, float scale) {
  }

  // Complete this method so that it changes the scale of the spaceship to
  // the new scale received in parameter newScale.
  void setScaleTo(float newScale) {
  }
  
  // Complete this method so that it changes the angle of the spaceship to
  // the new angle received in parameter newAngle. It may be a good idea to
  // ensure the angle remains between -π and π.
  void rotateTo(float newAngle) {
  }
  
  // Complete this method so that it changes the position of the spaceship to
  // the new position received in parameters newX and newY.
  void moveTo(float newX, float newY) {
  }
  
  // Complete this method so that it draws the spaceship in its position,
  // with its angle, and with its scale. Make use of transformations to
  // achieve the desired result. Use translate(), rotate(), and scale().
  // Remeber to do a pushMatrix() before the transformations and a
  // popMatrix() after drawing, so that drawing the spaceship does not lead to
  // changes in the coordinate system.
  void display() {
  }
}