void setup(){
 size(800,800);
}

 //int v[] = new int[100];
  
 int x = 400;
 int y = 400;
 float r = 350;
 int n = 10;
 float alfa = 2*PI/n;
 //float gama = PI/3.2;
 
void draw(){
 noFill();
 strokeWeight(3);
 stroke(200, 50, 0);
 ellipse(x, y, r*2, r*2);
 stroke(0);
 
 while(r > 1){
  if(r > 50)
   beginShape();
   for(int i = 0; i < n; i++){
     if (i%2 == 0)
      vertex(x+cos(i*alfa)*r, y+sin(i*alfa)*r);
     else
      vertex(x+cos(i*alfa)*(r/2), y+sin(i*alfa)*(r/2));
   }
 endShape(CLOSE);
 r = r/2;
}
 
 //line(x, y, x+cos(0)*r, y+sin(0)*r);
 //line(x, y, x+cos(alfa)*r, y+sin(alfa)*r);
 //line(x-l/2, y-l/2, x+l/2, y-l/2);
 //line(x+l/2, y-l/2, x+l/2, y+l/2);
 //line(x+l/2, y+l/2, x-l/2, y+l/2);
 //line(x-l/2, y+l/2, x-l/2, y-l/2);
 
 
}