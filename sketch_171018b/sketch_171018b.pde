void setup(){
 size(800,800);
}

 //float x[] = new float[100];
 //float y[] = new float[100];
 int x0 = 400;
 int y0 = 400;
 float r = 350;
 float r2 = r/2;
 int n = 20;
 float alfa = 2*PI/(n/2);
 float gama = PI; //inclinatia
 
void draw(){
 noFill();
 strokeWeight(3);
 //stroke(200, 50, 0);

 while(r > r2){
  stroke(r-145, r*0.85, 0);
  beginShape();
  for(int i = 0; i < n; i++){
   if (i%2 == 0)
    vertex(x0+sin(i*alfa+gama)*r, y0+cos(i*alfa+gama)*r);
   else
    vertex(x0+sin(i*alfa+gama)*(r/2), y0+cos(i*alfa+gama)*(r/2));
   }
 endShape(CLOSE);
 r--;
 }

}