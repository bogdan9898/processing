import processing.net.*;
import java.net.ConnectException;

Client client;
String input;
int data[];

void setup() {
  size(400, 400);
  frameRate(30);
  client = new Client(this, "127.0.0.1", 12345);
  if (client.active()) {
    println("client opened successfully");
  } else {
    println("client failed");
  }
}

void draw() {
}

void keyPressed() {
  if ((key >= 'a' && key <= 'z') || 
    (key >= 'A' && key <= 'Z') || 
    (key >= '0' && key <= '9')) {
    if (client.active()) {
      println(key);
      client.write(400 + " " + key + "\n");
    }
  }
  if (key == '/') {
    println("starting new client");
    client = new Client(this, "127.0.0.1", 12345);
    if (client.active()) {
      println("client opened successfully");
    } else {
      println("client failed");
    }
  }
  if (key == '.') {
    println("closing client");
    client.stop();
    exit();
  }
}