final int startImages = 16;
final int startLabels = 8;
int k1 = startImages;
int k2 = startLabels;
byte[] images, labels;

void setup() {
  size(280, 280);
  images = loadBytes("train-images.idx3-ubyte");
  labels = loadBytes("train-labels.idx1-ubyte");
}

void draw() {
}

void mousePressed() {
  PImage tmp = createImage(28, 28, RGB);
  tmp.loadPixels();
  for (int i = 0; i < 784; i++) {
    tmp.pixels[i] = color(images[i+k1] & 0xff);
  }
  for (int i = 0; i < 28; i++) {
    for (int j = 0; j < 28; j++) {
      print(red(tmp.pixels[i*28 + j]), " ");
    }
    println();
  }
  tmp.updatePixels();
  image(tmp, 0, 0);
  println(labels[k2]);
  k1 += 784;
  k2++;
}