class Game {
  private Light lights[][];
  private int nrCols, nrRows;
  private float lightWidth;
  private Solution solution;
  private Light highlightedLight;

  public Game(int nrCols, int nrRows, float lightWidth, int initialSetup[][]) {
    lights = new Light[nrCols][nrRows];
    this.nrCols = nrCols;
    this.nrRows = nrRows;
    this.lightWidth = lightWidth;
    for (int i = 0; i < nrCols; i++) {
      for (int j = 0; j < nrRows; j++) {
        lights[i][j] = new Light(lightWidth * i, lightWidth * j, lightWidth, initialSetup[j][i] != 0);
      }
    }
    setupSolution();
  }

  public Game(int nrCols, int nrRows, float lightWidth) {
    lights = new Light[nrCols][nrRows];
    this.nrCols = nrCols;
    this.nrRows = nrRows;
    this.lightWidth = lightWidth;
    for (int i = 0; i < nrCols; i++) {
      for (int j = 0; j < nrRows; j++) {
        lights[i][j] = new Light(lightWidth * i, lightWidth * j, lightWidth, true);
      }
    }
    setupSolution();
  }

  private void setupSolution() {
    //float w = 510;
    float w = nrCols*lightWidth+lightWidth/2;
    //float h = 170;
    float h = (nrRows*lightWidth)/2 - nrRows*lightWidth/4;
    solution = new Solution(nrCols, nrRows, lightWidth/2, new PVector(w, h));
  }

  public void draw() {
    for (Light[] rowOfLights : lights) {
      for (Light light : rowOfLights) {
        light.draw();
      }
    }
    if (highlightedLight != null) {
      highlightedLight.drawAsHightlighted();
    }
    solution.draw();
  }

  public boolean isSolved() {
    for (Light[] rowOfLights : lights) {
      for (Light light : rowOfLights) {
        if (light.isLit()) {
          //println("light lit: " + light.toString());
          return false;
        }
      }
    }

    return true;
  }

  public void toggleLightAtPos(float x, float y) {
    int i = floor(x/lightWidth);
    int j = floor(y/lightWidth);
    //println("i: " + i +" - j: " + j);
    if (i >= nrCols || j >= nrRows) { // if out of bounds
      return;
    }

    lights[i][j].toggle();
    solution.toggleLightAtIndex(i, j);

    if (i > 0) {
      lights[i-1][j].toggle();
    }
    if (i < nrCols-1) {
      lights[i+1][j].toggle();
    }
    if (j > 0) {
      lights[i][j-1].toggle();
    }
    if (j < nrRows-1) {
      lights[i][j+1].toggle();
    }
  }

  public void highlight(float x, float y) {
    int i = floor(x/lightWidth);
    int j = floor(y/lightWidth);
    //println("i: " + i +" - j: " + j);
    if (i >= nrCols || j >= nrRows) { // if out of bounds
      highlightedLight = null;
    } else {
      highlightedLight = lights[i][j];
    }

    solution.highlight(i, j);
  }

  public Solution getSolution() {
    return solution;
  }
}
