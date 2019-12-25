class PARTICLE {
  PVector pos;
  PVector speed;
  PVector acc;
  float speedLimit = 2;
  PVector prev;
  int hu = 0;

  PARTICLE() {
    pos = new PVector(random(width), random(height));
    speed = new PVector(random(1), random(1));
    acc = new PVector();
    prev = pos.copy();
  }

  void move() {
    pos.add(speed);
    speed.add(acc);
    speed.limit(speedLimit);
    acc.mult(0);
  }

  void push(PVector force) {
    acc.add(force);
  }

  void stream() {
    //println(floor(pos.x/_scale), floor(pos.y/_scale));
    if (floor(pos.x/_scale) < cols && floor(pos.y/_scale) < rows) {
      push(field[floor(pos.x/_scale)][floor(pos.y/_scale)]);
    }
  }

  void edge() {
    if (pos.x < 0) {
      pos.x = width;
      updatePrev();
    }
    if (pos.x >  width) {
      pos.x = 0;
      updatePrev();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePrev();
    }
    if (pos.y >  height) {
      pos.y = 0;
      updatePrev();
    }
  }

  void updatePrev() {
    prev.x = pos.x;
    prev.y = pos.y;
  }

  void show() {
    strokeWeight(1);
    stroke(hu%255, 255, 255, 5);
    hu += 1;
   //stroke(255, 5);
    line(pos.x, pos.y, prev.x, prev.y);
    updatePrev();
  }
}