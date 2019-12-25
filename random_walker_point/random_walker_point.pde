float x;
float y;

void setup() {
  size(1280, 720);
  strokeWeight(3);
  x = width/2;
  y = height/2;
}

void draw() {
  move();
  if (x > width || y > height){
    noLoop();
    println("Finished");
  }
}

void move() {
  int dir = floor(random(4));
  int steps = round(random(5));
  switch (dir) {
  case 0:
    for (int i = 0; i < steps; i++) {
      x += 1;
      show();
    }
    break;
  case 1:
    for (int i = 0; i < steps; i++) {
      x -= 1;
      show();
    }
    break;
  case 2:
    for (int i = 0; i < steps; i++) {
      y += 1;
      show();
    }
    break;
  case 3:
    for (int i = 0; i < steps; i++) {
      y -= 1;
      show();
    }
    break;
  }
}

void show() {
  point(x, y);
}