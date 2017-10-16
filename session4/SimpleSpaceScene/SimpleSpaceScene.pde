size(500, 500);

// Starfield:
background(0);
noFill();
stroke(255);
for (int i = 0; i != 500; i++) {
  strokeWeight(random(1, 4));
  point(random(0, width), random(0, height));
}

// Spaceship with alien:
noStroke();
fill(192);
arc(250, 250, 200, 100, 0, PI);
fill(255);
ellipse(250, 250, 200, 50);
fill(0);
ellipse(250, 250, 80, 20);
fill(200, 64);
imageMode(CENTER);
PImage alien = loadImage("alien.png");
alien.resize(alien.width / 30, alien.height / 30);
image(alien, 250, 225);
rect(210, 200, 80, 50);
arc(250, 200, 80, 80, -PI, 0);
arc(250, 250, 80, 20, 0, PI);