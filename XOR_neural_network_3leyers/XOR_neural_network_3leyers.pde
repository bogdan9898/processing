NNetwork nn;
float[][] inputs;
float[][] targets;
//final int MAX_TRAINING_IT = 100000; 
int sampleSize = 100000;
int trainingSessions = 0;
Screen[] s;
boolean isTraining = false;
boolean cursorText, cursorHand;
TextBox focusedTextBox = null;

//TODO:
//debug info
//single gui manager
//inherited gui boxes

void setup() {
  size(1280, 720);
  //fullScreen();
  strokeWeight(2);//default strokeWeight is too thin

  nn = new NNetwork(2, 4, 1);
  nn.randomize();
  nn.printData();

  setupDataSet();
  setupAllScreens();
}

void draw() {
  cursorText = false;
  cursorHand = false;
  for (int i = 0; i < s.length; i++) {
    s[i].checkGUIElements(mouseX, mouseY);
  }

  setCursor();

  background(#D7DE33);
  for (int i = 0; i < s.length; i++)
    s[i].render();

  pushStyle();
  strokeWeight(5);
  stroke(0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  textAlign(LEFT);
  textSize(20);
  text("FPS: "+(int)frameRate, 5, 20);
  popStyle();
}

void trainNN() {
  isTraining = true;
  println("Thread started");
  for (int i = 0; i < sampleSize; i++) {
    int rand = floor(random(4));
    nn.train(inputs[rand], targets[rand]);
  }
  trainingSessions++;
  //((Xor2DVisualization)s[1]).generateImg();DON'T UNCOMMENT!!! IT'S GLITCHY AF!!! W.I.P.
  //((NNVisualization)s[3]).drawNN(); W.I.P.
  isTraining = false;
  println("Thread stopped\n");
}

void mousePressed() {
  for (int i = 0; i < s.length; i++)
    s[i].click(mouseX, mouseY);
}

void mouseReleased() {
  for (int i = 0; i < s.length; i++)
    s[i].release();
}

void keyPressed() {
  //println(keyCode);
  if (focusedTextBox != null) {
    focusedTextBox.write(key);
    if (keyCode == 10) {
      focusedTextBox.release();
      //sampleSize = Integer.valueOf(focusedTextBox.buffer.toString());
      //println("Sample size changed to", focusedTextBox.buffer.toString()+"("+sampleSize+")");
      focusedTextBox = null;
    }
  } else
    //if (key == ' ' && !isTraining) {
    //  thread("trainNN");
    //} else
    switch(key) {
    case '1':
      s[0].on = !s[0].on;
      break;
    case '2':
      s[1].on = !s[1].on;
      break;
    case '3':
      s[2].on = !s[2].on;
      break;
    case '4':
      s[3].on = !s[3].on;
      break;
    case 'q':
      noLoop();
      break;
    case 'a':
      nn.printData();
      break;
    case 's':
      if (!isTraining) {
        println("Training sessions completed:", trainingSessions);
        for (int i = 0; i < 4; i++) {
          println(inputs[i][0], inputs[i][1], "=>", 
            nn.getOutput(inputs[i]).data[0][0]);
        }
        println();
        ((NNVisualization)s[3]).drawNN();
      } else {
        println("NN in training...");
      }
      break;
    }
}

void setupDataSet() {
  inputs = new float[4][2];
  inputs[0] = new float[]{0, 0};
  inputs[1] = new float[]{0, 1};
  inputs[2] = new float[]{1, 0};
  inputs[3] = new float[]{1, 1};

  targets = new float[4][1];
  targets[0] = new float[]{0};
  targets[1] = new float[]{1};
  targets[2] = new float[]{1};
  targets[3] = new float[]{0};
}

void setupAllScreens() {
  s = new Screen[4];
  s[0] = new StatusScreen(0, 0, width/2, height/2);
  s[1] = new Xor2DVisualization(width/2, 0, width/2, height/2);
  s[2] = new InteractiveScreen(0, height/2, width/2, height/2);
  s[3] = new NNVisualization(width/2, height/2, width/2, height/2);
}

void setCursor() {
  if (cursorHand)
    cursor(HAND);
  else if (cursorText)
    cursor(TEXT);
  else
    cursor(ARROW);
}