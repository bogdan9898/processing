class Grid {
  int i;
  int j;
  int value;
  boolean isRevealed;
  boolean isBomb;
  boolean isFlag;

  Grid(int i, int j) {
    this.i = i;
    this.j = j;
    value = 0;
    isRevealed = false;
    isBomb = false;
    isFlag = false;
  }

  void reset() {
    value = 0;
    isRevealed = false;
    isBomb = false;
    isFlag = false;
  }
}