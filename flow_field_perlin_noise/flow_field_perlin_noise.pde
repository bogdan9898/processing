int rows, cols;
int _scale = 20;
float increment = 0.1;
float _time = 0;
PVector[][] field;
PARTICLE[] p;
int nrParticles = 10000;

void setup() {
  colorMode(HSB);
  size(1200, 800, P2D);
  background(0);
  rows = floor(height / _scale);
  cols = floor(width / _scale);
  field = new PVector [cols][rows];
  p = new PARTICLE[nrParticles];
  for (int i = 0; i < nrParticles; i++) {
    p[i] = new PARTICLE();
  }
}

void draw() {
  println(frameRate);
  //background(200);
  float _noise1 = 0;
  for (int i = 0; i < cols; i++) {
    float _noise2 = 0;
    for (int j = 0; j < rows; j++) {
      float temp = noise(_noise1, _noise2, _time) * TWO_PI * 0.75; 
      PVector v = PVector.fromAngle(temp);
      v.setMag(1);
      field[i][j] = v;
      //pushMatrix();
      //translate(i*_scale, j*_scale);
      //rotate(v.heading());
      //strokeWeight(1);
      //stroke(1, 100);
      //line(0, 0, _scale, 0);
      //popMatrix();
      _noise2 += increment;
      _time += 0.000005;//0.000005;
      //rect(i*_scale, j*_scale, _scale, _scale);
    }
    _noise1 += increment;
  }
  for (int i = 0; i < nrParticles; i++) {
    p[i].move();
    p[i].edge();
    p[i].stream();
    p[i].show();
  }
}