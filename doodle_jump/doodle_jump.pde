CHARACTER c;
BLOCKS[] b;
final int bWidth = 45, bHeight = 15;
PImage character, bg;
boolean mirror, gameOver;

void setup() {
  size(530, 850);
  ellipseMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  c = new CHARACTER();
  b = new BLOCKS[10];
  for (int i = 0; i < b.length; i++)
    b[i] = new BLOCKS(random(0, width), i*100);
  character = loadImage("doodle.png");
  character.resize(55, 55);
  bg = loadImage("background.png");

  //noLoop();
  //frameRate(15);
}

void draw() {
  //background(125);
  image(bg, width/2, height/2);
  manageBlocks();
  manageCharacter();
}

void manageBlocks() {
  for (int i = 0; i < b.length; i++) {
    if (b[i].chkCollision(c.x, c.y, c.scale, c.speed))
      c.chFalling();
    if (b[i].y > height+bHeight)
      b[i].y = - 100;
    b[i].render();
  }
}

void manageCharacter() {
  if (gameOver) {
    fill(0, 100);
    rect(width/2, height/2, width, height);
    fill(255, 150, 0);
    textSize(width/12.5);
    text("Game Over\nPress any key to restart", width/2, height/2);
    gameOver = true;
  } else {
    c.moveX();
    if (c.y > height/2 || c.speed > 0) {
      c.moveY();
    } else {
      for (int i = 0; i < b.length; i++) {
        b[i].fall(c.speed);
      }
      c.updateSpeed();
    }
    c.edge();
    c.render();
    c.dead();
  }
}

void keyPressed() {
  if (gameOver) {
    c = new CHARACTER();
    for (int i = 0; i < b.length; i++)
      b[i] = new BLOCKS(random(0, width), i*100);
    gameOver = false;
  } else {
    if (keyCode == RIGHT) {
      c.dir = 5;
      mirror = true;
    }
    if (keyCode == LEFT) {
      c.dir = -5;
      mirror = false;
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    c.dir = 0;
  }
  if (keyCode == LEFT) {
    c.dir = 0;
  }
}