// The idea is for the spaceship to have a shield which is turned on
// and off randomly.
//
// The shield is part of the spaceship and a very simple concept. Hence,
// there is no need for the added complexity of using a separate class.
//
// Remember that the milkis() function returns the time in milliseconds
// ellapsed since the start of the program.
class Spaceship {
  // True if the shield in on, false if it is not:
  boolean shieldOn;
  // Constants used for specifying the minimum and maximum wait time
  // between toggles (changes of state) of the shield activation. Both
  // are in milliseconds (perhaps it would be better to use seconds,
  // though):
  float minimumWait = 1000;
  float maximumWait = 4000;
  // Stores the next time where a toggle of the shield activation state
  // should occur (measured in milliseconds from the start of the
  // program):
  float nextToggleTime;
  
  Spaceship() {
    // Initially the shield is off:
    shieldOn = false;
    // Calculate and store the next toggle time. It is calculated as
    // the current time (given by millis()) plus a random wait time
    // between the minimum and maximum wait time values:
    nextToggleTime = millis() + random(minimumWait, maximumWait);
  }
  
  void updateShield() {
    // If the current time is larger than or equal to the next toggle time,
    // then we should toggle the state of the shield. If it isn't, we do
    // nothing:
    if (millis() >= nextToggleTime) {
      // Toggle state of the shield:
      shieldOn = !shieldOn;
      // Calculate the time for the next state toggle:
      nextToggleTime = millis() + random(minimumWait, maximumWait);
    }
  }
  
  void update() {
    // The update() method should update the spaceship, move it, etc.
    // Since our ship is really simple, it only updates the shield:
    updateShield();
  }
  
  
  void display() {
    // A very simple spaceship indeed! If the shield is on, a
    // semi-transparent circle is drawn over the ship:
    noStroke();
    fill(255);
    ellipse(width / 2, height / 2, 50, 50);
    if (shieldOn) {
      fill(255, 0, 0, 64);
      ellipse(width / 2, height / 2, 100, 100);
    }
  }
}