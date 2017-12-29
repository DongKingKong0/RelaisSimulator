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
    case 0://plus
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
    case 1://minus
    for(int i = 0; i < lampsU.length; i ++){
      lampsU[i].setStatus(false);
    }
    
    for(int i = 0; i < lampsE.length; i ++){
      lampsE[i].update();
      lampsE[i].setStatus(false);
    }
    
    boolean asIsSet = false;
    for(int i = 0; i < lampsA.length; i ++){
      if(!asIsSet){
        if(lampsA[i].getStatus() && !lampsB[i].getStatus()){
          lampsE[i + 1].setStatus(false);
          asPlus.setStatus(true);
          asMinus.setStatus(false);
          asIsSet = true;
        }else if(lampsB[i].getStatus() && !lampsA[i].getStatus()){
          asPlus.setStatus(false);
          asMinus.setStatus(true);
          asIsSet = true;
        }else{
          lampsE[i + 1].setStatus(false);
        }
      }
      
    if(!(lampsA[i].getStatus() && lampsB[i].getStatus()) && !(!lampsA[i].getStatus() && !lampsB[i].getStatus())){
        lampsE[i + 1].setStatus(true);
        if(asPlus.getStatus()){
          int nextValidLamp = 0;
          for(int j = 0; j < lampsA.length - i - 1; j ++){
            if(lampsB[lampsA.length - j - 1].getStatus()){
              nextValidLamp = lampsA.length - j - 1;
            }
          }
          if(nextValidLamp > 0){
            toggleLampsE(i + 1, nextValidLamp + 1);
          }
        }else{
          int nextValidLamp = 0;
          for(int j = 0; j < lampsA.length - i - 1; j ++){
            if(lampsA[lampsA.length - j - 1].getStatus()){
              nextValidLamp = lampsA.length - j - 1;
            }
          }
          if(nextValidLamp > 0){
            toggleLampsE(i + 1, nextValidLamp + 1);
          }
        }
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


void toggleLampsE(int start, int end){
  for(int i = 0; i < end - start; i ++){
    lampsE[start + i].toggleStatus();
  }
}
