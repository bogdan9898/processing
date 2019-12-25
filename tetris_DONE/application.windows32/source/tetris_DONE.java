import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tetris_DONE extends PApplet {

TABLE[][] table;
PIECE piece;
PIECE nextPiece;

final int size = 50;
int w, h;
int offsetX;
int offsetY;

int offsetWidth;
boolean pause = false;

public void setup() {
   
  offsetWidth = 500;
  w = (width-offsetWidth)/size;
  h = height/size;
  offsetX = offsetWidth;
  offsetY = height/2-size;
  table = new TABLE[w][h];
  for (int i = 0; i < w; i++)
    for (int j = 0; j < h; j++) {
      int temp = color (random(255), random(255), random(255));
      table[i][j] = new TABLE(i * size, j * size, temp);
    }
  piece = new PIECE((width-offsetWidth)/2-size, 0, floor(random(7)));
  nextPiece = new PIECE((width-offsetWidth)/2-size, 0, floor(random(7)));
}

float difficulty = 30;

public void draw() {
  //println(frameRate);
  if (!pause) {
    background(130);
    for (int i = 0; i < w; i++)
      for (int j = 0; j < h; j++) {
        table[i][j].update();
      }
    if (piece != null) {
      if (frameCount % PApplet.parseInt(difficulty) == 0) {
        gravitatie();
        //difficulty -=0.001;
      }
      piece.update();
      nextPiece.showNext();
    }
  } else {
    pushMatrix();
    textSize(150);
    fill(0);
    text("Pauza", width/1.85f, height/4);
    popMatrix();
  }
}

public void gravitatie() {
  if (piece.inBounds(0) && piece.inTouch() == false) {
    for (int i = 0; i < 4; i++) {
      piece.c[i].y += size;
    }
  } else {
    for (int i = 0; i < 4; i++) {
      table[PApplet.parseInt(piece.c[i].x/size)][PApplet.parseInt(piece.c[i].y/size)].isFree = false;
      table[PApplet.parseInt(piece.c[i].x/size)][PApplet.parseInt(piece.c[i].y/size)].culoare = piece.culoare;
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
    if (table[PApplet.parseInt(piece.c[0].x/size)][PApplet.parseInt(piece.c[0].y/size)].isFree == false||
      table[PApplet.parseInt(piece.c[1].x/size)][PApplet.parseInt(piece.c[1].y/size)].isFree == false||
      table[PApplet.parseInt(piece.c[2].x/size)][PApplet.parseInt(piece.c[2].y/size)].isFree == false||
      table[PApplet.parseInt(piece.c[3].x/size)][PApplet.parseInt(piece.c[3].y/size)].isFree == false) {
      println("Game Over");
      noLoop();
    }
  }
}

public boolean tableCombo(int j) {
  for (int i = 0; i < w; i++)
    if (table[i][j].isFree == true)
      return false;
  return true;
}

public void resetTable(int tempJ) { 
  for (int i = 0; i < w; i++)
    table[i][tempJ].isFree = true;
  for (int i = 0; i < w; i++)
    table[i][tempJ-1].dropDown(i, tempJ-1);
}

public void keyPressed() {
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
class PIECE {
  int type; 
  /* Cub = 0
   I = 1
   L = 2
   J = 3
   T = 4
   S = 5
   Z = 6 */
  PVector[] c;
  int culoare;

  PIECE (float x, float y, int type) {
    this.type = type;
    c = new PVector[4];
    genFormatie(x, y, type);
    for (int i = 0; i < 4; i++) {
    }
    culoare = color(random(255), random(255), random(255));
  }

  public void genFormatie(float x, float y, int type) {
    switch(type) {
    case 0: //Cub = 0
      c[0] = new PVector(x, y);
      c[1] = new PVector(x+size, y);
      c[2] = new PVector(x, y+size);
      c[3] = new PVector(x+size, y+size);
      break;
    case 1: //I = 1
      c[0] = new PVector(x, y);
      c[1] = new PVector(x+size, y);
      c[2] = new PVector(x+2*size, y);
      c[3] = new PVector(x+3*size, y);  
      break;
    case 2: //L = 2
      c[0] = new PVector(x, y);
      c[1] = new PVector(x, y+size);
      c[2] = new PVector(x, y+2*size);
      c[3] = new PVector(x+size, y+2*size);
      break;
    case 3: //J = 3
      c[0] = new PVector(x, y);
      c[1] = new PVector(x, y+size);
      c[2] = new PVector(x, y+2*size);
      c[3] = new PVector(x-size, y+2*size);
      break;
    case 4: //T = 4
      c[0] = new PVector(x, y);
      c[1] = new PVector(x-size, y+size);
      c[2] = new PVector(x, y+size);
      c[3] = new PVector(x+size, y+size);
      break;
    case 5: //S = 5
      c[0] = new PVector(x, y+size);
      c[1] = new PVector(x+size, y+size);
      c[2] = new PVector(x+size, y);
      c[3] = new PVector(x+2*size, y);
      break;
    case 6: //Z = 6
      c[0] = new PVector(x-size, y);
      c[1] = new PVector(x, y);
      c[2] = new PVector(x, y+size);
      c[3] = new PVector(x+size, y+size);
      break;
    }
  }

  public void accel() {
    for (int i = 0; i < 4; i++)
      c[i].y += size;
  }

  public void moveRight() {
    for (int i = 0; i < 4; i++) {
      c[i].x += size;
    }
  }

  public void moveLeft() {
    for (int i = 0; i < 4; i++) {
      c[i].x -= size;
    }
  }

  public boolean inBounds(int dir) {
    if (dir == 1) //right
      for (int i = 0; i < 4; i++) {
        if (c[i].x == (width-offsetWidth)-size) {
          return false;
        }
      } else if (dir == 0) //down
      for (int i = 0; i < 4; i++) {
        if (c[i].y == height - size) {
          return false;
        }
      } else //dir = -1 //left
    for (int i = 0; i < 4; i++) {
      if (c[i].x == 0) {
        return false;
      }
    }
    return true;
  }

  public boolean inTouch() {

    for (int i = 0; i < 4; i++) {
      if (CollisionWithTable(c[i]) == true) {
        return true;
      }
    }
    return false;
  }

  public boolean CollisionWithTable(PVector cTemp) {
    if (cTemp.y == table[convertToIndex(cTemp.x)][convertToIndex(cTemp.y)+1].y - size &&
      table[convertToIndex(cTemp.x)][convertToIndex(cTemp.y)+1].isFree == false) {
      return true;
    }
    return false;
  }

  public boolean sidesClear(int side) {
    switch (side) {
    case 1:
      for (int i = 0; i < 4; i++) 
        if (isRightClear(c[i]) == false)
          return false;
      break;
    case -1:
      for (int i = 0; i < 4; i++) 
        if (isLeftClear(c[i]) == false)
          return false;
      break;
    }
    return true;
  }

  public boolean isRightClear(PVector cTemp) {
    if (cTemp.x == table[convertToIndex(cTemp.x)+1][convertToIndex(cTemp.y)].x - size &&
      table[convertToIndex(cTemp.x)+1][convertToIndex(cTemp.y)].isFree == false)
      return false;
    return true;
  }

  public boolean isLeftClear(PVector cTemp) {
    if (cTemp.x == table[convertToIndex(cTemp.x)-1][convertToIndex(cTemp.y)].x + size &&
      table[convertToIndex(cTemp.x)-1][convertToIndex(cTemp.y)].isFree == false)
      return false;
    return true;
  }

  public int convertToIndex(float temp) {
    return PApplet.parseInt(temp/size);
  }

  public void rotateCW(int type) {
    switch(type) {
    case 0: //Cub = 0
      println("can't rotate the cube");
      break;
    case 1: //I = 1
      if (c[0].x == c[3].x) { //I vertical
        if (validRotation(type, 1)) {
          if (tableIsClear(type, 1)) {
            //println("din vertical in orizontal");
            c[0].x = c[3].x-size;
            c[0].y = c[3].y;

            c[1].x = c[0].x+size;
            c[1].y = c[0].y;

            c[2].x = c[1].x+size;
            c[2].y = c[1].y;

            c[3].x = c[2].x+size;
            c[3].y = c[2].y;
          }
        }
      } else if (c[0].y == c[3].y) { //I orizontal
        if (validRotation(type, 0)) {
          if (tableIsClear(type, 0)) {
            //println("din orizontal in vertical");
            c[0].x = c[1].x;
            c[0].y = c[1].y-3*size;

            c[1].x = c[0].x;
            c[1].y = c[0].y+size;

            c[2].x = c[1].x;
            c[2].y = c[1].y+size;

            c[3].x = c[2].x;
            c[3].y = c[2].y+size;
          }
        }
      }
      break;

    case 2: //L = 2
      if (c[0].x < c[3].x && c[0].y < c[3].y) { //L spre dreapta
        if (validRotation(type, 0)) {
          if (tableIsClear(type, 0)) {
            //println("din dreapta in jos");
            c[3].x = c[1].x;
            c[3].y = c[1].y;

            c[2].x = c[3].x;
            c[2].y = c[3].y-size;

            c[1].x = c[2].x+size;
            c[1].y = c[2].y;

            c[0].x = c[1].x+size;
            c[0].y = c[1].y;
          }
        }
      } else if (c[0].x > c[3].x && c[0].y < c[3].y) { //L in jos
        if (validRotation(type, 1)) {
          if (tableIsClear(type, 1)) {
            //println("de jos in stanga");
            c[3].x = c[1].x;
            c[3].y = c[1].y;

            c[2].x = c[3].x+size;
            c[2].y = c[3].y;

            c[1].x = c[2].x;
            c[1].y = c[2].y+size;

            c[0].x = c[1].x;
            c[0].y = c[1].y+size;
          }
        }
      } else if (c[0].x > c[3].x && c[0].y > c[3].y) { //L spre stanga
        if (validRotation(type, 2)) {
          if (tableIsClear(type, 2)) {
            //println("din stanga in sus");
            c[3].x = c[1].x;
            c[3].y = c[1].y;

            c[2].x = c[3].x;
            c[2].y = c[3].y+size;

            c[1].x = c[2].x-size;
            c[1].y = c[2].y;

            c[0].x = c[1].x-size;
            c[0].y = c[1].y;
          }
        }
      } else if (c[0].x < c[3].x && c[0].y > c[3].y) { //L in sus
        if (validRotation(type, 3)) {
          if (tableIsClear(type, 3)) {
            //println("de sus in dreapta");
            c[3].x = c[1].x;
            c[3].y = c[1].y;

            c[2].x = c[3].x-size;
            c[2].y = c[3].y;

            c[1].x = c[2].x;
            c[1].y = c[2].y-size;

            c[0].x = c[1].x;
            c[0].y = c[1].y-size;
          }
        }
      }
      break;

    case 3: //J = 3
      if (c[0].x > c[3].x && c[0].y < c[3].y) { //J spre stanga
        if (validRotation(type, 0)) {
          if (tableIsClear(type, 0)) {
            //println("din stanga in sus");
            c[0].x = c[2].x;
            c[0].y = c[2].y;

            c[1].x = c[0].x-size;
            c[1].y = c[0].y;

            c[2].x = c[1].x-size;
            c[2].y = c[1].y;

            c[3].x = c[2].x;
            c[3].y = c[2].y-size;
          }
        }
      } else if (c[0].x > c[3].x && c[0].y > c[3].y) { //J in sus
        if (validRotation(type, 1)) {
          if (tableIsClear(type, 1)) {
            //println("de sus in dreapta");
            c[0].x = c[2].x;
            c[0].y = c[2].y;

            c[1].x = c[0].x;
            c[1].y = c[0].y-size;

            c[2].x = c[1].x;
            c[2].y = c[1].y-size;

            c[3].x = c[2].x+size;
            c[3].y = c[2].y;
          }
        }
      } else if (c[0].x < c[3].x && c[0].y > c[3].y) { //J spre dreapta
        if (validRotation(type, 2)) {
          if (tableIsClear(type, 2)) {
            //println("din dreapta in jos");
            c[0].x = c[2].x;
            c[0].y = c[2].y;

            c[1].x = c[0].x+size;
            c[1].y = c[0].y;

            c[2].x = c[1].x+size;
            c[2].y = c[1].y;

            c[3].x = c[2].x;
            c[3].y = c[2].y+size;
          }
        }
      } else if (c[0].x < c[3].x && c[0].y < c[3].y) { //J in jos
        if (validRotation(type, 3)) {
          if (tableIsClear(type, 3)) {
            //println("de jos in stanga");
            c[0].x = c[2].x;
            c[0].y = c[2].y;

            c[1].x = c[0].x;
            c[1].y = c[0].y+size;

            c[2].x = c[1].x;
            c[2].y = c[1].y+size;

            c[3].x = c[2].x-size;
            c[3].y = c[2].y;
          }
        }
      }
      break;

    case 4: //T = 4
      if (c[0].x == c[2].x && c[0].y < c[2].y) { //T in sus
        if (validRotation(type, 0)) {
          if (tableIsClear(type, 0)) {
            //println("de sus in dreapta");
            //c[0].x = c[0].x;
            //c[0].y = c[0].y;

            c[2].x = c[0].x-size;
            c[2].y = c[0].y;

            c[1].x = c[2].x;
            c[1].y = c[2].y-size;

            c[3].x = c[2].x;
            c[3].y = c[2].y+size;
          }
        }
      } else if (c[0].x > c[2].x && c[0].y == c[2].y) { //T spre dreapta
        if (validRotation(type, 1)) {
          if (tableIsClear(type, 1)) {
            //println("din dreapta in jos");
            //c[0].x = c[0].x;
            //c[0].y = c[0].y;

            c[2].x = c[0].x;
            c[2].y = c[0].y-size;

            c[1].x = c[2].x+size;
            c[1].y = c[2].y;

            c[3].x = c[2].x-size;
            c[3].y = c[2].y;
          }
        }
      } else if (c[0].x == c[2].x && c[0].y > c[2].y) { //T in jos
        if (validRotation(type, 2)) {
          if (tableIsClear(type, 2)) {
            //println("de jos in stanga");
            //c[0].x = c[0].x;
            //c[0].y = c[0].y;

            c[2].x = c[0].x+size;
            c[2].y = c[0].y;

            c[1].x = c[2].x;
            c[1].y = c[2].y-size;

            c[3].x = c[2].x;
            c[3].y = c[2].y+size;
          }
        }
      } else if (c[0].x < c[2].x && c[0].y == c[2].y) { //T spre stanga
        if (validRotation(type, 3)) {
          if (tableIsClear(type, 3)) {
            //println("din stanga in sus");
            //c[0].x = c[0].x;
            //c[0].y = c[0].y;

            c[2].x = c[0].x;
            c[2].y = c[0].y+size;

            c[1].x = c[2].x-size;
            c[1].y = c[2].y;

            c[3].x = c[2].x+size;
            c[3].y = c[2].y;
          }
        }
      }
      break;

    case 5: //S = 5
      if (c[1].x == c[2].x) { //S orizontal
        if (validRotation(type, 0)) {
          if (tableIsClear(type, 0)) {
            //println("din orizontal in vertical");
            c[0].x = c[2].x;
            c[0].y = c[2].y;

            //c[1].x = c[1].x;
            //c[1].y = c[1].y;

            c[2].x = c[1].x+size;
            c[2].y = c[1].y;

            c[3].x = c[2].x;
            c[3].y = c[2].y+size;
          }
        }
      } else if (c[1].y == c[2].y) { //S vertical
        if (validRotation(type, 1)) {
          if (tableIsClear(type, 1)) {
            //println("din vertical in orizontal");
            c[0].x = c[1].x-size;
            c[0].y = c[1].y;

            //c[1].x = c[1].x;
            //c[1].y = c[1].y;

            c[2].x = c[1].x;
            c[2].y = c[1].y-size;

            c[3].x = c[2].x+size;
            c[3].y = c[2].y;
          }
        }
      }
      break;

    case 6: //Z = 6
      if (c[1].x == c[2].x) { //Z orizontal
        if (validRotation(type, 0)) {
          if (tableIsClear(type, 0)) {
            //println("din orizontal in vertical");
            c[0].x = c[1].x;
            c[0].y = c[1].y;

            c[1].x = c[2].x;
            c[1].y = c[2].y;

            c[2].x = c[1].x-size;
            c[2].y = c[1].y;

            c[3].x = c[2].x;
            c[3].y = c[2].y+size;
          }
        }
      } else if (c[1].y == c[2].y) { //Z vertical
        if (validRotation(type, 1)) {
          if (tableIsClear(type, 1)) {
            //println("din vertical in orizontal");
            c[0].x = c[0].x-size;
            c[0].y = c[0].y;

            c[1].x = c[0].x+size;
            c[1].y = c[0].y;

            c[2].x = c[1].x;
            c[2].y = c[1].y+size;

            c[3].x = c[2].x+size;
            c[3].y = c[2].y;
          }
        }
      }
      break;
    }
  }

  public boolean validRotation(int type, int orientare) {
    switch(type) {
    case 0: //Cub = 0
      println("rotatie fara sens");
      break;

    case 1: //I = 1
      if (orientare == 0) { //I orizontal
        if (c[1].y-3*size < 0)
          return false;
      } else if (orientare == 1) { //I vertical
        if (c[3].x-size < 0 || c[3].x+2*size > width-offsetWidth-size)
          return false;
      }
      break;

    case 2: //L = 2
      if (orientare == 0) { //J spre dreapta
        if (c[3].x+size == width-offsetWidth)
          return false;
      } else if (orientare == 1) { //J spre jos
        if (c[3].y+size == height)
          return false;
      } else if (orientare == 2) { //J in stanga
        if (c[3].x == 0)
          return false;
      } else if (orientare == 3) { //J in sus
        return true;
      }
      break;

    case 3: //J = 3
      if (orientare == 0) { //J spre stanga
        if (c[3].x == 0)
          return false;
      } else if (orientare == 1) { //J in sus
        return true;
      } else if (orientare == 2) { //J spre dreapta
        if (c[3].x+size == width-offsetWidth)
          return false;
      } else if (orientare == 3) { //J in jos
        if (c[3].y+size == height)
          return false;
      }
      break;

    case 4: //T = 4
      if (orientare == 0) { //T in sus
        return true;
      } else if (orientare == 1) { //T spre dreapta
        if (c[0].x+size == width-offsetWidth)
          return false;
      } else if (orientare == 2) { //T spre jos
        if (c[0].y+size == height)
          return false;
      } else if (orientare == 3) { //T in stanga
        if (c[0].x == 0)
          return false;
      }
      break;

    case 5: //S = 5
      if (orientare == 0) { //I orizontal
        if (c[1].y+size == height)
          return false;
      } else if (orientare == 1) { //I vertical
        if (c[1].x == 0)
          return false;
      }
      break;

    case 6: //Z = 6
      if (orientare == 0) { //I orizontal
        if (c[1].y+2*size == height)
          return false;
      } else if (orientare == 1) { //I vertical
        if (c[1].x+size == width-offsetWidth)
          return false;
      }
      break;
    }
    return true;
  }

  public boolean tableIsClear(int type, int orientare) {
    switch(type) {
    case 0: //Cub = 0
      println("rotatie fara sens");
      break;

    case 1: //I = 1
      if (orientare == 0) { //I orizontal

        if (table[convertToIndex(c[1].x)][convertToIndex(c[1].y-3*size)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y-2*size)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y-size)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false)
          return false;
      } else if (orientare == 1) { //I vertical

        if (table[convertToIndex(c[3].x-size)][convertToIndex(c[3].y)].isFree == false ||
          table[convertToIndex(c[3].x)][convertToIndex(c[3].y)].isFree == false ||
          table[convertToIndex(c[3].x+size)][convertToIndex(c[3].y)].isFree == false ||
          table[convertToIndex(c[3].x+2*size)][convertToIndex(c[3].y)].isFree == false)
          return false;
      }
      break;

    case 2: //L = 2
      if (orientare == 0) { //L spre dreapta

        if (table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y-size)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y-size)].isFree == false ||
          table[convertToIndex(c[1].x+2*size)][convertToIndex(c[1].y-size)].isFree == false)
          return false;
      } else if (orientare == 1) { //L spre jos

        if (table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y+size)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y+2*size)].isFree == false)
          return false;
      } else if (orientare == 2) { //L in stanga

        if (table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y+size)].isFree == false ||
          table[convertToIndex(c[1].x-size)][convertToIndex(c[1].y+size)].isFree == false ||
          table[convertToIndex(c[1].x-2*size)][convertToIndex(c[1].y+size)].isFree == false)
          return false;
      } else if (orientare == 3) { //L in sus

        if (table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x-size)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x-size)][convertToIndex(c[1].y-size)].isFree == false ||
          table[convertToIndex(c[1].x-size)][convertToIndex(c[1].y-2*size)].isFree == false)
          return false;
      }
      break;

    case 3: //J = 3
      if (orientare == 0) { //J spre stanga

        if (table[convertToIndex(c[2].x)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x-size)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x-2*size)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x-2*size)][convertToIndex(c[2].y-size)].isFree == false)
          return false;
      } else if (orientare == 1) { //J in sus

        if (table[convertToIndex(c[2].x)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x)][convertToIndex(c[2].y-size)].isFree == false ||
          table[convertToIndex(c[2].x)][convertToIndex(c[2].y-2*size)].isFree == false ||
          table[convertToIndex(c[2].x+size)][convertToIndex(c[2].y-2*size)].isFree == false)
          return false;
      } else if (orientare == 2) { //J spre dreapta

        if (table[convertToIndex(c[2].x)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x+size)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x+2*size)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x+2*size)][convertToIndex(c[2].y+size)].isFree == false)
          return false;
      } else if (orientare == 3) { //J in jos

        if (table[convertToIndex(c[2].x)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x)][convertToIndex(c[2].y+size)].isFree == false ||
          table[convertToIndex(c[2].x)][convertToIndex(c[2].y+2*size)].isFree == false ||
          table[convertToIndex(c[2].x-size)][convertToIndex(c[2].y+2*size)].isFree == false)
          return false;
      }
      break;

    case 4: //T = 4
      if (orientare == 0) { //T in sus

        if (table[convertToIndex(c[0].x)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x-size)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x-size)][convertToIndex(c[0].y-size)].isFree == false ||
          table[convertToIndex(c[0].x-size)][convertToIndex(c[0].y+size)].isFree == false)
          return false;
      } else if (orientare == 1) { //T spre dreapta

        if (table[convertToIndex(c[0].x)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x)][convertToIndex(c[0].y-size)].isFree == false ||
          table[convertToIndex(c[0].x+size)][convertToIndex(c[0].y-size)].isFree == false ||
          table[convertToIndex(c[0].x-size)][convertToIndex(c[0].y-size)].isFree == false)
          return false;
      } else if (orientare == 2) { //T spre jos

        if (table[convertToIndex(c[0].x)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x+size)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x+size)][convertToIndex(c[0].y-size)].isFree == false ||
          table[convertToIndex(c[0].x+size)][convertToIndex(c[0].y+size)].isFree == false)
          return false;
      } else if (orientare == 3) { //T in stanga

        if (table[convertToIndex(c[0].x)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x)][convertToIndex(c[0].y+size)].isFree == false ||
          table[convertToIndex(c[0].x-size)][convertToIndex(c[0].y+size)].isFree == false ||
          table[convertToIndex(c[0].x+size)][convertToIndex(c[0].y+size)].isFree == false)
          return false;
      }
      break;

    case 5: //S = 5
      if (orientare == 0) { //S orizontal

        if (table[convertToIndex(c[2].x)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y+size)].isFree == false)
          return false;
      } else if (orientare == 1) { //S vertical

        if (table[convertToIndex(c[1].x-size)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[1].x)][convertToIndex(c[1].y-size)].isFree == false ||
          table[convertToIndex(c[1].x+size)][convertToIndex(c[1].y-size)].isFree == false)
          return false;
      }
      break;

    case 6: //Z = 6
      if (orientare == 0) { //Z orizontal

        if (table[convertToIndex(c[1].x)][convertToIndex(c[1].y)].isFree == false ||
          table[convertToIndex(c[2].x)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x-size)][convertToIndex(c[2].y)].isFree == false ||
          table[convertToIndex(c[2].x-size)][convertToIndex(c[2].y+size)].isFree == false)
          return false;
      } else if (orientare == 1) { //Z vertical

        if (table[convertToIndex(c[0].x-size)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x)][convertToIndex(c[0].y)].isFree == false ||
          table[convertToIndex(c[0].x)][convertToIndex(c[0].y+size)].isFree == false ||
          table[convertToIndex(c[0].x+size)][convertToIndex(c[0].y+size)].isFree == false)
          return false;
      }
      break;
    }
    return true;
  }

  public void update() {
    show(culoare);
  }

  public void show(int culoare) {
    fill(culoare);
    //fill(0);
    stroke(0);
    rect(c[0].x, c[0].y, size, size);
    //fill(100);
    rect(c[1].x, c[1].y, size, size);
    //fill(200);
    rect(c[2].x, c[2].y, size, size);
    //fill(250);
    rect(c[3].x, c[3].y, size, size);
  }

  public void showNext() {
    fill(culoare);
    stroke(0);
    rect(c[0].x+offsetX, c[0].y+offsetY, size, size);
    //fill(100);
    rect(c[1].x+offsetX, c[1].y+offsetY, size, size);
    //fill(200);
    rect(c[2].x+offsetX, c[2].y+offsetY, size, size);
    //fill(250);
    rect(c[3].x+offsetX, c[3].y+offsetY, size, size);
  }
}
class TABLE {
  float x;
  float y;
  boolean isFree;
  int culoare;

  TABLE(float x, float y, int culoare) {
    this.x = x;
    this.y = y;
    this.isFree = true;
    this.culoare = culoare;
  }

  public void dropDown(int tempI, int tempJ) { //println("start dropDown", tempI, tempJ);
    for (int j = tempJ; j >= 0; j--) {
      if (table[tempI][j+1].isFree == true && table[tempI][j].isFree == false) {
        table[tempI][j+1].isFree = false;
        table[tempI][j+1].culoare = table[tempI][j].culoare;
        table[tempI][j].isFree = true; //println("droped", tempI,j);
      }
    }
  }

  public void update() {
    show(culoare);
  }

  public void show (int culoare) {
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
  public void settings() {  size(1000, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tetris_DONE" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
