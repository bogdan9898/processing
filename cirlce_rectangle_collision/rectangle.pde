class RECTANGLE {
  float x;
  float y;
  float w;
  float h;
  boolean colliding;

  RECTANGLE(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    colliding = false;
  }

  void render() {
    stroke(0);
    fill(255, 255, 0);
    rect(x, y, w, h);
  }
}