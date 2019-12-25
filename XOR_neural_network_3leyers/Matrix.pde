class Matrix {
  String name;
  int rows;
  int cols;
  float[][] data;

  Matrix(String name, int rows, int cols) {
    this.name = name;
    this.rows = rows;
    this.cols = cols;
    data = new float[rows][cols];
  }


  void randomize() {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        data[i][j] = random(2) - 1;
  }


  Matrix add(Matrix b) {
    if (rows != b.rows || cols != b.cols) {
      println("Add failed: nr of A's rows("+rows+")/cols("+cols+") and B's rows("+b.rows+")/cols("+b.cols+") must be equal");
      return null;
    }
    Matrix temp = new Matrix(name + "+" + b.name, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = data[i][j] + b.data[i][j];
    return temp;
  }


  Matrix sub(Matrix b) {
    if (rows != b.rows || cols != b.cols) {
      println("Sub failed: nr of A's rows("+rows+")/cols("+cols+") and B's rows("+b.rows+")/cols("+b.cols+") must be equal");
      return null;
    }
    Matrix temp = new Matrix(name + "-" + b.name, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = data[i][j] - b.data[i][j];
    return temp;
  }


  Matrix transpose() {
    Matrix temp = new Matrix(name + " transposed", cols, rows);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[j][i] = data[i][j];
    return temp;
  }


  Matrix multiply(Matrix b) {
    if (cols != b.rows) {
      println("Multiply failed: A's cols("+cols+") must be equal to B's rows("+b.rows+")");
      return null;
    }
    Matrix temp = new Matrix(name + "*" + b.name, rows, b.cols);
    for (int i = 0; i < temp.rows; i++)
      for (int j = 0; j < temp.cols; j++) {
        float res = 0;
        for (int k = 0; k < cols; k++)
          res+= data[i][k] * b.data[k][j];
        temp.data[i][j] = res;
      }
    return temp;
  }


  Matrix multiply(int b) {
    Matrix temp = new Matrix(name + "*" + b, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = data[i][j]*b;
    return temp;
  }


  Matrix multiply(float b) {
    Matrix temp = new Matrix(name + "*" + b, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = data[i][j]*b;
    return temp;
  }


  Matrix multiplyElemByElem(Matrix b) {
    if (rows != b.rows || cols != b.cols) {
      println("MultiplyElemByElem failed: nr of A's rows("+rows+")/cols("+cols+") and B's rows("+b.rows+")/cols("+b.cols+") must be equal");
      return null;
    }
    Matrix temp = new Matrix(name + "*" + b.name, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = data[i][j] * b.data[i][j];
    return temp;
  }


  Matrix sigmoid() {
    Matrix temp = new Matrix("sigmoid " + name, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = 1/(1 + exp(-data[i][j]));
    return temp;
  }

  Matrix dSigmoid() {
    Matrix temp = new Matrix("dSigmoid " + name, rows, cols);
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        temp.data[i][j] = data[i][j] * (1 - data[i][j]);
    return temp;
  }


  void setName(String name) {
    this.name = name;
  }


  void printMatrix() {
    println("Matrix", name, "is:");
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++)
        print(data[i][j], "");
      println();
    }
    println();
  }
}

Matrix arrayToSingleCollomMatrix(float[] array, String name) {
  Matrix temp = new Matrix(name, array.length, 1);
  for (int i = 0; i < temp.rows; i++)
    temp.data[i][0] = array[i];
  return temp;
}

Matrix arrayToSingleCollomMatrix(int[] array, String name) {
  Matrix temp = new Matrix(name, array.length, 1);
  for (int i = 0; i < temp.rows; i++)
    temp.data[i][0] = float(array[i]);
  return temp;
}