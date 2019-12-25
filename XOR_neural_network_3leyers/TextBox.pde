class TextBox {
  float x, y, w, h;
  StringBuilder buffer;
  int size;
  boolean hover;
  boolean clicked;
  int blink;
  int blinkFrame;
  int mode;

  TextBox(float x, float y, float w, float h, int mode) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.mode = mode;
    buffer = new StringBuilder();
    size = 0;
    blink = 0;
    blinkFrame = 0;
  }

  void render() {
    noStroke();
    if (clicked) {
      if (blinkFrame%60 == 0)
        blink = 1;
      else if (blinkFrame%60 == 30)
        blink = -1;
      else
        blink = 0;
      switch (blink) {
      case 1:
        buffer.append("|");
        break;
      case -1:
        if (buffer.length() > 0)
          buffer.deleteCharAt(buffer.length()-1);
        break;
      }
      blinkFrame++;
      fill(150);
    } else if (hover)
      fill(200);
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
    text(buffer.toString(), x, y);
  }

  void click() {
    if (!clicked) {
      blinkFrame = 0;
      clicked = true;
    }
  }

  void release() {
    clicked = false;
    if (buffer.length() > 0 && buffer.charAt(buffer.length()-1) == '|')
      //println("forgot |");
      buffer.deleteCharAt(buffer.length()-1);
  }

  boolean hover(float mx, float my) {
    if (mode == CORNER)
      return (mx > x && mx < x+w && my > y && my < y+h);
    else {//in case: mode == CENTER
      float x0 = x - w/2;
      float y0 = y - h/2;
      return(mx > x0 && mx < x0+w && my > y0 && my < y0+h);
    }
  }

  void write(char c) {
    if (c >= '0' && c <= '9' || c == '.') {
      buffer.insert(size, c);
      size++;
    } else {
      if (c == 8) {//backspace
        if (size > 0) {
          buffer.deleteCharAt(size-1);
          size--;
        }
      }
    }
  }
}