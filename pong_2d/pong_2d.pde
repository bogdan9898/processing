BALL ball;
PLAYER player[];
//final int boxW = 30, boxH = 100, ballR = 30;
final int playerSpeed = 7;

void setup() {
  size(900, 500);
  rectMode(CENTER);
  ellipseMode(CENTER);
  strokeWeight(2);
  ball = new BALL(width/2, height/2, 30);
  player = new PLAYER[2];
  player[0] = new PLAYER(0, height/2, 30, 100);
  player[1] = new PLAYER(width, height/2, 300, 100);
}

void draw() {
  background(200);
  //to be added: collision!!!! wtf am i doing???
  checkCollision();
  playersManager();
  ballManager();
}

boolean left, top, bottom, right;
void checkCollision() {
  top = ball.y + ball.r >= player[0].y - player[0].h/2;
  right = ball.x - ball.r <= player[0].x + player[0].w/2;
  bottom = ball.y - ball.r <= player[0].y + player[0].h/2;
  if (top && right && bottom) {
    ball.reflect("x");
  }

  top = ball.y + ball.r >= player[1].y - player[1].h/2;
  left = ball.x + ball.r >= player[1].x - player[1].w/2;
  bottom = ball.y - ball.r <= player[1].y + player[1].h/2;
  if (top && left && bottom) {
    ball.reflect("x");
  }
  //ball.colliding = (top && right && bottom) || (top && left && bottom);
}

void playersManager() {
  player[0].move();
  player[1].move();
  player[0].render();
  player[1].render();
}

void ballManager() {
  ball.move();
  ball.render();
}

boolean colision() {
  return true;
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    //move up
    player[0].dir = -playerSpeed;
  }
  if (key == 's' || key == 'S') {
    //move down
    player[0].dir = playerSpeed;
  }
  if (keyCode == UP) {
    //move up
    player[1].dir = -playerSpeed;
  }
  if (keyCode == DOWN) {
    //move down
    player[1].dir = playerSpeed;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    player[0].dir = 0;
  }
  if (key == 's' || key == 'S') {
    player[0].dir = 0;
  }
  if (keyCode == UP) {
    player[1].dir = 0;
  }
  if (keyCode == DOWN) {
    player[1].dir = 0;
  }
}