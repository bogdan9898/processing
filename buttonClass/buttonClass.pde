ArrayList<Button> list;


void setup() {
  size(300, 300);
  list = new ArrayList<Button>();
  Button a = new Button(0, 0, 40, 20, "test");
  list.add(a);
}

void draw() {
  //println((int)frameRate);

  background(0);
  checkButtons(mouseX, mouseY);

  for (Button t : list) {
    //t.printDet();
    t.render();
  }
}

void mousePressed() {
  for (Button t : list) {
    if (t.hover(mouseX, mouseY))
      t.click();
  }
}

void mouseReleased() {
  for (Button t : list) {
    t.release();
  }
}

void keyPressed() {
  list.add(new Button(mouseX, mouseY, 40, 20, mouseX+" "+mouseY));
}

void checkButtons(int x, int y) {
  boolean cursorHand = false;
  for (Button t : list) {
    if (t.hover(x, y)) {
      cursorHand = true;
      t.hover = true;
    } else {
      t.hover = false;
    }
  }
  if (cursorHand)
    cursor(HAND);
  else
    cursor(ARROW);
}