// Example of a class for applying a single light source, with 
// a Normal distribution of light intensity, to a given scene.
Background background;
Player player;
Controller controller;
Lighting lighting;

void setup() {
  fullScreen(P2D);
  smooth(8);
  
  background = new Background(#FFFFFF, 1000);
  player = new Player(new PVector(width / 2, height / 2), 40, #FF0000);
  controller = new Controller(10.0);
  lighting = new Lighting(player.position(), max(width, height) / 2);
}

void draw() {  
  background.update();
  player.update();
  controller.apply();
  lighting.update();
  
  background.display();
  player.display();
  lighting.apply();
}

void keyPressed() {
  controller.keyPressed(key, keyCode);
}

void keyReleased() {
  controller.keyReleased(key, keyCode);
}