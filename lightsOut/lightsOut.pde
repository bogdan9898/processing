Game game;
final int rows = 6, cols = 6;
final int initialSetup[][] = {
  {0, 1, 0, 0, 1, 1}, 
  {0, 0, 1, 1, 0, 0}, 
  {0, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1}, 
  {0, 1, 1, 0, 0, 0}, 
  {0, 0, 0, 1, 0, 0}};

void setup() {
  size(800, 500);
  startGame();
}

void draw() {
  background(80);
  game.draw();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    game.toggleLightAtPos(mouseX, mouseY);
    if (game.isSolved()) {
      println("YOU WON");
    }
  }
}

void mouseMoved() {
  game.highlight(mouseX, mouseY);
}

void keyPressed() {
  if (key == 'r') {
    startGame();
  }
}

void startGame() {
  final float p = 75/100.0;
  final float lightsWidth = min(p*width/rows, height/cols); // let a small empty window on the right
  game = new Game(cols, rows, lightsWidth, initialSetup);
}
