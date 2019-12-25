class bit{
 float x;// = random(0, width);
 float y;// = random(-500, -200);
 float z = random(0, 2);
 float speed = map(z, 0, 2, 2, 10);
 int type = round(random(0, 1));
 
 bit(float x, float y){
  this.x = x;
  this.y = y;
 }

 void gravity(){
   y += speed;
   //speed += 0.3;
   if(y > height){
    y = random(mouseY-imgh/2*spawny, mouseY+imgh/2*spawny);
    x = random(mouseX-imgw/2*spawnx, mouseX+imgw/2*spawnx);
    speed = map(z, 0, 2, 2, 10);
   }
 }

 void render(){
    textSize(map(z, 0, 2, 10, 25));
    text(type, x, y);
    this.gravity();
 }
}