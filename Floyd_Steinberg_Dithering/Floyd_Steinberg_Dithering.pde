PImage img;
int fact = 1;

void setup() {
  //size(598, 358);
  //img = loadImage("kurt.jpg");
  size(1280, 426);
  img = loadImage("david.jpg");
  image(img, 0, 0);
  img.filter(GRAY);
  img.loadPixels();
  for (int j = 0; j < img.height - 1; j++) {
    for (int i = 1; i < img.width - 1; i++) {
      color oldpixel = img.pixels[index(i, j)];
      dithering(index(i, j));
      color quant_error = calc_quant_error(oldpixel, img.pixels[index(i, j)]);
      add_quant_error(index(i+1, j), quant_error, 7/16.0);
      add_quant_error(index(i-1, j+1), quant_error, 3/16.0);
      add_quant_error(index(i, j+1), quant_error, 5/16.0);
      add_quant_error(index(i+1, j+1), quant_error, 1/16.0);
    }
  }
  img.updatePixels();
}

void draw() {
  image(img, width/2, 0);
}

void dithering (int index) {

  float r = red(img.pixels[index]);
  float g = green(img.pixels[index]);
  float b = blue(img.pixels[index]);

  r = round(fact * r/255) * (255/fact);
  g = round(fact * g/255) * (255/fact);
  b = round(fact * b/255) * (255/fact);

  img.pixels[index] = color(int(r), int(g), int(b));
}

void add_quant_error(int index, color quant, float ratio) {

  float r = red(img.pixels[index]);
  float g = green(img.pixels[index]);
  float b = blue(img.pixels[index]);

  r += red(quant) * ratio;
  g += green(quant) * ratio;
  b += blue(quant) * ratio;
  
  img.pixels[index] = color(int(r), int(g), int(b));
}

color calc_quant_error(color c1, color c2) {

  float r = red(c1) - red(c2);
  float g = green(c1) - green(c2);
  float b = blue(c1) - blue(c2);
  
  return color(r, g, b);
}

int index(int i, int j) {
  return i + j * img.width;
}