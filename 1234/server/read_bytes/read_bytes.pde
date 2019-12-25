import processing.net.*;

Client client;
Server server;
String s;
int index;
char data;

void setup() {
  size(400, 400);
  frameRate(30);
  textAlign(CENTER,CENTER);
  textSize(30);
  fill(0);
  server = new Server(this, 12345);
}

void draw() {
  client = server.available();
  if (client != null) {
    s = client.readString();
    //println("s:", s);
    index = int(s.substring(0, s.indexOf(" ")));
    s = s.substring(s.indexOf(" ")+1, s.indexOf("\n"));
    background(200);
    text(client.ip()+": ["+index+"]= " + s, width/2, height/2);
  }
}

void keyPressed() {
  if (key == '.') {
    server.stop();
    exit();
  }
}