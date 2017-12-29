void calculate(){
  for(int i = 0; i < lampsA.length; i ++){
    lampsA[i].update();
  }
  for(int i = 0; i < lampsB.length; i ++){
    lampsB[i].update();
  }
  for(int i = 0; i < lampsU.length; i ++){
    lampsU[i].update();
  }
  
  switch(mode){
    case 0:
    asPlus.setStatus(true);
    asMinus.setStatus(false);
    
    for(int i = 0; i < lampsE.length; i ++){
      lampsE[i].update();
      int numberOfActiveBits = 0;
      if(i > 0){
        if(lampsA[i - 1].getStatus()){
          numberOfActiveBits ++;
        }
        if(lampsB[i - 1].getStatus()){
          numberOfActiveBits ++;
        }
      }
      if(i < maxNumber){
        if(lampsU[i].getStatus()){
          numberOfActiveBits ++;
        }
      }
      
      if(numberOfActiveBits % 2 == 1){
        lampsE[i].setStatus(true);
      }else{
        lampsE[i].setStatus(false);
      }
      if(i > 0){
        if(numberOfActiveBits > 1){
          lampsU[i - 1].setStatus(true);
        }else{
          lampsU[i - 1].setStatus(false);
        }
      }
    }
    break;
    case 1:
    for(int i = 0; i < lampsU.length; i ++){
      lampsU[i].setStatus(false);
    }
    
    for(int i = 0; i < lampsE.length; i ++){
      lampsE[i].update();
      int numberOfActiveBits = 0;
      if(i > 0){
        if(lampsA[i - 1].getStatus()){
          numberOfActiveBits ++;
        }
        if(lampsB[i - 1].getStatus()){
          numberOfActiveBits ++;
        }
      }
      
      if(numberOfActiveBits == 1){
        lampsE[i].setStatus(true);
      }else{
        lampsE[i].setStatus(false);
      }
    }
    break;
  }
  
  switchPlus.update();
  switchMinus.update();
  switchMinus.setStatus(!switchPlus.getStatus());
  if(switchPlus.getStatus()){
    mode = 0;
  }else{
    mode = 1;
  }
  asPlus.update();
  asMinus.update();
}
