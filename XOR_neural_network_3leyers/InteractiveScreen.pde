class InteractiveScreen extends Screen {
  TextBox in1, in2;
  Button feedInputs;
  float output;

  InteractiveScreen(float x, float y, float w, float h) {
    super(x, y, w, h);

    in1 = new TextBox(x+sWidth/4, y+sHeight/3, 125, 42, CENTER);
    in2 = new TextBox(x+sWidth/4, y+2*sHeight/3, 125, 42, CENTER);
    textSize(100);
    feedInputs = new Button(x+sWidth/2, y+sHeight/2, 100, 107, "=>", CENTER);
  }

  void render() {
    if (on) {
      fill(255);
      rect(x+3*sWidth/4, y+sHeight/2, 125, 42);//outputBox
      textSize(35);
      fill(255, 0, 0);
      text(output, x+3*sWidth/4, y+sHeight/2);

      in1.render();
      in2.render();
      feedInputs.render();


      //textAlign(CENTER);
      //textSize(100);
      //fill(0);
      //text("=>", x+sWidth/2, y+sHeight/2+textDescent());//button
      //println(textAscent()+textDescent());

      //printGrid();
    } else
      super.render();
  }

  void printGrid() {
    pushMatrix();
    translate(x, y);

    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(sWidth/4, sHeight/3, 125, 42);//textSize(35)//textBox
    rect(sWidth/4, 2*sHeight/3, 125, 42);//textBox
    rect(3*sWidth/4, sHeight/2, 125, 42);//outputBox
    rectMode(CORNER);

    stroke(0, 255, 0);
    line(0, sHeight/3, sWidth, sHeight/3);
    line(sWidth/4, 0, sWidth/4, sHeight);
    line(0, 2*sHeight/3, sWidth, 2*sHeight/3);
    //line(sWidth/4, 0, sWidth/4, sHeight);
    line(0, sHeight/2, sWidth, sHeight/2);
    line(3*sWidth/4, 0, 3*sWidth/4, sHeight);
    noStroke();
    fill(255, 0, 0);
    ellipse(sWidth/4, sHeight/3, 10, 10);
    ellipse(sWidth/4, 2*sHeight/3, 10, 10);
    ellipse(3*sWidth/4, sHeight/2, 10, 10);

    //stroke(255, 255, 0);
    //line(0, sHeight/2-textAscent()+textDescent(), sWidth, sHeight/2-textAscent()+textDescent());
    //line(0, sHeight/2+textDescent(), sWidth, sHeight/2+textDescent());

    popMatrix();
  }

  void checkGUIElements(int mx, int my) {
    checkTextBox(mx, my);
    checkButton(mx, my);
  }

  void checkTextBox(int mx, int my) {
    if (in1.hover(mx, my)) {
      cursorText = true;
      in1.hover = true;
    } else
      in1.hover = false;

    if (in2.hover(mx, my)) {
      cursorText = true;
      in2.hover = true;
    } else
      in2.hover = false;
  }

  void checkButton(int mx, int my) {
    if (feedInputs.hover(mx, my)) {
      cursorHand = true;
      feedInputs.hover = true;
    } else
      feedInputs.hover = false;
  }

  void click(int mx, int my) {
    if (in1.hover(mx, my)) {
      if (focusedTextBox != null)
        focusedTextBox.release();
      focusedTextBox = in1;
      in1.click();
    }

    if (in2.hover(mx, my)) {
      if (focusedTextBox != null)
        focusedTextBox.release();
      focusedTextBox = in2;
      in2.click();
    }

    float a = 0, b = 0;
    if (feedInputs.hover(mx, my)) {
      if (in1.clicked || in2.clicked) {
        in1.release();
        in2.release();
        focusedTextBox = null;
      }
      if (focusedTextBox != null) {
        focusedTextBox.release();
        focusedTextBox = null;
      }
      if (in1.buffer.length() > 0)
        a = Float.valueOf(in1.buffer.toString());
      if (in2.buffer.length() > 0)
        b = Float.valueOf(in2.buffer.toString());
      feedInputs.click();
      //create inputs array and get the output from nn
      float input[] = {a, b};
      println("[", input[0]+",", input[1], "]");
      output = nn.getOutput(input).data[0][0];
      ((NNVisualization)s[3]).drawNN();
    }
  }

  void release() {
    feedInputs.release();
  }
}