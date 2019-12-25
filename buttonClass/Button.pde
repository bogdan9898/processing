class Button {
  float x, y, w, h;
  String txt;
  boolean hover;
  boolean clicked;

  Button(float x, float y, float w, float h, String s) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.txt = s;
    hover = false;
    clicked = false;
  }

  boolean hover(int mx, int my) {
    return (mx > x && mx < x+w && my > y && my < y+h);
  }

  void click() {
    clicked = true;
  }
  
  void release(){
    clicked = false;
  }

  void render() {
    if (clicked)
      fill(255, 0, 0);
    else if (hover)
      fill(150);
    else
      fill(255);
    rect(x, y, w, h);
    textAlign(LEFT, TOP);
    textSize(25);
    fill(0, 255, 255);
    text(txt, x, y);
  }

  void printDet() {
    println(x, y, w, h, txt);
  }
}