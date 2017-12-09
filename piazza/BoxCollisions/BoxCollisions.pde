// Box collision detection and handling.


Controller controller;

int numberOfBoxes = 200;
ArrayList<Box> boxes;
float currentTime;
boolean showId = false;
int frame = 0;
float start;

void setup() {
  //randomSeed(7451232);
  size(1000, 1000, P2D);
  background(255);
  smooth(8);
  frameRate(60);
  
  controller = new Controller();
  
  boxes = new ArrayList<Box>();
    
  for (int i = 0; i != numberOfBoxes; i++) {
    float w = random(5, 50);
    float h = random(5, 50);
    PVector s = new PVector(w, h);
    float mass;
    PVector v;
    float number = random(1);
    if (number < 0.9) {
      mass = random(500, 5000);
      v = new PVector(random(-2, 2), random(-2, 2));
    } else {
      mass = Float.POSITIVE_INFINITY;
      // Having infinite mass boxes moving around is a really bad
      // idea, since our collision handling code cannot cope with
      // cases in which a finite mass box is squeezed between two
      // infinity mass boxes (or one and a wall):
      v = new PVector(0, 0);
    }
    
    Box box;
    do {
      PVector r = new PVector(random(0, width), random(0, height));
      box = new Box(s, mass, r, v, i);
    } while(box.isTouchingAnyWall() || box.isTouching(boxes));
    
    boxes.add(box);
  }
  
  start = millis();
}

// The draw code is exactly as for the balls, since the idea is
// the same:
void draw() {
  background(255);
  
  // First we let the (keyboard) controller act:
  controller.act();

  currentTime = 0.0;

  int collisions = 0;
  do {
    Box culpritBox1 = null;
    Box culpritBox2 = null;
    float nextCollisionTime = 1.0;
    
    for (int i = 0; i != boxes.size(); i++) {
      Box box1 = boxes.get(i);
      float nextCollisionWithWall = box1.nextCollisionWithWall();
      if (nextCollisionWithWall < nextCollisionTime) {
        culpritBox1 = box1;
        culpritBox2 = null;
        nextCollisionTime = nextCollisionWithWall;
      }
      for (int j = i + 1; j != boxes.size(); j++) {
        Box box2 = boxes.get(j);
        float nextCollisionOfBoxPair = box1.nextCollisionWith(box2);
        if (nextCollisionOfBoxPair < nextCollisionTime) {
          culpritBox1 = box1;
          culpritBox2 = box2;
          nextCollisionTime = nextCollisionOfBoxPair;
        }
      }
    }
    
    // println("Move till: " + nextCollisionTime);
    for (Box box : boxes)
      box.moveTill(nextCollisionTime);
  
    if (culpritBox1 != null) {
      collisions++;
      if (culpritBox2 != null)
        culpritBox1.collideWith(culpritBox2); 
      else
        culpritBox1.collideWithWall(); 
    }
    
    currentTime = nextCollisionTime;
  } while(currentTime < 1.0);

  float fps = (frame + 1) * 1000 / (millis() - start);
  println("Frame " + frame + " (" + fps + " fps): " + collisions + " collisions.");

  for (Box box : boxes)
    box.display();

  frame++;
}

void keyPressed() {
  controller.keyPressed(key, keyCode);
}

void keyReleased() {
  controller.keyReleased(key, keyCode);
}