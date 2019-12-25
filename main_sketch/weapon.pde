class WEAPON {
  float x;
  float y;

  WEAPON (float x, float y) {
    this.x = x;
    this.y = y;
  }

  void aim() {
    stroke(255, 0, 0);
    strokeWeight(12);
    pushMatrix();
    translate(x, y);
    if (mouseY-y >= 0) {
      line(0, 0, -(mouseX-x), -(mouseY-y));
      float d = dist(0, 0, -(mouseX-x), -(mouseY-y));
      if ((mouseX-x) < 0) {
        arrow = new Arrow(x, y, -(mouseX-x), -(mouseY-y), asin((mouseY-y) / d)); //println(asin((mouseY-y) / d));
      } else {
        arrow = new Arrow(x, y, -(mouseX-x), -(mouseY-y), PI-asin((mouseY-y) / d)); //println(PI-asin((mouseY-y) / d));
      }
    } else {
      line(0, 0, -(mouseX-x), 0);
      float d = dist(0, 0, -(mouseX-x), 0);
      if ((mouseX-x) > 0) {
        arrow = new Arrow(x, y, -(mouseX-x), 0, PI);
      } else {
        arrow = new Arrow(x, y, -(mouseX-x), 0, asin(0 / d));
      }
    }
    popMatrix();
  }
}