char[] ip;

void setup() {
  size(560, 560);
  strokeWeight(4);
  ip = new char[13];
  for (int i = 0; i < 13; i++) {
    ip[i] = '0';
  }
  ip[3] = '.';
  ip[7] = '.';
  ip[11] = '.';
}

float prevX = 0, prevY = 0;
PImage img;
boolean keyboard = false;

void draw() {
  if (mousePressed) {
    prevX = mouseX;
    prevY = mouseY;
    if (!keyboard) {
      showSoftKeyboard();
      keyboard = true;
    } else {
      hideSoftKeyboard();
      keyboard = false;
    }
  }
  fill(255, 0, 0);
  rect(0, 500, 600, 600);
}

void mouseDragged() {
  line(mouseX, mouseY, prevX, prevY);
}

void keyPressed() {
  println(keyCode);
  if (keyCode == 66) {
    printIP();
  }
}

void printIP() {
  println(ip);
}

import android.view.inputmethod.InputMethodManager;
import android.content.Context;

void showSoftKeyboard() {
  android.view.inputmethod.InputMethodManager imm = (android.view.inputmethod.InputMethodManager) getActivity().getSystemService(android.content.Context.INPUT_METHOD_SERVICE);
  imm.showSoftInput(getActivity().getCurrentFocus(), 0);
}

void hideSoftKeyboard() {
  android.view.inputmethod.InputMethodManager imm = (android.view.inputmethod.InputMethodManager) getActivity().getSystemService(android.content.Context.INPUT_METHOD_SERVICE);
  imm.hideSoftInputFromWindow(getActivity().getCurrentFocus().getWindowToken(), 0);
}
