class ANT {
  PVector pos = new PVector(width/2, height/2);
  PVector dir = new PVector(0, -1);

  void moveForward() {
    checkPos();
    pos.add(dir);
    if (pos.x >= width) {
      pos.x = 0;
    }
    if (pos.x < 0) {
      pos.x = width - 1;
    }
    if (pos.y >= height) {
      pos.y = 0;
    }
    if (pos.y < 0) {
      pos.y = height - 1;
    }
    history[int(pos.x)][int(pos.y)] = !history[int(pos.x)][int(pos.y)];
  }

  void checkPos() {
    if (history[int(pos.x)][int(pos.y)]) {
      changeDir(1);
    } else {
      changeDir(-1);
    }
  }

  void changeDir(int c) { //1 = right, -1 = left
    if (c == 1) {//right
      dir.rotate(PI/2);
    } else {//c == -1//left
      dir.rotate(-PI/2);
    }
  }

  void showDir() {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(255, 0, 0);
    line(dir.x, dir.y, dir.x*20, dir.y*20);
    stroke(0, 0, 0);
    popMatrix();
  }


  void showAnt() {
    strokeWeight(3);
    stroke(255, 0, 0);
    point(pos.x, pos.y);
    stroke(0, 0, 0);
    strokeWeight(1);
  }
}