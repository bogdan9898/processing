CIRCLE c;
RECTANGLE r;
float d;

void setup() {
  size(700, 700);
  rectMode(CENTER);
  ellipseMode(CENTER);
  c = new CIRCLE(width, height, 30);
  r = new RECTANGLE(width/2, height/2, 200, 400);
}

void draw() {
  background(200);
  checkCollision();
  c.followCursor();
  r.render();
  c.render();
  printDebuggingInfo();
}

boolean left, top, bottom;
void checkCollision() {
  top = c.y + c.r >= r.y - r.h/2;
  left = c.x + c.r >= r.x - r.w/2;
  bottom = c.y - c.r <= r.y + r.h/2;

  c.colliding = top && left && bottom;
}

void printDebuggingInfo() {
  String info = new String();
  info += "rect x: "+r.x+"\n";
  info += "rect y: "+r.y+"\n";
  info += "rect w: "+r.w+"\n";
  info += "rect h: "+r.h+"\n";
  info += "\n";
  info += "circle x: "+c.x+"\n";
  info += "circle y: "+c.y+"\n";
  info += "circle r: "+c.r+"\n";
  info += "\n";
  info += "dist: "+dist(c.x, c.y, r.x, r.y)+"\n";
  info += "\n";
  info += "top: "+top+"\n";
  info += "left: "+left+"\n";
  info += "bottom: "+bottom+"\n";
  fill(0);
  textSize(20);
  text(info, 5, 20);

  noFill();
  stroke(255, 0, 0);
  ellipse(r.x, r.y, r.w, r.w);
  ellipse(r.x, r.y, r.h, r.h);
  d = dist(r.x, r.y, r.x+r.w/2, r.y+r.h/2);
  ellipse(r.x, r.y, d*2, d*2);
}