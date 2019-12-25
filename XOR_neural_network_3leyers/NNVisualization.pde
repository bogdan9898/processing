class NNVisualization extends Screen {
  PGraphics pg;
  int iNodes, hNodes, oNodes, layers;
  int ew, eb;

  NNVisualization(float x, float y, float w, float h) {
    super(x, y, w, h);
    iNodes = nn.i.rows;
    hNodes = nn.h.rows;
    oNodes = nn.o.rows;
    layers = 3;
    ew = 60;
    eb = ew/2;
    pg = createGraphics(int(w), int(h));
    drawNN();
  }

  void render() {
    if (on) {
      image(pg, x, y);
    } else
      super.render();
  }


  void drawNN() {
    pg.beginDraw();
    pg.textSize(15);
    pg.textAlign(CENTER);
    pg.strokeWeight(3);

    drawInputHiddenWeights();
    drawHiddenOutputWeights();
    drawInputLayer();
    drawHiddenLayer();
    drawOutputLayer();
    pg.textSize(10);
    drawHiddenBiases();
    drawOutputBiases();

    pg.endDraw();
  }


  void drawInputHiddenWeights() {
    float x1 = sWidth/(layers+1);
    float x2 = 2*sWidth/(layers+1);
    for (int i =0; i < nn.wih.cols; i++)
      for (int j = 0; j < nn.wih.rows; j++) {
        float y1 = (i+1)*sHeight/(iNodes+1);
        float y2 = (j+1)*sHeight/(hNodes+1);
        pg.stroke(map(nn.wih.data[j][i], -13, 13, 0, 255));
        pg.line(x1, y1, x2, y2);
      }
  }

  void drawHiddenOutputWeights() {
    float x1 = 2*sWidth/(layers+1);
    float x2 = 3*sWidth/(layers+1);
    for (int i = 0; i < nn.who.cols; i++)
      for (int j = 0; j < nn.who.rows; j++) {
        float y1 = (i+1)*sHeight/(hNodes+1);
        float y2 = (j+1)*sHeight/(oNodes+1);
        pg.stroke(map(nn.who.data[j][i], -13, 13, 0, 255));
        pg.line(x1, y1, x2, y2);
      }
  }

  void drawInputLayer() {
    pg.noStroke();
    float x = sWidth/(layers+1);
    for (int i = 0; i < iNodes; i++) {
      float y = (i+1)*sHeight/(iNodes+1);
      pg.fill(nn.i.data[i][0]*255);
      pg.ellipse(x, y, ew, ew);
      pg.fill(255, 0, 0);//#38BBDE//#00CAFF
      pg.text(nn.i.data[i][0], x, y+pg.textDescent());
    }
  }

  void drawHiddenLayer() {
    pg.noStroke();
    float x = 2*sWidth/(layers+1);
    for (int i = 0; i < hNodes; i++) {
      float y = (i+1)*sHeight/(hNodes+1);
      pg.fill(nn.h.data[i][0]*255);
      pg.ellipse(x, y, ew, ew);
      pg.fill(255, 0, 0);
      pg.text(nn.h.data[i][0], x, y+pg.textDescent());
    }
  }

  void drawOutputLayer() {
    pg.noStroke();
    float x = 3*sWidth/(layers+1);
    for (int i = 0; i < oNodes; i++) {
      float y = (i+1)*sHeight/(oNodes+1);
      pg.fill(nn.o.data[i][0]*255);
      pg.ellipse(x, y, ew, ew);
      pg.fill(255, 0, 0);
      pg.text(nn.o.data[i][0], x, y+pg.textDescent());
    }
  }

  void drawHiddenBiases() {
    float alfa = QUARTER_PI;//45 degrees
    float sinAlfa = sin(alfa);
    float cosAlfa = cos(alfa);
    float z = ew/2 + eb/2;

    float x = 2*sWidth/(layers+1) + cosAlfa*z;
    for (int i = 0; i < nn.h.rows; i++) {
      float y = (i+1)*sHeight/(hNodes+1) - sinAlfa*z;
      pg.fill(map(nn.bh.data[i][0], -10, 10, 0, 255));
      pg.ellipse(x, y, eb, eb);
      pg.fill(255, 0, 0);
      pg.text(nn.bh.data[i][0], x, y+pg.textDescent());
    }
  }

  void drawOutputBiases() {
    float alfa = QUARTER_PI;//45 degrees
    float sinAlfa = sin(alfa);
    float cosAlfa = cos(alfa);
    float z = ew/2 + eb/2;

    float x = 3*sWidth/(layers+1) + cosAlfa*z;
    for (int i = 0; i < nn.o.rows; i++) {
      float y = (i+1)*sHeight/(oNodes+1) - sinAlfa*z;
      pg.fill(map(nn.bo.data[i][0], -10, 10, 0, 255));
      pg.ellipse(x, y, eb, eb);
      pg.fill(255, 0, 0);
      pg.text(nn.bo.data[i][0], x, y+pg.textDescent());
    }
  }
}