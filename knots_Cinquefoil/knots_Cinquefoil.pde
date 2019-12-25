ArrayList<PVector> points;

void setup() {
  size(800, 800, P3D);
  points = new ArrayList<PVector>(); 
  strokeWeight(0.1); 
  noFill();
}

boolean vertical = true;
float alfa = 0;

static final int k = 3;
float beta = 0;
float dir = 0.25;
float sclFactor = 75;

void draw() {
  translate(width/2, height/2);
  scale(sclFactor);
  background(180);
  if (vertical) {
    rotateY(alfa);
  } else {
    rotateX(alfa);
  }
  alfa += 0.005;

  if (beta < (4*k + 2)*PI) {
    float x = cos(beta) * (2 - cos(2*beta/(2*k + 1)));
    float y = sin(beta) * (2 - cos(2*beta/(2*k + 1)));
    float z = -sin(2*beta/(2*k + 1));
    beta += 0.01;
    points.add(new PVector(x, y, z));
  } 
  sclFactor +=dir;
  if (sclFactor > 100) {
    dir = -0.25;
  }
  if (sclFactor < 50) {
    dir = 0.25;
  }
  for (PVector p : points) {
    point(p.x, p.y, p.z);
  }


  //beta = 0;
  //beginShape();
  //while (beta < (4*k + 2)*PI) {
  //  float x = cos(beta) * (2 - cos(2*beta/(2*k + 1)));
  //  float y = sin(beta) * (2 - cos(2*beta/(2*k + 1)));
  //  float z = -sin(2*beta/(2*k + 1));
  //  //where 0 < beta < (4 k + 2) pi;
  //  beta += 0.1;
  //  vertex(x, y, z); 
  //}
  //endShape(CLOSE);
}

void mousePressed() {
  vertical = !vertical;
  if (mouseButton == RIGHT) {
    noLoop();
  }
}