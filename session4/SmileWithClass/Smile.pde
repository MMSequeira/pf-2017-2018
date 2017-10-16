class Smile {
  float x;
  float y;
  float angle;
  float scale;
  
  Smile(float x, float y, float angle, float scale) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.scale = scale;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    scale(scale);

    fill(#AD2530);
    ellipse(0, 0, 200, 200);
    fill(0);
    float size = 200;
    float eyeSize = size / 5;
    float mouthSize = size / 2.5;
    ellipse(-size / 5, -size / 10, eyeSize, eyeSize);
    ellipse(size / 5, -size / 10, eyeSize, eyeSize);
    arc(0, 10, mouthSize, mouthSize, 0, PI);
    
    popMatrix();
  }
}