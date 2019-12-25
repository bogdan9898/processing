boolean isAiming = false; 
boolean arrowIsFlying = false;
WEAPON weapon;
Arrow arrow;

//DELETE SETTINGS!!!!!!!
void settings() {
  float w = 720;  
  float ratioW = 0.5;
  float h = 1280; 
  float ratioH = 0.5;
  size(int(w*ratioW), int(h*ratioH));
}

void setup() {
  //size(720,1280);
  fullScreen();
}

void draw() {
  background(255);
  noStroke();
  fill(255, 0, 100);
  rect(0, height-50, width, height);

  if (isAiming) {
    weapon.aim();
    arrow.show();
  }

  if (arrowIsFlying) {
    arrow.HBShot();
  }
}

void mousePressed() {
  if (!isAiming && !arrowIsFlying) {
    weapon = new WEAPON(mouseX, mouseY);
    isAiming = true; //println("isAiming while mouse pressed=", aiming);
  }
}

void mouseReleased() {
  isAiming = false; //println("isAiming upon mouse released =", aiming);
  arrowIsFlying = true;
}