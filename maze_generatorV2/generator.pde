class GENERATOR {
  float x;
  float y;
  int i;
  int j;
  ArrayList<PVector> path;

  GENERATOR(int i, int j) {
    this.x = g[i][j].x;
    this.y = g[i][j].y;
    this.i = i;
    this.j = j;
    path = new ArrayList<PVector>();
  }

  void move() {
    setMaze(i, j);
    //searchDrum(i, j);
    if (searchDrum(i, j)) {
      path.add(new PVector(i, j));
      int dir = floor(random(4));
      switch (dir) {
      case 0: //SUS
        if (j > 0 && g[i][j-1].isSet == false) {
          delWalls(i, j, dir);
          j -= 1;
          y = g[i][j].y;
        } else move();
        break;
      case 1: //DREAPTA
        if (i < r-1 && g[i+1][j].isSet == false) {
          delWalls(i, j, dir);
          i += 1;
          x = g[i][j].x;
        } else move();
        break;
      case 2: //JOS
        if (j < c-1 && g[i][j+1].isSet == false) {
          delWalls(i, j, dir);
          j += 1;
          y = g[i][j].y;
        } else move();
        break;
      case 3: //STANGA
        if (i > 0 && g[i-1][j].isSet == false) {
          delWalls(i, j, dir);
          i -= 1;
          x = g[i][j].x;
        } else move();
        break;
      }
    } else {
      //println("reverse");
      if (path.size() >= 1) {
        PVector aux = path.get(path.size()-1);
        i = int(aux.x);
        j = int(aux.y);
        x = g[i][j].x;
        y = g[i][j].y;
        path.remove(path.size()-1);
      } else {
        //for (int i = 0; i < r; i++)
        //  for (int j = 0; j < c; j++)
        //    g[i][j].showFinalGrid();
        noLoop(); 
        println("end");
      }
    }
  }

  boolean searchDrum(int i, int j) { 

    if (i == 0 || j == 0 || i == r-1 || j == c-1) { //cazuri speciale


      if (i == 0 || j ==0) { //marginile inferioare

        if (i == 0 && j == 0)
          if (g[i+1][j].isSet == false ||
            g[i][j+1].isSet == false)
            return true;
          else return false;

        if (i == 0 && j != 0 && j != c-1) {
          if (g[i][j-1].isSet == false ||
            g[i+1][j].isSet == false ||
            g[i][j+1].isSet == false)
            return true;
          else return false;
        }

        if (i != 0  && i != r-1 && j ==0) {
          if (g[i+1][j].isSet == false ||
            g[i][j+1].isSet == false ||
            g[i-1][j].isSet == false)
            return true;
          else return false;
        }
      } else { //marginile superioare

        if (i == r-1 && j == c-1) {
          if (g[i][j-1].isSet == false ||
            g[i-1][j].isSet == false)
            return true;
          else return false;
        }

        if (i == r-1 && j != c-1) {
          if (g[i][j-1].isSet == false ||
            g[i][j+1].isSet == false ||
            g[i-1][j].isSet == false)
            return true;
          else return false;
        }

        if (i != r-1 && j == c-1) {
          if (i != r-1 && j == c-1 && i > 0) {
            if (g[i][j-1].isSet == false ||
              g[i+1][j].isSet == false ||
              g[i-1][j].isSet == false)
              return true;
            else return false;
          }
        }
      }
    } else { //cazuri generale
      if (g[i][j-1].isSet == false ||
        g[i+1][j].isSet == false ||
        g[i][j+1].isSet == false ||
        g[i-1][j].isSet == false)
        return true;
      else return false;
    }
    return false;
  }

  void delWalls(int i, int j, int dir) {
    switch (dir) {
    case 0: //SUS
      g[i][j].walls[0] = false;
      g[i][j-1].walls[2] = false;
      break;
    case 1: //DREAPTA
      g[i][j].walls[1] = false;
      g[i+1][j].walls[3] = false;
      break;
    case 2: //JOS
      g[i][j].walls[2] = false;
      g[i][j+1].walls[0] = false;
      break;
    case 3: //STANGA
      g[i][j].walls[3] = false;
      g[i-1][j].walls[1] = false;
      break;
    }
  }

  void setMaze(int i, int j) {
    g[i][j].isSet = true;
  }

  void show() {
    noStroke();
    fill(64, 224, 208);
    rect(x, y, cellW, cellH);
  }
}