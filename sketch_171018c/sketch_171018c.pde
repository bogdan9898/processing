int dist = 20;
float gama = PI; //inclinatia
float x[] = new float[1000];
float y[] = new float[1000];
int x0 = 510;
int y0 = 550;
float r = 500;
//float r2 = r/2;
int n = 10;
float alfa = 2*PI/n;
int nr_s = 4; //nr stele;

void setup() {
  size(1000, 1000);
  //for(int i = 0; i < nr_s*n; i++){
  for (int j = 0; j < nr_s; j++) {
    for (int i = 0; i < n; i++) {
      if (i%2 == 0) {
        x[j*10+i] = x0+sin(i%10*alfa+gama)*r;
        y[j*10+i] = y0+cos(i%10*alfa+gama)*r;
      } else {
        x[j*10+i] = x0+sin(i%10*alfa+gama)*(r/2); 
        y[j*10+i] = y0+cos(i%10*alfa+gama)*(r/2);
      }
      if (i%(n-1) == 0) {
        r = r-dist;
        //r = r/2;
        //r2 = r2/2;
      }
    }
  }
}

void draw() {
  noFill();
  strokeWeight(3);
  //stroke(200, 50, 0);

  r = dist*10;
  //r2 = r/2;
  for (int j = 0; j < nr_s; j++) {
    //stroke(r-145, r*0.8, 0);
    beginShape();
    for (int i = 0; i < n; i++) {
      vertex(x[j*10+i], y[j*10+i]);
    }
    endShape(CLOSE);
  }
  redline();
}