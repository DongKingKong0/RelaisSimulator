abstract class AbstractLamp{
  
  int size;
  int xpos, ypos;
  int value;
  int index;
  color lampColor;
  boolean status;
  boolean showDescription;
  boolean clickable;
  
  AbstractLamp(int s, int x, int y, int r, int g, int b){
    size = s;
    xpos = x;
    ypos = y;
    lampColor = color(r, g, b);
    clickable = true;
  }
  
  
  void update(){
    if(mousePressed && !pmousePressed && clickable && pointInCircle(mouseX, mouseY, xpos, ypos, size + 5)){
      status = !status;
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
