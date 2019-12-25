class PLAYER {
  float x;
  float y;
  float w;
  float h;
  int dir;

  PLAYER(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void move() {//dir -> -1 = up; 1 = down
    if ((y-h/2 > 0 && dir < 0) || (y+h/2 < height && dir > 0))
      y += dir;
  }

  void render() {
    fill(255, 178, 0);
    rect(x, y, w, h);
  }
}