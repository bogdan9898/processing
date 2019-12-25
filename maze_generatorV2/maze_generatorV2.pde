GRID[][] g;
GENERATOR generator;
final int cellW = 45;
final int cellH = 45;
int r;
int c;
int startI = 0;
int startJ = 0;

void setup() {
  size(900, 900);
  strokeWeight(2);
  r = width/cellW;
  c = height/cellH;
  g = new GRID[r][c];
  for (int i = 0; i < r; i++)
    for (int j = 0; j < c; j++) {
      g[i][j] = new GRID(i * cellW, j * cellH);
    }
  generator = new GENERATOR(startI, startJ);
  g[startI][startJ].isSet  = true;
}

void draw() {
  background(75);
  for (int i = 0; i < r; i++)
    for (int j = 0; j < c; j++)
      g[i][j].show();
  generator.move();
  generator.show();
}