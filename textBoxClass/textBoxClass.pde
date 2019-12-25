ArrayList<TextBox> list;
boolean writing = false;
TextBox clickedTB;


void setup() {
  size(300, 300);

  list = new ArrayList<TextBox>();

  TextBox a = new TextBox(width/2, height/2, 100, 50);
  list.add(a);

  TextBox b = new TextBox(width/4, height/4, 100, 50);
  list.add(b);
}

void draw() {
  checkTB(mouseX, mouseY);

  background(0);
  for (TextBox t : list) {
    t.render();
  }
}

void mousePressed() {
  for (TextBox t : list)
    if (t.hover(mouseX, mouseY)) {
      t.click();
      if (clickedTB != null)
        clickedTB.release();
      clickedTB = t;
    }
}

void keyPressed() {
  if (clickedTB != null) {
    clickedTB.write(key);
    if(keyCode == 10) {
      clickedTB.release();
      clickedTB = null;
    }
  }
}

void checkTB(float x, float y) {
  boolean cursorText = false;
  for (TextBox t : list)
    if (t.hover(x, y)) {
      cursorText = true;
      t.hover = true;
    } else {
      t.hover = false;
    }
  if (cursorText)
    cursor(TEXT);
  else
    cursor(ARROW);
}