float f(float x) {
  return sin(x);
}

final float inc = 0.1;

void setup() {
  size(900, 900);
  stroke(0, 70);
  strokeWeight(5);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
}

void draw() {
  translate(width/2,0);
  rotate(PI/2);
  float prevX = 0;
  float prevY = f(-width/2);
  for (float x = -width/2+inc; x < width/2; x+=inc) {
    float y = f(x);
    line(x, y, prevX, prevY);
    prevX = x;
    prevY = y;
  }
  noLoop();
}