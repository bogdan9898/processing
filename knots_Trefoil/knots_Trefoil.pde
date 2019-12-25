void setup() {
  size(800, 800, P3D);
}

boolean vertical = true;
float alfa = 0;

void draw() {
  translate(width/2, height/2);  
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
    float x = 41*cos(beta) - 18*sin(beta) - 83*cos(2*beta) - 83*sin(2*beta) - 11*cos(3*beta) + 27*sin(3*beta);
    float y = 36*cos(beta) + 27*sin(beta) - 113*cos(2*beta) + 30*sin(2*beta) + 11*cos(3*beta) - 27*sin(3*beta);
    float z = 45*sin(beta) - 30*cos(2*beta) + 113*sin(2*beta) - 11*cos(3*beta) + 27*sin(3*beta);
    //where 0 < beta < 2 pi
    beta += 0.1;
    vertex(x, y, z);
  }
  endShape(CLOSE);
}

void mousePressed() {
  vertical = !vertical;
}