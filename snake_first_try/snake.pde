class Snake{
  ArrayList<PVector> body;
  IntList c;
  PVector dir;
  final int gradient;

  Snake(int n) {
    c = new IntList();
    body = new ArrayList<PVector>();
    dir = new PVector(0, -1);

    gradient = 5;
    for(int i = 0; i < n; i++) {
      int temp_x = l*int((width/2)/l) + int(i*l*dir.x);
      int temp_y = l*int((height/2)/l) + int(i*l*dir.y);
      body.add(new PVector(temp_x, temp_y));
      //c.append(int(random(255)));
      c.append(body.size() * gradient % 255);
    }
  }
  
  void grow() {
    float x = body.get(body.size()-1).x;
    float y = body.get(body.size()-1).y;
    x += dir.x*l;
    y += dir.y*l;
    body.add(new PVector(x, y));
    c.append(body.size() * gradient % 255);
    
    loopAround(body.size()-1);
  }
  
  void setDir(int x1, int y1) {
    int head = body.size()-1;
    if(body.get(head-1).x == body.get(head).x+x1*l && body.get(head-1).y == body.get(head).y+y1*l)
      return;
    
    //if(x1 < 0 && dir.x > 0) //<>//
    //  return;
    //if(x1 > 0 && dir.x < 0) //<>//
    //  return;
    //if(y1 < 0 && dir.y > 0) //<>//
    //  return;
    //if(y1 > 0 && dir.y < 0) //<>//
    //  return;
      
    dir.x = x1;
    dir.y = y1;
  }
  
  void move() {
     for(int i = 0; i < body.size()-1; i++) {
       body.get(i).x = body.get(i+1).x;
       body.get(i).y = body.get(i+1).y;
       loopAround(i);
     }
     
    int head = body.size()-1;
    body.get(head).x += dir.x*l;
    body.get(head).y += dir.y*l;
    loopAround(head);
  }
  
  void loopAround(int i) {
       float temp_x = body.get(i).x;
       float temp_y = body.get(i).y;
       if(temp_x < 0)
         body.get(i).x = width-l;
       else if(temp_x >= width)
         body.get(i).x = 0;
         
       if(temp_y < 0)
         body.get(i).y = height-l;
       else if(temp_y >= height)
         body.get(i).y = 0; 
  }
    
  void render() {
    colorMode(HSB);
    pushMatrix();
    noStroke();
    int i;
    for(i = 0; i < body.size()-1; i++) {
      fill(c.get(i), 200, 255);
      rect(body.get(i).x, body.get(i).y, l, l);
    }
    strokeWeight(5);
    stroke(0, 0, 255);
    fill(c.get(i), 200, 255);
    rect(body.get(i).x, body.get(i).y, l, l);
    popMatrix();
    colorMode(RGB);
  }
}
