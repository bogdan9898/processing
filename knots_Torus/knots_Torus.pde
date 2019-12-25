void setup() {
  size(800, 800, P3D);
}

boolean vertical = true;
float alfa = 0;
static final float NSEGMENTS = 1000;
static final float nmeridian = 6; //6
static final float nlongitude = 11; //11

void draw() {
  translate(width/2, height/2); 
  scale(200); 
  strokeWeight(0.03);
  noFill();
  background(180);
  if (vertical) {
    rotateY(alfa);
  } else {
    rotateX(alfa);
  }
  alfa += 0.005;
  beginShape();
  for (int i = 0; i <= NSEGMENTS; i++) {
    float angle = i * TWO_PI * nmeridian / NSEGMENTS;
    float x = cos(angle) * (1 + cos(nlongitude*angle/nmeridian) / 2.0);
    float y = sin(angle) * (1 + cos(nlongitude*angle/nmeridian) / 2.0);
    float z = sin(nlongitude*angle/nmeridian) / 2.0;
    vertex(x, y, z);
  }
  endShape(CLOSE);
}

void mousePressed() {
  vertical = !vertical;
}