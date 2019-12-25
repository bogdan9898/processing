int rows, cols;
int scale = 100;
int r = 220;

void setup() {
  size(900, 900);
  rows = height/scale;
  cols = width/scale;
  //ellipseMode(CENTER);
}

boolean debugging = true;

void draw() {
  background(200);
  strokeWeight(3);
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      if (dist(i*scale+scale/2, j*scale+scale/2, width/2, height/2) < r) {
        fill(0, 250, 0, 75);
      } else {
        noFill();
      }
      stroke(0, 50);
      rect(i*scale, j*scale, scale, scale);
      stroke(0, 0, 255);
      point(i*scale+scale/2, j*scale+scale/2);
    }
  }
  stroke(255, 0, 0);
  noFill();
  ellipse(width/2, height/2, r*2, r*2);

  fill(255, 0, 255, 50);

  for (float a = 0; a < 2*PI; a+=0.05) {
    int x = int(r*cos(a))+width/2;
    int y = int(r*sin(a))+height/2;

    if (debugging)
      println(x);
    x = round(x/float(scale))*scale;
    if (debugging)
      println(x);
    debugging = false;
    y = round(y/float(scale))*scale;
    if (dist(x+scale/2, y+scale/2, width/2, height/2) < r) {
      noStroke();
      rect(x, y, scale, scale);
    }

    //noFill();
    stroke(255, 255, 0);
    strokeWeight(10);
    point(x, y);
  }
}