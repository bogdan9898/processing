class TREE {
  float x;
  float y;
  float  hu;

  TREE(float x, float y, float hu) {
    this.x = x;
    this.y = y;
    this.hu = hu;
  }

  void show() {
    fill(hu % 360, 255, 150, 200);
    ellipse(x, y, r*2, r*2);
  }
}