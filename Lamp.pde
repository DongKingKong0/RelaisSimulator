class Lamp{
  
  int size;
  int xpos, ypos;
  int value;
  int index;
  color lampColor;
  boolean status;
  boolean showDescription;
  boolean clickable;
  
  Lamp(int s, int x, int y, int r, int g, int b, int i){
    size = s;
    xpos = x;
    ypos = y;
    lampColor = color(r, g, b);
    clickable = true;
    index = i;
  }
  
  
  void update(){
    if(mousePressed && !pmousePressed && clickable && pointInCircle(mouseX, mouseY, xpos, ypos, size + 5)){
      status = !status;
    }
  }
  
  
  void calculateStatus(){//for the "lampsE" array
    int numberOfActiveBits = 0;
    if(index > 0){
      if(lampsA[index - 1].getStatus()){
        numberOfActiveBits ++;
      }
      if(lampsB[index - 1].getStatus()){
        numberOfActiveBits ++;
      }
    }
    if(index < maxNumber){
      if(lampsU[index].getStatus()){
        numberOfActiveBits ++;
      }
    }
    
    if(numberOfActiveBits % 2 == 1){
      status = true;
    }else{
      status = false;
    }
    if(index > 0){
      if(numberOfActiveBits > 1){
        lampsU[index - 1].setStatus(true);
      }else{
        lampsU[index - 1].setStatus(false);
      }
    }
  }
  
  
  void draw(){
    if(status){
      fill(lampColor);
    }else{
      fill(lampColor, 32);
    }
    ellipse(xpos, ypos, size, size);
    if(showDescription){
      fill(200);
      textSize(size / 2);
      text("2^" + value, xpos, ypos - size);
    }
  }
  
  
  void setValue(int v, boolean s){
    value = v;
    showDescription = s;
  }
  
  
  void setValue(boolean s){
    showDescription = s;
  }
  
  
  void setStatus(boolean s){
    status = s;
  }
  
  
  void setUnclickable(){
    clickable = false;
  }
  
  
  boolean getStatus(){
    return status;
  }
}
