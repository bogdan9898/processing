final int nrSeekers = 200;
final int repetari = 500;
final float r = 2;
int counterTree = 1;
final int wantedTreeSize = 50000;
float searchZone = r * 2;
final int textSize = 25;
boolean showSeekers;
boolean showSearchZone;
float hu = 0;
int startCountingTrees = 0;

TREE[] tree = new TREE[wantedTreeSize];
SEEKERS[] seekers = new SEEKERS[nrSeekers];

void setup() {
  size(1600, 900, FX2D);
  noStroke();
  tree[0] = new TREE(width/2, height/2, hu); 
  for (int i = 0; i < seekers.length; i++) {
    seekers[i] = new SEEKERS(random(width), random(height));
  }
  textSize(textSize);
  colorMode(HSB);
}

void draw() {
  println("FPS:", int(frameRate), "Tree:", counterTree);
  background(150);
  fill(360, 0, 255);
  if (hu > 230)
    noLoop();
  for (int i = 0; i < counterTree; i++)
    tree[i].show();
  if (showSeekers) {
    fill(0);
    text("showSeekers: true", 2, textSize);
    text("showSearchZone: true", 2, textSize * 2);
    for (int i = 0; i < seekers.length; i++) {
      seekers[i].show();
    }
  } else {
    fill(0);
    text("showSeekers: false", 2, textSize);
    text("showSearchZone: false", 2, textSize * 2);
  }
  for (int n = 0; n < repetari; n++) {
    for (int i = 0; i < seekers.length; i++) {
      seekers[i].move();
      if (dist(width/2, height/2, seekers[i].x, seekers[i].y) < searchZone) {
        seekers[i].checkCollison();
      }
    }
  }
  if (showSearchZone) {
    noFill();
    stroke(0);
    ellipse(width/2, height/2, searchZone * 2, searchZone * 2);
    noStroke();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    noLoop();
  } else {
    showSeekers = !showSeekers;
    showSearchZone = !showSearchZone;
  }
}