/*
 A few experiments with Tiled, a modification of Ptmx, and fancy cameras:
 1. Ptmx was modified:
    (a) It now supports transparent background colors (though they have no
        visual effect).
    (b) It no longer paints the whole background black. Rather, it leaves
        it untouched, which means maps can nicely overlap fancy
        backgrounds.
    (c) It no longer resets the coordinate system matrix, which means all
        transformations can be applied to the map!
    (d) Beware! The change is incomplete. Ptmx avoids drawing out of screen
        tiles, and that part of the code was not updated. This means large
        maps will be clipped in weird places! Beware!
 2. We have a fancy camera, which follows a game entity (in the case the
    ball) within a certain margin, which can be zoomed in and out, rotated,
    and reset.
    
 The sketch consists:
 - Of a fancy background (made of random balls over black).
 - Of a Tiled map, with ugly tiles...
 - ...which contains four spawn objects that are used to spawn small
   gravity influenced balls.
 - Of a "player" consisting of a red ball.
 
 What you can do (all this is rather pointless, but the purpose is to
 show what is possible in Processing, together with Tiled):
 - Use the arrow keys to move the ball.
 - Hover the mouse pointer over any ball to highlight it.
 - Use 'z' and 'x' to zoom in and out.
 - Use '<' and '>' to rotate the camera left (counterclockwise) and
   right (clockwise).
 - Press 'r' for a while to reset the camera.
*/
Controller controller;
Background background;
Map map;
Ball ball;
BallManager ballManager;
Camera camera;

void setup() {
  fullScreen(P2D);
  smooth(8);

  controller = new Controller();
  background = new Background(#000000, 1000, 
    new PVector(-width / 2, -height / 2), 
    new PVector(3 * width / 2, 3 * height / 2));
  map = new Map(this, "map.tmx", new PVector(100, 150));
  ball = new Ball(new PVector(200, 200), new PVector(0, 0), new PVector(0, 0), 
    30, #FF0000, #FFFFFF);
  ballManager = new BallManager();
  camera = new Camera(new PVector(width / 2, height / 2));
}

void draw() {
  controller.apply();

  background.update();
  map.update();
  ball.update();
  ballManager.update();
  camera.update();

  ballManager.spawn();
  
  camera.apply();

  background.display();
  map.display();
  ball.display();
  ballManager.display();
}

void keyPressed() {
  controller.keyPressed(key, keyCode);
}

void keyReleased() {
  controller.keyReleased(key, keyCode);
}