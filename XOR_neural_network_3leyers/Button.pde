class Button {
  float x, y, w, h;
  String txt;
  boolean hover;
  boolean clicked;
  int mode;

  Button(float x, float y, float w, float h, String s, int mode) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.txt = s;
    this.mode = mode;
    hover = false;
    clicked = false;
  }

  boolean hover(int mx, int my) {
    if (mode == CORNER)
      return (mx > x && mx < x+w && my > y && my < y+h);
    else {//in case: mode == CENTER
      float x0 = x - w/2;
      float y0 = y - h/2;
      return(mx > x0 && mx < x0+w && my > y0 && my < y0+h);
    }
  }

  void click() {
    clicked = true;
  }

  void release() {
    clicked = false;
  }

  void render() {
    noStroke();
    if (clicked)
      fill(0);
    else if (hover)
      fill(150);
    else
      fill(255);

    rectMode(mode);
    rect(x, y, w, h);
    if (mode == CORNER)
      textAlign(LEFT, TOP);
    else//in case: mode == CENTER
      textAlign(CENTER, CENTER);
    textSize(h-7);
    fill(255, 0, 0);
    text(txt, x, y);
  }

  //void printDet() {
  //  println(x, y, w, h, txt);
  //}
}