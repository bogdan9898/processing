class BLOCKS {
  float x;
  float y;

  BLOCKS(float x, float y) {
    this.x = x;
    this.y = y;
  }

  boolean chkCollision(float x, float y, int size, float speed) {
    if ((x-10 > this.x - bWidth/2 && x-10 < this.x + bWidth/2) || 
      (x+10 > this.x - bWidth/2 && x+10 < this.x + bWidth/2)) {
      //debugging
      //fill(255, 0, 0);
      //ellipse(this.x, this.y, 50, 50);
      //debugging
      if (y+20 > this.y - bHeight/2 && y+20 < this.y + bHeight/2 && speed >= 0) {
        //debugging
        //fill(255, 255, 0);
        //rect(this.x, this.y, 75, 75);
        //debugging
        return true;
      }
    }
    return false;
  }

  void fall(float speed) {
    y -= speed;
  }

  void render() {
    //strokeWeight(1.5);
    fill(175, 250, 0);
    rect(x, y, bWidth, bHeight);
    //debugging
    //fill(0, 175, 250);
    //ellipse(x, y, bHeight, bHeight);
    //debugging
  }
}