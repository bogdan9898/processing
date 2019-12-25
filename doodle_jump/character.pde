class CHARACTER {
  int x;
  int y;
  int scale;
  float speed;
  float gravity;
  float dir;

  CHARACTER() {
    x = width/2;
    y = height/4;
    scale = 50;
    speed = 1;
    gravity = 0.25;
    dir = 0;
  }

  void moveX() {
    x += dir;
    if (dir > 0)
      dir += gravity;
    if (dir < 0)
      dir -= gravity;
  }

  void moveY() {
    y += speed;
    updateSpeed();
  }

  void updateSpeed() {
    speed += gravity;
    speed = constrain(speed, -10, 10);
    //println(speed);
  }

  void chFalling() {
    speed = -10;
  }

  void edge() {
    if (x < -scale/2)
      x = width;
    if (x > width+scale/2)
      x = 0;
  }

  void dead() {
    if (y > height + scale)
      gameOver = true;
  }

  void render() {
    //debugging
    //fill(0, 175, 250, 50);
    //ellipse(x, y, scale, scale);
    //debugging
    if (mirror) {
      pushMatrix();
      scale(-1, 1);
      image(character, -x-7, y);
      popMatrix();
    } else
      image(character, x-7, y);
    //debugging
    //fill(255, 0, 0);
    //ellipse(x, y, 5, 5);
    //ellipse(x-10, y+20, 5, 5);
    //ellipse(x+10, y+20, 5, 5);
    //debugging
  }
}