int l = 30;
Food meal;
Snake python;

void setup() {
  size(720, 720);
  meal = new Food("food.png");
  meal.spawn();
  python = new Snake(3);
}

void draw() {
   background(125, 70, 49);
   //showTable();
   
   meal.render();
   python.render();
   if(frameCount%30 == 0)
     python.move();
   if(checkFood()) {
     python.grow();
     meal.spawn();
   }
   //moveRandom();
}

boolean checkFood() {
  return python.body.get(python.body.size()-1).x == float(meal.x) && python.body.get(python.body.size()-1).y == float(meal.y);
}

void showTable() {
  stroke(255);
  for(int i = 0; i < width/l; i++){
    for(int j = 0; j < height/l; j++){
      noFill();
      rect(l*i, l*j, l, l);
    }
  } 
}

void moveRandom() { 
   float dir_x = meal.x - mouseX;
   if(dir_x != 0)
     dir_x /= -abs(dir_x);
   float dir_y = meal.y - mouseY;
   if(dir_y != 0)
     dir_y /= -abs(dir_y);
     
   //println("dir_x = " + dir_x + "   dir_y = " + dir_y);
   meal.move(dir_x, dir_y);
}

void keyPressed() {
   if(keyCode == LEFT) {
     python.setDir(-1, 0);
   }
   else if(keyCode == UP) {
     python.setDir(0, -1);
   }
   else if(keyCode == RIGHT) {
     python.setDir(1, 0);
   }
   else if(keyCode == DOWN) {
     python.setDir(0, 1);
   }
}

void mousePressed() {
  if(mouseButton == RIGHT) {
    //meal.spawn();
    python.grow();
  }
}
