class LampE extends AbstractLamp{
  LampE(int s, int x, int y, int i){
    super(s, x, y, 0, 255, 0);
    index = i;
  }
  
  
  void update(){
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
}
