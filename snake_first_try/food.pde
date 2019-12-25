class Food {
 int x, y;
 PImage steak;
 
 Food(String image_name){
   steak = loadImage(image_name);
   steak.resize(l, l);
   x = y = 0;
 }
 
 void move(float x1, float y1) {
   x += x1;
   y += y1;
 }
 
 void render() {
  image(steak, l*int(x/l), l*int(y/l)); 
 }
 
 void spawn() {
    x = l*(int)random(width/l);
    y = l*(int)random(height/l); 
 }
}
