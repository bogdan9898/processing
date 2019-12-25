void setup() {
  size(800, 800, P3D);
}

boolean vertical = true;
float alfa = 0;

void draw() {
  translate(width/2, height/2); 
  scale(2);
  strokeWeight(3);
  noFill();
  background(180);
  if (vertical) {
    rotateY(alfa);
  } else {
    rotateX(alfa);
  }
  alfa += 0.005;
  float beta = 0;
  beginShape();
  while (beta < TWO_PI) {
    float x = -22*cos(beta) - 128*sin(beta) - 44*cos(3*beta) - 78*sin(3*beta);
    float y = -10*cos(2*beta) - 27*sin(2*beta) + 38*cos(4*beta) + 46*sin(4*beta);
    float z = 70*cos(3*beta) - 40*sin(3*beta);
    //where 0 < beta < 2 pi
    beta += 0.01;
    vertex(x, y, z);
  }
  endShape(CLOSE);
}

void mousePressed() {
  vertical = !vertical;
}