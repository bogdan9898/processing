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
  int[] indexC;
  color culoare;

  PIECE (float x, float y, int type) {
    this.type = type;
    c = new PVector[4];
    genFormatie(x, y, type);
    indexC = new int[4];
    for (int i = 0; i < 4; i++) {
      indexC[i] = int(c[i].x/size);
    }
    culoare = color(random(255), random(255), random(255));
  }

  void genFormatie(float x, float y, int type) {
    switch(type) {
    case 0: //Cub = 0
      c[0] = new PVector(x, y);
      c[1] = new PVector(x+size, y);
      c[2] = new PVector(x+size, y+size);
      c[3] = new PVector(x, y+size);
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
      c[1] = new PVector(x, y+size);
      c[2] = new PVector(x-size, y+size);
      c[3] = new PVector(x+size, y+size);
      break;
    case 5: //S = 5
      c[0] = new PVector(x, y);
      c[1] = new PVector(x+size, y);
      c[2] = new PVector(x, y+size);
      c[3] = new PVector(x-size, y+size);
      break;
    case 6: //Z = 6
      c[0] = new PVector(x, y);
      c[1] = new PVector(x-size, y);
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
      indexC[i] = int(c[i].x/size);
    }
  }

  void moveLeft() {
    for (int i = 0; i < 4; i++) {
      c[i].x -= size;
      indexC[i] = int(c[i].x/size);
    }
  }

  boolean inBounds(int type, int dir) {
    if (dir == 1) //right
      switch(type) {
      case 0: //Cub = 0
        if (c[1].x < (width-offsetWidth)-size)
          return true;
        break;
      case 1: //I = 1
        if (c[3].x < (width-offsetWidth)-size)
          return true;
        break;
      case 2: //L = 2
        if (c[3].x < (width-offsetWidth)-size)
          return true;
        break;
      case 3: //J = 3
        if (c[0].x < (width-offsetWidth)-size)
          return true;
        break;
      case 4: //T = 4
        if (c[3].x < (width-offsetWidth)-size)
          return true;
        break;
      case 5: //S = 5
        if (c[1].x < (width-offsetWidth)-size)
          return true;
        break;
      case 6: //Z = 6
        if (c[3].x < (width-offsetWidth)-size)
          return true;
        break;
      } else if (dir == 0) //down
      switch(type) {
      case 0: //Cub = 0
        if (c[2].y < height - size)
          return true;
        break;
      case 1: //I = 1
        if (c[0].y < height - size)
          return true;
        break;
      case 2: //L = 2
        if (c[2].y < height - size)
          return true;
        break;
      case 3: //J = 3
        if (c[2].y < height - size)
          return true;
        break;
      case 4: //T = 4
        if (c[1].y < height - size)
          return true;
        break;
      case 5: //S = 5
        if (c[2].y < height - size)
          return true;
        break;
      case 6: //Z = 6
        if (c[2].y < height - size)
          return true;
        break;
      } else //dir = -1 //left
    switch(type) {
    case 0: //Cub = 0
      if (c[0].x > 0)
        return true;
      break;
    case 1: //I = 1
      if (c[0].x > 0)
        return true;
      break;
    case 2: //L = 2
      if (c[0].x > 0)
        return true;
      break;
    case 3: //J = 3
      if (c[3].x > 0)
        return true;
      break;
    case 4: //T = 4
      if (c[2].x > 0)
        return true;
      break;
    case 5: //S = 5
      if (c[3].x > 0)
        return true;
      break;
    case 6: //Z = 6
      if (c[1].x > 0)
        return true;
      break;
    }
    return false;
  }

  boolean inTouch() {

    for (int i = 0; i < 4; i++) {
      if (CollisionWithTable(c[i], indexC[i]) == true) {
        return true;
      }
    }
    return false;
  }

  boolean CollisionWithTable(PVector cTemp, int indexCTemp) {
    if (cTemp.y == table[indexCTemp][convertToIndex(cTemp.y)+1].y - size &&
      table[indexCTemp][convertToIndex(cTemp.y)+1].isFree == false) {
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

  void rotateCW() {
  }

  void update() {
    show();
  }

  void show() {
    fill(culoare);
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