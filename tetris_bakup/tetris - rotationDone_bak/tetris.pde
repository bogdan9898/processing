TABLE[][] table;
PIECE piece;
PIECE nextPiece;

final int size = 50;
int w, h;
int offsetX;
int offsetY;

int offsetWidth;
boolean pause = false;

void setup() {
  size(1000, 800); 
  offsetWidth = 500;
  w = (width-offsetWidth)/size;
  h = height/size;
  offsetX = offsetWidth;
  offsetY = height/2-size;
  table = new TABLE[w][h];
  for (int i = 0; i < w; i++)
    for (int j = 0; j < h; j++) {
      color temp = color (random(255), random(255), random(255));
      table[i][j] = new TABLE(i * size, j * size, temp);
    }
  piece = new PIECE((width-offsetWidth)/2-size, 0, floor(random(7)));
  nextPiece = new PIECE((width-offsetWidth)/2-size, 0, floor(random(7)));
}

float difficulty = 30;

void draw() {
  //println(frameRate);
  if (!pause) {
    background(130);
    for (int i = 0; i < w; i++)
      for (int j = 0; j < h; j++) {
        table[i][j].update();
      }
    if (piece != null) {
      if (frameCount % round(difficulty) == 0) {
        gravitatie();
        difficulty -=0.005;
      }
      piece.update();
      nextPiece.showNext();
    }
  } else {
    pushMatrix();
    textSize(150);
    fill(0);
    text("Pauza", width/1.85, height/4);
    popMatrix();
  }
}

void gravitatie() {
  if (piece.inBounds(0) && piece.inTouch() == false) {
    for (int i = 0; i < 4; i++) {
      piece.c[i].y += size;
    }
  } else {
    for (int i = 0; i < 4; i++) {
      table[int(piece.c[i].x/size)][int(piece.c[i].y/size)].isFree = false;
      table[int(piece.c[i].x/size)][int(piece.c[i].y/size)].culoare = piece.culoare;
    }
    for (int j = h-1; j >= 0; j--) {
      if (tableCombo(j) == true) {
        println("COMBO");
        resetTable(j);
        j++;
      }
    }
    piece = nextPiece;
    nextPiece = new PIECE((width-offsetWidth)/2-size, 0, floor(random(7)));
  }
}

boolean tableCombo(int j) {
  for (int i = 0; i < w; i++)
    if (table[i][j].isFree == true)
      return false;
  return true;
}

void resetTable(int tempJ) { 
  for (int i = 0; i < w; i++)
    table[i][tempJ].isFree = true;
  for (int i = 0; i < w; i++)
    table[i][tempJ-1].dropDown(i, tempJ-1);
}

void keyPressed() {
  if (!pause) {
    switch(keyCode) {
    case UP-ARROW:
      piece.rotateCW(piece.type);
      break;
    case DOWN-ARROW:
      println();
      if (piece != null && piece.inBounds(0))
        if (piece.inTouch() == false)
          piece.accel();
      break;
    case RIGHT-ARROW:
      if (piece != null && piece.inBounds(1))
        if (piece.sidesClear(1) == true)
          piece.moveRight();
      break;
    case LEFT-ARROW:
      if (piece != null && piece.inBounds(-1))
        if (piece.sidesClear(-1) == true)
          piece.moveLeft();
      break;
    }

    switch(key) {
    case 'c':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 0);
      break;
    case 'i':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 1);
      break;
    case 'l':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 2);
      break;
    case 'j':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 3);
      break;
    case 't':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 4);
      break;
    case 's':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 5);
      break;
    case 'z':
      piece = new PIECE((width-offsetWidth)/2 - size, 0, 6);
      break;
    }
  }
  if (key == 'p')
    pause = !pause;
}