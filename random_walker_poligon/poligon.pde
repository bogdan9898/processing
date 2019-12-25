class POLIGON {
  float x;
  float y;
  float stepLength = 0.25;
  float maxSteps = 5;

  POLIGON(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void move() {
    int dir = floor(random(4));
    int steps = round(random(maxSteps));
    switch (dir) {
    case 0:
      for (int i = 0; i < steps; i++) {
        x += stepLength;
        x = constrain(x, 0, width);
      }
      break;
    case 1:
      for (int i = 0; i < steps; i++) {
        x -= stepLength;
        x = constrain(x, 0, width);
      }
      break;
    case 2:
      for (int i = 0; i < steps; i++) {
        y += stepLength;
        y = constrain(y, 0, height);
      }
      break;
    case 3:
      for (int i = 0; i < steps; i++) {
        y -= stepLength;
        y = constrain(y, 0, height);
      }
      break;
    }
  }
}