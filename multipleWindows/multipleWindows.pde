SecondApplet sa; 
float x = 0;

void settings() {
  size(500, 300);
}

void setup() {
  background(255, 0, 0);
  textSize(50);
  textAlign(CENTER);
  text("1", width/2, height/2);

  String[] args = {"TestName"};
  sa = new SecondApplet();
  PApplet.runSketch(args, sa);
}

void draw() {
  background(map(sin(x), -1, 1, 0, 255));
  x += 0.05;
}

class SecondApplet extends PApplet {
  void settings() {
    size(700, 500);
  }

  void setup() {
    background(0, 255, 0);
    textSize(50);
    textAlign(CENTER);
    text("2 "+x, width/2, height/2);
  }

  void draw() {
    background(map(cos(x), -1, 1, 0, 255));
  }

  void keyPressed() {
    println(keyCode);
  }
}