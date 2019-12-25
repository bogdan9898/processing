Grid[][] grid;
int scale = 80;
int rows, cols;
int bombs = 9, flags = 0;
PImage bomb, flag;
boolean gameOver;

void setup() {
  size(800, 800);
  bomb = loadImage("bomb.png");
  bomb.resize(scale-35, scale-35);
  flag = loadImage("flag.png");
  flag.resize(scale-35, scale-35);
  imageMode(CENTER);
  rows = width/scale;
  cols = height/scale;
  grid = new Grid[rows][cols];
  textAlign(CENTER, CENTER);
  textSize(35);
  fill(170);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      grid[i][j] = new Grid(i, j);
      rect(i*scale, j*scale, scale, scale);
    }
  }
  setBombs();
}

void draw() {
}

void keyPressed() {
  //revealGrid();
  if (gameOver) {
    fill(170);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j].reset();
        rect(i*scale, j*scale, scale, scale);
      }
    }
    setBombs();
    gameOver = false;
    flags = 0;
  }
}

void revealGrid() {    
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j].isBomb)
        image(bomb, i*scale+scale/2, j*scale+scale/2);
      else {
        fill(0);
        text(grid[i][j].value, i*scale+scale/2, j*scale+scale/2);
      }
    }
  }
}

void mousePressed() {
  if (!gameOver) {
    int i = mouseX/scale;
    int j = mouseY/scale;
    if (mouseButton == LEFT) {
      revealCell(i, j);
    } else if (mouseButton == RIGHT && !grid[i][j].isRevealed) {
      flagCell(i, j);
    }
  }
}

void revealCell(int i, int j) {
  if (i >= 0 && i <= rows-1 && j >= 0 && j <= cols-1) {
    if (grid[i][j].isBomb && !grid[i][j].isFlag) {
      image(bomb, i*scale+scale/2, j*scale+scale/2);
      gameOver(false);
    } else if (!grid[i][j].isRevealed && grid[i][j].value == 0 && !grid[i][j].isFlag) {
      fill(220);
      rect(i*scale, j*scale, scale, scale);
      fill(0);
      grid[i][j].isRevealed = true;
      revealCell(i-1, j-1);
      revealCell(i, j-1);
      revealCell(i+1, j-1);
      revealCell(i+1, j  );
      revealCell(i-1, j+1);
      revealCell(i, j+1);
      revealCell(i-1, j+1);
      revealCell(i-1, j  );
    } else if (grid[i][j].value != 0 && !grid[i][j].isFlag) {
      grid[i][j].isRevealed = true;
      fill(0);
      text(grid[i][j].value, i*scale+scale/2, j*scale+scale/2);
    }
  }
}

void setBombs() {
  for (int t = 0; t < bombs; t++) {
    int i, j;
    do {
      i = int(random(0, rows));
      j = int(random(0, cols));
    } while (grid[i][j].isBomb);
    grid[i][j].isBomb = true;
    incNeighbours(i, j);
  }
}

void incNeighbours(int i, int j) {
  /*
  i-1, j-1
   i  , j-1
   i+1, j-1
   i+1, j
   i+1, j+1
   i  , j+1
   i-1, j+1
   i-1, j
   */
  if (i>0 && j>0)
    if (!grid[i-1][j-1].isBomb)
      grid[i-1][j-1].value++;
  if (j>0)
    if (!grid[i][j-1].isBomb)
      grid[i][j-1].value++;
  if (i<rows-1 && j>0)
    if (!grid[i+1][j-1].isBomb)
      grid[i+1][j-1].value++;
  if (i<rows-1)
    if (!grid[i+1][j].isBomb)
      grid[i+1][j].value++;
  if (i<rows-1 && j<cols-1)
    if (!grid[i+1][j+1].isBomb)
      grid[i+1][j+1].value++;
  if (j<cols-1)
    if (!grid[i][j+1].isBomb)
      grid[i][j+1].value++;
  if (i>0 && j<cols-1)
    if (!grid[i-1][j+1].isBomb)
      grid[i-1][j+1].value++;
  if (i>0)
    if (!grid[i-1][j].isBomb)
      grid[i-1][j].value++;
}

void flagCell(int i, int j) {
  grid[i][j].isFlag = !grid[i][j].isFlag;
  if (grid[i][j].isFlag) {
    image(flag, i*scale+scale/2, j*scale+scale/2);
    if (grid[i][j].isBomb) {
      flags++;
    }
  } else {
    if (grid[i][j].isBomb) {
      flags--;
    }
    fill(170);
    rect(i*scale, j*scale, scale, scale);
  }
  if (flags == bombs) {
    gameOver(true);
  }
}

void gameOver(boolean win) {
  gameOver = true;
  println("Game Over");
  if (!win)
    println("You Lost!");
  else
    println("You Won!");
  println("Press any key to restart");
}