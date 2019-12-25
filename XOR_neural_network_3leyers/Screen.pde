class Screen {
  float x, y;
  float sWidth, sHeight;
  PImage defaultImg;
  boolean on;

  Screen(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    sWidth = w;
    sHeight = h;
    defaultImg = loadImage("standby.jpg");
    defaultImg.resize(int(sWidth), int(sHeight));
    on = true;
  }

  void render() {
    image(defaultImg, x, y);
  }

  void checkGUIElements(int mx, int my) {
  }

  void click(int mx, int my) {
  }

  void release() {
  }
}