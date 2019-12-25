class NNetwork {
  Matrix i;
  Matrix h;
  Matrix o;
  Matrix wih;
  Matrix who;
  Matrix bh;
  Matrix bo;
  float lr;

  NNetwork(int nrInputs, int nrHidden, int nrOutputs) {
    i = new Matrix("input", nrInputs, 1);
    h = new Matrix("hidden", nrHidden, 1);
    o = new Matrix("output", nrOutputs, 1);
    wih = new Matrix("weights_input->hidden", nrHidden, nrInputs);
    who = new Matrix("weights_hidden->output", nrOutputs, nrHidden);
    bh = new Matrix("biases_hidden", nrHidden, 1);
    bo = new Matrix("biases_output", nrOutputs, 1);
    lr = 0.1;
  }

  NNetwork(int nrInputs, int nrHidden, int nrOutputs, float learnRate) {
    i = new Matrix("input", nrInputs, 1);
    h = new Matrix("hidden", nrHidden, 1);
    o = new Matrix("output", nrOutputs, 1);
    wih = new Matrix("weights_input->hidden", nrHidden, nrInputs);
    who = new Matrix("weights_hidden->output", nrOutputs, nrHidden);
    bh = new Matrix("biases_hidden", nrHidden, 1);
    bo = new Matrix("biases_output", nrOutputs, 1);
    lr = learnRate;
  }


  Matrix getOutput(float[] inputArray) {
    if (inputArray.length != i.rows) {
      println("Input array must have "+i.rows+" elements");
      return null;
    }
    i = arrayToSingleCollomMatrix(inputArray, "input");
    h = wih.multiply(i);
    h = h.add(bh);
    h = h.sigmoid();
    o = who.multiply(h);
    o = o.add(bo);
    o = o.sigmoid();
    resetNames();
    return o;
  }


  void train(float[] inputArray, float[] targetArray) {
    //TODO: backpropagation algorithm
    if (inputArray.length != i.rows || targetArray.length != o.rows) {
      println("Input array must have "+i.rows+" elements");
      println("Target array must have "+o.rows+" elements");
      return;
    }
    Matrix eh = new Matrix("error_hidden", h.rows, h.cols);
    Matrix eo = new Matrix("error_output", o.rows, o.cols);

    Matrix dwih = new Matrix("delta_weights_input_hidden", wih.rows, wih.cols);
    Matrix dwho = new Matrix("delta_weights_hidden_output", who.rows, who.cols);

    Matrix dbh = new Matrix("delta_biases_hidden", bh.rows, bh.cols);
    Matrix dbo = new Matrix("delta_biases_output", bo.rows, bo.cols);

    Matrix gh = new Matrix("gradient_hidden", eh.rows, eh.cols);
    Matrix go = new Matrix("gradiend_output", eo.rows, eo.cols);

    Matrix targetMatrix = arrayToSingleCollomMatrix(targetArray, "target_matrix");
    Matrix guess = getOutput(inputArray);
  
    //calc output error
    eo = targetMatrix.sub(guess);
    
    //calc output gradient
    go = eo.multiplyElemByElem(o.dSigmoid());
    go = go.multiply(lr);
    
    //calc output weights delta
    dwho = go.multiply(h.transpose());
    
    //calc output biases delta
    dbo = go;
    
    //apply delta to hidden->output weights
    who = who.add(dwho);
    
    //apply delta to output biases
    bo = bo.add(dbo);
    
//########################################################################

  //calc hidden error
  eh = who.transpose().multiply(eo);
  
  //calc hidden gradient
  gh = eh.multiplyElemByElem(h.dSigmoid());
  gh = gh.multiply(lr);
  
  //calc hidden weights delta
  dwih = gh.multiply(i.transpose());
  
  //calc hidden biasses delta
  dbh = gh;
  
  //apply delta to input->hidden weights
  wih = wih.add(dwih);
  
  //apply delta to hidden biases
  bh = bh.add(dbh);
  
  resetNames();
  
}


  void randomize() {
    print("Randomizing...");
    wih.randomize();
    who.randomize();
    bh.randomize();
    bo.randomize();
    print("Done\n");
  }


  void printData() {
    println("\n#####Network data#####\n");
    wih.printMatrix();
    who.printMatrix();
    bh.printMatrix();
    bo.printMatrix();
    println("######################\n");
  }


  void resetNames() {
    i.setName("input");
    h.setName("hidden");
    o.setName("output");
    wih.setName("weights_input->hidden");
    who.setName("weights_hidden->output");
    bh.setName("bias_hidden");
    bo.setName("bias_output");
  }
}