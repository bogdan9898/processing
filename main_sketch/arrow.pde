class Arrow {
  float x;
  float y; 
  float xVel; 
  float yVel;  
  int size = 20; //marimea sagetii
  float size_prim = size/3; //marimea segmentelor sagetii etc
  int d = round(dist(size, 0 - size_prim, size, 0 + size_prim)); //latura triungh echilat pt vf sagetii
  float alfa; //rotatia sagetii

  Arrow (float x, float y, float xVel, float yVel, float alfa) {
    this.x = x;
    this.y = y;
    this.xVel = xVel/50; 
    this.yVel = yVel/50;
    this.alfa = alfa;
  }

  void show() {
    fill(0);
    stroke(0, 0, 0); 
    strokeWeight(4);
    pushMatrix();
    translate(x, y);
    rotate(-alfa);
    line(0, 0, size, 0);
    beginShape();
    vertex(size, 0-size_prim);
    vertex(size+(d*sqrt(3)/2), 0);
    vertex(size, 0 + size_prim);
    endShape(CLOSE);
    line(0, 0, 0-size/2, 0);
    line(0-size/2, 0, 0-cos(PI/9)*size, 0-sin(PI/9)*size);
    line(0-size/2, 0, 0-cos(PI/9)*size, 0+sin(PI/9)*size);
    popMatrix();
  }

  void HBShot() {
    x += xVel;  //println("x este", x);
    y += yVel;  //println("y este", y);
    show();
    collison();
  }

  void collison() {
    if (x < 0 || x > width || y < 0 || y >height)
      arrowIsFlying = false;
  }
}