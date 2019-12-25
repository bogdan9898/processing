class Light {
  private float x, y, w;
  private boolean state;

  public Light(float x, float y, float w, boolean state) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.state = state;
  }

  public void toggle() {
    state = !state;
  }

  public void draw() {
    //noStroke();
    strokeWeight(4);
    stroke(255);
    if (state == true)
      fill(255, 255, 0);
    else
      fill(80);
    rect(x, y, w, w);
  }

  public void drawAsHightlighted() {
    fill(0, 120);
    rect(x, y, w, w);
  }

  public boolean getState() {
    return state;
  }

  public void setState(boolean state) {
    this.state = state;
  }

  public boolean isLit() {
    return state;
  }

  public String toString() {
    return "x: " + x + " y: " + y + " state: " + state;
  }
}
