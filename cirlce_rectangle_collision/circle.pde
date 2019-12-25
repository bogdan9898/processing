class CIRCLE {
  float x;
  float y;
  float r;
  boolean colliding;

  CIRCLE(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    colliding = false;
  }

  void followCursor() {
    x = mouseX;
    y = mouseY;
  }

  void render() {
    stroke(0);
    if (colliding)
      fill(255, 0, 0);
    else
      fill(0, 255, 0);
    ellipse(x, y, r*2, r*2);
  }
}