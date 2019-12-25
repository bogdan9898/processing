class BALL {
  float x;
  float y;
  float r;
  PVector speed;

  BALL(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    speed = new PVector(3, 10);
  }

  void edge() {
    if (y - r < 0) {
      //println("touched top");
      reflect("y");
    }
    if (y + r >= height) {
      //println("touched bottom");
      reflect("y");
    }
    if (x - r < 0) {
      //println("touched right");
      reflect("x");
    }
    if (x + r >= width) {
      //println("touched left");
      reflect("x");
    }
  }

  void reflect(String s) {
    if (s.equals("x"))
      speed.x = -speed.x;
    if (s.equals("y"))
      speed.y = -speed.y;
  }

  void move() {
    edge();
    x += speed.x;
    y += speed.y;
  }

  void render() {
    fill(136, 44, 211);
    ellipse(x, y, r*2, r*2);
  }
}