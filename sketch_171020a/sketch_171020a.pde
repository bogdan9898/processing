PShape star;

void setup(){
 size(1000,1000);
  //star = createShape(RECT,mouseX-(w/2), mouseY-(h/2), w, h);
  //star = createShape(ELLIPSE,mouseX-(w/2), mouseY-(h/2), w*10, h*10);
  
  star = createShape();
  star.beginShape();
  for(int i = 0; i < n; i++){
     if (i%2 == 0)
      star.vertex(x0+sin(i*alfa+gama)*r, y0+cos(i*alfa+gama)*r);
     else
      star.vertex(x0+sin(i*alfa+gama)*(r/2), y0+cos(i*alfa+gama)*(r/2));
   }
  star.endShape(CLOSE);
  
  star.scale(0.5);
  star.setFill(color(255, 0, 0));
  star.setStrokeWeight(8);
  star.setStroke(color(255, 255, 255));
}

 int n = 10, r = 350;
 int w = 100, h = 100; 
 int x0 = mouseX, y0 = mouseY;
 float alfa = 2*PI/n;
 float gama = PI;//inclinatia
 
void draw(){
 
 float r = map(mouseX, 0, width, 0, 255);
 float g = map(mouseY, 0, height, 0, 255);
 float b = map(mouseX*mouseY, 0, width, 0, 255);

 background(51);
 redline();
 translate(mouseX, mouseY);
 star.setFill(color(r, g, b));
 shape(star);

}

void mousePressed(){
 if(mouseButton == LEFT)
  star.scale(0.5);
 else
  star.scale(1.5);
}