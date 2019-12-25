class SEEKERS {
  float x;
  float y;

  SEEKERS(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show() {
    ellipse(x, y, r*2, r*2);
  }

  void move() {
    x += random(-4, 4);
    y += random(-4, 4);
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  void checkCollison() {
    for (int i = startCountingTrees; i < counterTree; i++) {
      if (calcDist(tree[i].x, tree[i].y) < r * r * 4) {
        tree[counterTree] = new TREE(x, y, hu);
        if (counterTree > 2500)
          startCountingTrees++;
        hu += 0.01;
        counterTree ++;
        if (dist(tree[i+1].x, tree[i+1].y, width/2, height/2) > (searchZone - r * 2)) {
          searchZone += 4 * r;
        }
        int temp = int(random(4));
        if (temp == 0) {
          x = random(width)-r*2;
          y = 0+r*2;
        }
        if (temp == 1) {
          x = width-r*2;
          y = random(height)-r*2;
        }
        if (temp == 2) {
          x = random(width)-r*2;
          y = height-r*2;
        }
        if (temp == 3) {
          x = 0+r*2;
          y = random(height)-r*2;
        }
        break;
      }
    }
  }

  float calcDist(float x2, float y2) {
    float difx = x2 - x;
    float dify = y2 - y;
    return difx * difx + dify * dify;
  }
}