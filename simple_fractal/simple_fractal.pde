float dim = 250;
float alfa = PI;
float _scale = 1.5;
float nr = 0;
float _color = 0;

void setup() {
  size(900, 800);
  colorMode(HSB);
}

void draw() {
  background(50);
  alfa = map(sin(nr), -1, 1, PI, PI*2);
  _color = map(sin(nr), -1, 1, 0, 255); 
  nr += 0.005;
  translate(width/2, height);
  stroke(int(_color), 255, 255); 
  strokeWeight(3);
  _expand(dim);
}

void _expand(float dim) {
  if (dim > 5) {
    //pushMatrix();
    line(0, 0, 0, 0-dim);
    translate(0, 0-dim);
    pushMatrix();
    rotate(alfa);
    _expand(dim/_scale);
    popMatrix();
    rotate(-alfa);
    _expand(dim/_scale);
    //popMatrix();
  }
}