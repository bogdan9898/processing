int scale = 100, w = 0, h = 0;

void setup() {
  size(500, 400);
  background(90);
  w = width/scale;
  h = height/scale;
}

void draw() {
  for (int i = 0; i < w; i++)
    for (int j = 0; j < h; j++) {
      int x = i*scale;
      int y = j*scale;
      noFill();
      strokeWeight(3);
      rect(x, y, scale, scale);
      textAlign(CENTER, CENTER);
      textSize(50);
      text(i+","+j, x+scale/2, y+scale/2);
    }
}