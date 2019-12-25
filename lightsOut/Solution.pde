class Solution {
  private Light lights[][];
  private int nrCols, nrRows;
  private Light highlightedLight;

  Solution(int nrCols, int nrRows, float lightWidth, PVector origin) {
    lights = new Light[nrCols][nrRows];
    this.nrCols = nrCols;
    this.nrRows = nrRows;
    highlightedLight = null;
    for (int i = 0; i < nrCols; i++) {
      for (int j = 0; j < nrRows; j++) {
        lights[i][j] = new Light(origin.x + lightWidth * i, origin.y + lightWidth * j, lightWidth, false);
      }
    }
  }

  public void toggleLightAtIndex(int i, int j) {
    if (i >= nrCols || j >= nrRows) { // if out of bounds
      return;
    }
    lights[i][j].toggle();
  }

  public void highlight(int i, int j) {
    if (i >= nrCols || j >= nrRows) {// if out of bounds
      highlightedLight = null;
    } else {
      highlightedLight = lights[i][j];
    }
  }

  public void draw() {
    for (Light[] lightsRow : lights) {
      for (Light light : lightsRow) {
        light.draw();
      }
    }
    if (highlightedLight != null) {
      highlightedLight.drawAsHightlighted();
    }
  }
}
