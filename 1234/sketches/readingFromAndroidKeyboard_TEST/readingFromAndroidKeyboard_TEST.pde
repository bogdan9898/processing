StringBuilder ip;
float prevX = 0, prevY = 0;
PGraphics img, txtBox;
float bx1, by1, w1, h1;
float bx2, by2, w2, h2;


//import processing.net.*; 
//Client c;

void setup() {
  size(720, 900); //size(720, 1280); fullscreen();
  noStroke();
  imageMode(CENTER);
  ip = new StringBuilder();

  bx1 = 1*width/9.0;
  by1 = 8.5*height/10.0;
  println(by1);
  w1 = width/3;
  h1 = height/15;

  bx2 = 5*width/9.0;
  by2 = 8.5*height/10.0;
  println(by2);
  w2 = width/3;
  h2 = height/15;

  txtBox = createGraphics(400, 50);
  txtBox.beginDraw();
  txtBox.background(255);
  txtBox.fill(0);
  txtBox.textSize(50);
  txtBox.textAlign(CENTER, CENTER);
  txtBox.text("000.000.000.0", txtBox.width/2, txtBox.height/2);
  txtBox.endDraw();

  img = createGraphics(560, 560);
  img.beginDraw();
  img.background(0);
  img.strokeWeight(25);
  img.stroke(255);
  img.endDraw();

  //c = new Client(this, ip, 12345); // Replace with your server’s IP and port

  fill(255, 0, 0);
  rect(bx1, by1, w1, h1);
  rect(bx2, by2, w2, h2);
}

void draw() {
  prevX = mouseX - (width/2 - img.width/2);
  prevY = mouseY - (height/2 - img.height/2);
  image(img, width/2, height/2);
  image(txtBox, width/2, txtBox.height/2);
}

void mouseDragged() {
  img.beginDraw();
  img.line(mouseX - (width/2 - img.width/2), mouseY - (height/2 - img.height/2), prevX, prevY);
  img.endDraw();
}

void keyPressed() {
  //println("keyCode:", keyCode);
  if (keyCode == 10) {//enter
    sendImgBuffer();
    clearImgBuffer();
    println("ip:", ip);
  } else if (keyCode == 8) {//backspace
    if (ip.length() > 0) {
      ip.delete(ip.length()-1, ip.length());
      updateTxtBox();
    }
    println("ip:", ip);
  } else {
    if ((key >= '0' && key <= '9') || key == '.') {
      ip.append(char(keyCode));
      updateTxtBox();
    }
    println("ip:", ip);
  }
}

void clearImgBuffer() {
  println("clear");
  img.beginDraw();
  img.background(0);
  img.endDraw();
}

void sendImgBuffer() {
  println("send");
  PImage drawing = img.get();
  drawing.resize(28, 28);
  image(drawing, 14, 14);
}

void updateTxtBox() {
  txtBox.beginDraw();
  txtBox.background(255);
  txtBox.text(ip.toString(), txtBox.width/2, txtBox.height/2);
  txtBox.endDraw();
}