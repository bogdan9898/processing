class StatusScreen extends Screen {
  String[] progressText;
  int pIt;
  TextBox sampleSizeTextBox;
  Button trainButton;

  StatusScreen(float x, float y, float w, float h) {
    super(x, y, w, h);
    pIt = 4;
    progressText = new String[5];
    progressText[0] = "Training   ";
    progressText[1] = "Training.  ";
    progressText[2] = "Training.. ";
    progressText[3] = "Training...";
    progressText[4] = "Not training";

    textSize(35);//for a specific value of textAscent()+textDescent()
    sampleSizeTextBox = new TextBox(sWidth/2, 2*sHeight/3-textAscent(), 225, textAscent()+textDescent(), CORNER);

    trainButton = new Button(sWidth/2, 5*sHeight/6, sWidth/2, 50, "Train now", CENTER);
  }

  void render() {
    if (on) {
      setpIt();
      textAlign(CENTER);
      textSize(100);
      fill(255);
      text(progressText[pIt], sWidth/2, sHeight/3+textDescent());

      textAlign(RIGHT);
      textSize(35);
      text("Sample size: ", sWidth/2, 2*sHeight/3);

      //rect(sWidth/2, 2*sHeight/3-textAscent(), 225, textAscent()+textDescent());//textBox

      //stroke(0, 0, 255);
      //line(0, 2*sHeight/3, sWidth, 2*sHeight/3);
      //noStroke();

      //rectMode(CENTER);
      //rect(sWidth/2, 5*sHeight/6, sWidth/2, 50);//button

      sampleSizeTextBox.render();
      trainButton.render();

      //printGrid();
    } else
      super.render();
  }

  void setpIt() {
    if (!isTraining)
      pIt = 4;
    else if (frameCount%17 == 0)//slow down the animation
      pIt = frameCount%4;
  }

  void printGrid() {
    pushMatrix();
    translate(x, y);

    stroke(0, 255, 0);
    line(0, sHeight/2, sWidth, sHeight/2);
    line(sWidth/2, 0, sWidth/2, sHeight);
    noStroke();
    fill(255, 0, 0);
    ellipse(sWidth/2, sHeight/2, 10, 10);

    //stroke(255, 255, 0);
    //line(0, sHeight/2-textAscent()+textDescent(), sWidth, sHeight/2-textAscent()+textDescent());
    //line(0, sHeight/2+textDescent(), sWidth, sHeight/2+textDescent());

    popMatrix();
  }

  void checkGUIElements(int mx, int my) {
    checkTextBox(mx, my);
    checkButton(mx, my);
  }

  void checkButton(int mx, int my) {
    if (trainButton.hover(mx, my)) {
      cursorHand = true;
      trainButton.hover = true;
    } else
      trainButton.hover = false;
  }

  void checkTextBox(int mx, int my) {
    if (sampleSizeTextBox.hover(mx, my)) {
      cursorText = true;
      sampleSizeTextBox.hover = true;
    } else
      sampleSizeTextBox.hover = false;
  }

  void click(int mx, int my) {
    if (sampleSizeTextBox.hover(mx, my)) {
      if (focusedTextBox != null)
        focusedTextBox.release();
      focusedTextBox = sampleSizeTextBox;
      sampleSizeTextBox.click();
    }
    if (trainButton.hover(mx, my)) {
      if (sampleSizeTextBox.clicked) {//focusedTextBox != null
        sampleSizeTextBox.release();
        focusedTextBox = null;
      }
      if (focusedTextBox != null) {
        focusedTextBox.release(); 
        focusedTextBox = null;
      }
      if (sampleSizeTextBox.buffer.length() > 0) {
        sampleSize = Integer.valueOf(sampleSizeTextBox.buffer.toString());
        println("Sample size changed to", sampleSizeTextBox.buffer.toString()+"("+sampleSize+")");
      }
      trainButton.click();
      if (!isTraining)
        thread("trainNN");
    }
  }

  void release() {
    trainButton.release();
  }
}