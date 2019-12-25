package processing.test.sketch_180504b;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_180504b extends PApplet {

public void setup() {
  
  strokeWeight(4);
}

float prevX = 0, prevY = 0;
PImage img;

public void draw() {
  if(mousePressed){
    prevX = mouseX;
    prevY = mouseY;
  }
}

public void mouseDragged(){
  line(mouseX, mouseY, prevX, prevY);
}

public void keyPressed() {
  if (key == 'r') {
    img = get();
    img.resize(28, 28);
    image(img, 0, 0);
  }
  if (key == 'l') {
    println("Opening test process");
    //launch("C:\\Users\\Asus\\Desktop\\testPythonLaunch.py");
  }
}
  public void settings() {  size(560, 560); }
}
