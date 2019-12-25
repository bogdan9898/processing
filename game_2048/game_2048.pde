int scale;
GRID[][] grid;
//int[] list = {0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024};
IntDict d;
int locked = 0;
boolean gameOver = false;
float c = 0;

void setup() {
  size(400, 400);
  colorMode(HSB);
  scale = width/4; //scale = height/4
  grid = new GRID[4][4];
  newGame();
  d = new IntDict();
  setDict();
}

void draw() {
  if (locked == 16) {
    c += 1;
    fill(c%255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("GAME OVER\nPress any key to restart", width/2, height/2);
    gameOver = true;
  } else {
    for (int i = 0; i < 4; i++)
      for (int j = 0; j < 4; j++) {
        grid[i][j].show();
      }
  }
}

void keyPressed() {
  if (gameOver == false) {
    if (keyCode == UP) {
      up();
    } else if (keyCode == RIGHT) {
      right();
    } else if (keyCode == DOWN) {
      down();
    } else if (keyCode == LEFT) {
      left();
    } else if (key == 'r') {
      newGame();
    }
  } else {
    newGame();
  }
}

void spawn(int n) {
  while (n != 0) {
    int i = floor(random(4));
    int j = floor(random(4));
    if (grid[i][j].value == 0) {
      grid[i][j].value = 2;
      locked++;
      n--;
    }
  }
}

void up() {
  boolean spawn = false;
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      for (int z = j+1; z <= 3; z++) {
        if (grid[i][z].value != 0) {
          if (grid[i][j].value == grid[i][z].value && grid[i][j].value != 2048) {
            grid[i][j].value *= 2;
            grid[i][z].value = 0;
            locked--;
          }
          break;
        }
      }
    }
  }
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      if (grid[i][j].value == 0) {
        for (int z = j+1; z <= 3; z++) {
          if (grid[i][z].value != 0) {
            grid[i][j].value = grid[i][z].value;
            grid[i][z].value = 0;
            spawn = true;
            break;
          }
        }
      }
    }
  }
  if (spawn)
    spawn(1);
}


void right() {
  boolean spawn = false;
  for (int j = 0; j < 4; j++) {
    for (int i = 3; i > 0; i--) {
      for (int z = i-1; z >= 0; z--) {
        if (grid[z][j].value != 0) {
          if (grid[i][j].value == grid[z][j].value && grid[i][j].value != 2048) {
            grid[i][j].value *= 2;
            grid[z][j].value = 0;
            locked--;
          }
          break;
        }
      }
    }
  }
  for (int j = 0; j < 4; j++) {
    for (int i = 3; i > 0; i--) {
      if (grid[i][j].value == 0) {
        for (int z = i-1; z >= 0; z--) {
          if (grid[z][j].value != 0) {
            grid[i][j].value = grid[z][j].value;
            grid[z][j].value = 0;
            spawn = true;
            break;
          }
        }
      }
    }
  }
  if (spawn)
    spawn(1);
}


void down() {
  boolean spawn = false;
  for (int i = 0; i < 4; i++) {
    for (int j = 3; j > 0; j--) {
      for (int z = j-1; z >= 0; z--) {
        if (grid[i][z].value != 0) {
          if (grid[i][j].value == grid[i][z].value && grid[i][j].value != 2048) {
            grid[i][j].value *= 2;
            grid[i][z].value = 0;
            locked--;
          }
          break;
        }
      }
    }
  }
  for (int i = 0; i < 4; i++) {
    for (int j = 3; j > 0; j--) {
      if (grid[i][j].value == 0) {
        for (int z = j-1; z >= 0; z--) {
          if (grid[i][z].value != 0) {
            grid[i][j].value = grid[i][z].value;
            grid[i][z].value = 0;
            spawn = true;
            break;
          }
        }
      }
    }
  }
  if (spawn)
    spawn(1);
}

void left() {
  boolean spawn = false;
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 3; i++) {
      for (int z = i+1; z <= 3; z++) {
        if (grid[z][j].value != 0) {
          if (grid[i][j].value == grid[z][j].value && grid[i][j].value != 2048) {
            grid[i][j].value *= 2;
            grid[z][j].value = 0;
            locked--;
          }
          break;
        }
      }
    }
  }
  for (int j = 0; j < 4; j++) {
    for (int i = 0; i < 3; i++) {
      if (grid[i][j].value == 0) {
        for (int z = i+1; z <= 3; z++) {
          if (grid[z][j].value != 0) {
            grid[i][j].value = grid[z][j].value;
            grid[z][j].value = 0;
            spawn = true;
            break;
          }
        }
      }
    }
  }
  if (spawn)
    spawn(1);
}

void setDict() {
  d.set("2", 50);
  d.set("4", 65);
  d.set("8", 90);
  d.set("16", 110);
  d.set("32", 130);
  d.set("64", 150);
  d.set("128", 175);
  d.set("256", 190);
  d.set("512", 205);
  d.set("1024", 220);
  d.set("2048", 250);
}

void newGame() {
  gameOver = false;
  locked = 0;
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      grid[i][j] = new GRID(i*scale, j*scale);
  spawn(2);
}