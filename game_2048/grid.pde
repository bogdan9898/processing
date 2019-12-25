class GRID {
  float x;
  float y;
  int value;

  GRID(float x, float y) {
    this.x = x;
    this.y = y;
    //this.value = list[int(random(list.length))];
    this.value = 0;
  }

  void show() {
    if (value != 0) {
      fill(d.get(str(value)), 125, 225);
      rect(x, y, scale, scale);
      textSize(map(value, 2, 2048, 45, 25));
      textAlign(CENTER, CENTER);
      fill(255);
      text(str(value), x+scale/2, y+scale/2);
    } else {
      fill(255);
      rect(x, y, scale, scale);
    }
  }
}