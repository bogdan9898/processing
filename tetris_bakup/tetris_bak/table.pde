class TABLE {
  float x;
  float y;
  boolean isFree;
  color culoare;

  TABLE(float x, float y, color culoare) {
    this.x = x;
    this.y = y;
    this.isFree = true;
    this.culoare = culoare;
  }

  void dropDown(int tempI, int tempJ) { //println("start dropDown", tempI, tempJ);
    for (int j = tempJ; j >= 0; j--) {
      if (table[tempI][j+1].isFree == true && table[tempI][j].isFree == false) {
        table[tempI][j+1].isFree = false;
        table[tempI][j+1].culoare = table[tempI][j].culoare;
        table[tempI][j].isFree = true; //println("droped", tempI,j);
      }
    }
  }

  void update() {
    show();
  }

  void show () {
    if (isFree) {
      stroke(0);
      noFill();
      rect(x, y, size, size);
    } else {
      stroke(0);
      fill(culoare);
      rect(x, y, size, size); //println(x, y, this.isFree);
    }
  }
}