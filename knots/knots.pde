void setup() {
  size(800, 800, P3D);
}

float alfa = 0;

void draw() {
  translate(width/2, height/2);
  background(180);
  rotateY(alfa); 
  alfa += 0.01;
  float beta = 0;
  noFill();
  beginShape();
  while (beta < PI) {
    /*
    float r = 100*(0.8 + 1.6 * sin(6 * beta));
     float theta = 2 * beta;
     float phi = 0.6 * PI * sin(12 * beta);
    */
    
    float r = 500*(1.2 * 0.6 * sin(0.5 * PI + 6 * beta));
    float theta = 4 * beta;
    float phi = 0.2 * PI * sin(6 * beta);
    
    float x = r * cos(phi) * cos(theta);
    float y = r * cos(phi) * sin(theta);
    float z = r * sin(phi);
    vertex(x, y, z);
    beta += 0.01;
  }
  endShape(CLOSE);
}