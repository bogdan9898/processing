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
  color culoare;

  PIECE (float x, float y, int type) {
    this.type = type;
    c = new PVector[4];
    genFormatie(x, y, type);
    for (int i = 0; i < 4; i++) {
    }
    culoare = color(random(255), random(255), random(255));
  }

  void genFormatie(float x, float y, int type) {
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

  void accel() {
    for (int i = 0; i < 4; i++)
      c[i].y += size;
  }

  void moveRight() {
    for (int i = 0; i < 4; i++) {
      c[i].x += size;
    }
  }

  void moveLeft() {
    for (int i = 0; i < 4; i++) {
      c[i].x -= size;
    }
  }

  boolean inBounds(int dir) {
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

  boolean inTouch() {

    for (int i = 0; i < 4; i++) {
      if (CollisionWithTable(c[i]) == true) {
        return true;
      }
    }
    return false;
  }

  boolean CollisionWithTable(PVector cTemp) {
    if (cTemp.y == table[convertToIndex(cTemp.x)][convertToIndex(cTemp.y)+1].y - size &&
      table[convertToIndex(cTemp.x)][convertToIndex(cTemp.y)+1].isFree == false) {
      return true;
    }
    return false;
  }

  boolean sidesClear(int side) {
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

  boolean isRightClear(PVector cTemp) {
    if (cTemp.x == table[convertToIndex(cTemp.x)+1][convertToIndex(cTemp.y)].x - size &&
      table[convertToIndex(cTemp.x)+1][convertToIndex(cTemp.y)].isFree == false)
      return false;
    return true;
  }

  boolean isLeftClear(PVector cTemp) {
    if (cTemp.x == table[convertToIndex(cTemp.x)-1][convertToIndex(cTemp.y)].x + size &&
      table[convertToIndex(cTemp.x)-1][convertToIndex(cTemp.y)].isFree == false)
      return false;
    return true;
  }

  int convertToIndex(float temp) {
    return int(temp/size);
  }

  void rotateCW(int type) {
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

  boolean validRotation(int type, int orientare) {
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

  boolean tableIsClear(int type, int orientare) {
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

  void update() {
    show(culoare);
  }

  void show(color culoare) {
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

  void showNext() {
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