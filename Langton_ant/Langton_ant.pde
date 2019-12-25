boolean[][] history;
ANT ant;
void setup() {
  size(500, 500);
  history = new boolean[width][height];
  for (int i = 0; i < width; i++)
    for (int j = 0; j < height; j++) {
      history[i][j] = false;
    }
  ant = new ANT();
  stroke(0);
}

void draw() {
  background(255);
  for (int n = 0; n < 100; n++) {
    ant.moveForward();
    for (int i = 0; i < width; i++)
      for (int j = 0; j < height; j++) {
        if (history[i][j])
          point(i, j);
      }
  }
  ant.showAnt();
  //ant.showDir();
}