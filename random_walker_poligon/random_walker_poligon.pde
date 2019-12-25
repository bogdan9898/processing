final int Laturi = 4;
final int r = 300;
POLIGON[] p = new POLIGON[Laturi];

void setup() {
  size(1000, 900);
  strokeWeight(3);
  noFill();
  stroke(255, 0, 0);
  for (int i = 0; i < Laturi; i++) {
    float alfa = PI*2/Laturi;
    float x = width/2 + cos(alfa*i)*r;
    float y = height/2 + sin(alfa*i)*r;
    p[i] = new POLIGON(x, y);
  }
}

void draw() {
  background(70);
    for (int i = 0; i < Laturi; i++) {
      p[i].move();
    }
  drawPoligon();
}

void drawPoligon() {
  beginShape();
  for (int i = 0; i < Laturi; i++)
    vertex(p[i].x, p[i].y);
  endShape(CLOSE);
}