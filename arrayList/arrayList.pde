ArrayList cells = new ArrayList();

void setup(){
  size(500, 500); 
  cells.add(1);
  cells.add(2);
}

void draw(){
  for(int i = cells.size()-1; i >= 0; i--){
    println(cells.get(i));
  }
}