PShape star;

void setup(){
 size(700,700);
}

 int n = 10, r = 350;
 int w = 1, h = 1; 
 int x0 = 650, y0 = 650;
 float alfa = 2*PI/n;
 float gama = PI;//inclinatia
 
void draw(){
 display();
 float r = map(mouseX, 0, width, 0, 255);
 float g = map(mouseY, 0, height, 0, 255);
 float b = map(mouseX*mouseY, 0, width, 0, 255);

 //background(51);
 //translate(mouseX, mouseY);
 star.setFill(color(r, g, b));
 //shape(star);
}

void display(){
 w+=0.1; h+=0.1;
 star = createShape(ELLIPSE, width/2, height/2, 100+50*sin(w), 100+50*sin(h));
 star.setFill(color(255, 0, 0));
 star.setStrokeWeight(3);
 star.setStroke(color(255, 255, 255));
 shape(star);
}