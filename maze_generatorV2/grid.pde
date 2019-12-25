class GRID {
  float x;
  float y;
  boolean[] walls = {true, true, true, true};
  boolean isSet = false;

  GRID(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show() {
    if (isSet == true) {
      fill(0, 128, 128);
      noStroke();
      rect(x, y, cellW, cellH);
    }
    stroke(255, 69, 0);
    if (walls[0] == true)
      line(x, y, x + cellW, y); //SUS
    if (walls[1] == true)
      line(x + cellW, y, x + cellW, y + cellH); //DREAPTA
    if (walls[2] == true)
      line(x + cellW, y + cellH, x, y + cellH); //JOS
    if (walls[3] == true)
      line(x, y + cellH, x, y); //STANGA
  }

  //void showFinalGrid() {
  //  stroke(255, 69, 0);
  //  if (walls[0] == true)
  //    line(x, y, x + cellW, y); //SUS
  //  if (walls[1] == true)
  //    line(x + cellW, y, x + cellW, y + cellH); //DREAPTA
  //  if (walls[2] == true)
  //    line(x + cellW, y + cellH, x, y + cellH); //JOS
  //  if (walls[3] == true)
  //    line(x, y + cellH, x, y); //STANGA
  //}
}