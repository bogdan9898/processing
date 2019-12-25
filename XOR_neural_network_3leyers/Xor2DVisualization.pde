class Xor2DVisualization extends Screen {
  int imgNr;
  PImage img;

  Xor2DVisualization(float x, float y, float w, float h) {
    super(x, y, w, h);
    img = createImage(int(w), int(h), RGB);
    generateImg();
    imgNr = 0;
  }

  void render() {
    if (on) {
      if (imgNr < trainingSessions)
        generateImg();
      image(img, x, y);
    } else
      super.render();
  }

  void generateImg() {
    img.loadPixels();
    float[] in = new float[2];
    for (int i = 0; i < sWidth; i++)
      for (int j = 0; j < sHeight; j++) {
        in[0] = map(i, 0, sWidth, 0, 1);
        in[1] = map(j, 0, sHeight, 1, 0);
        float pixelColor = nn.getOutput(in).data[0][0];
        img.pixels[int(j*sWidth+i)] = color(map(pixelColor, 0, 1, 0, 255));
      }
    img.updatePixels();
    imgNr++;
  }
}