PImage img;
bit[] b = new bit[100];
float imgscale = 2;
float spawnx = imgscale/2.5;
float spawny = imgscale/10;
int imgw;
int imgh;
boolean click = false;

void setup(){
  fullScreen();
  //size(800, 640);
  img = loadImage("cloud.png");
  //1280 x 831
  imgw = round(map(imgscale, 0, 10, 0, 1280));
  imgh = round(map(imgscale, 0, 10, 0, 831));
  print(imgw, imgh);
}
 
void draw(){
  background(64, 64, 64);
  if(click == true)
   for(int i = 0; i < b.length; i++){
    b[i].render();
   }
  image(img, mouseX-imgw/2, mouseY-imgh/2, imgw, imgh);
}

void mousePressed(){
  if(click == false)
   for(int i = 0; i < b.length; i++){
    //b[i] = new bit(random(0, width), random(-500, -200));
    b[i] = new bit(random(mouseX-imgw/2*spawnx, mouseX+imgw/2*spawnx), random(mouseY-imgh/2*spawny, mouseY+imgh/2*spawny));
   }
  click = true;
  //click = (click == false) ? true : false;
}