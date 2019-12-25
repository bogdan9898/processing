float[][] buffer1, buffer2;
float damping = 0.99;
int cols, rows;

void drawSquareInMatrix(int i, int j) {
  //buffer1[i][j] = 255;
  buffer1[i][j-1] = 255;
  buffer1[i+1][j-1] = 255;
  buffer1[i+1][j] = 255;
  buffer1[i+1][j+1] = 255;
  buffer1[i][j+1]= 255;
  buffer1[i-1][j+1] = 255;
  buffer1[i-1][j] = 255;
  buffer1[i-1][j-1] = 255;
}

void setup() {
  size(600, 600);
  cols = width;
  rows = height;
  buffer1 = new float[cols][rows];
  buffer2 = new float[cols][rows];
}

void draw() {
  background(0);
  //for (int i = 0; i < 3; i++)
  drawSquareInMatrix((int)random(width-2)+1, (int)random(height-2)+1);

  loadPixels();
  for (int i = 1; i < cols-1; i++) {
    for (int j = 1; j < rows-1; j++) {
      buffer2[i][j] = (buffer1[i-1][j] + buffer1[i+1][j] + buffer1[i][j+1] + buffer1[i][j-1]) / 2 - buffer2[i][j];
      buffer2[i][j] = buffer2[i][j] * damping;
      int index = j * cols + i;
      pixels[index] = color(buffer2[i][j]);
    }
  }
  updatePixels();

  float[][] tmp = buffer1;
  buffer1 = buffer2;
  buffer2 = tmp;
}