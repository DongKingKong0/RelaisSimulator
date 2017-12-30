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
  for(int i = 0; i < lampsE.length; i ++){
    lampsE[i].update();
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
  
  if(mode == 0){
    int[] rowStates = new int[lampsE.length];
    for(int i = 0; i < rowStates.length; i ++){
      rowStates[i] = 0;
      if(i > 0){
        if(lampsA[i - 1].getStatus()){
          rowStates[i] ++;
        }
        if(lampsB[i - 1].getStatus()){
          rowStates[i] ++;
        }
      }
      if(i < maxNumber){
        if(lampsU[i].getStatus()){
          rowStates[i] ++;
        }
      }
    }
    
    for(int i = 0; i < rowStates.length; i ++){
      if(rowStates[i] % 2 == 1){
        lampsE[i].setStatus(true);
      }else{
        lampsE[i].setStatus(false);
      }
      if(i > 0){
        if(rowStates[i] > 1){
          lampsU[i - 1].setStatus(true);
        }else{
          lampsU[i - 1].setStatus(false);
        }
      }
    }
    asPlus.setStatus(true);
    asMinus.setStatus(false);
  }else{
    boolean[][] rowStates = new boolean[2][lampsA.length];
    for(int i = 0; i < rowStates[0].length; i ++){
      rowStates[0][i] = lampsA[i].getStatus();
      rowStates[1][i] = lampsB[i].getStatus();
    }
    int firstLampIndex = -1;
    for(int i = 0; i < rowStates[0].length; i ++){
      if(!(lampsA[rowStates[0].length - i - 1].getStatus() && lampsB[rowStates[0].length - i - 1].getStatus()) && !(!lampsA[rowStates[0].length - i - 1].getStatus() && !lampsB[rowStates[0].length - i - 1].getStatus())){
        firstLampIndex = rowStates[0].length - i - 1;
      }
    }
    if(firstLampIndex > -1){
      if(lampsA[firstLampIndex].getStatus()){
        asPlus.setStatus(true);
        asMinus.setStatus(false);
        for(int i = 0; i < rowStates[0].length; i ++){
          rowStates[1][i] = !rowStates[1][i];
        }
        
        boolean[] ans = new boolean[rowStates[0].length + 1];
        boolean nextAs = false;
        for(int i = 0; i < ans.length; i ++){
          int numberOfActiveBits = 0;
          if(i < ans.length - 1){
            numberOfActiveBits = int(nextAs) + int(rowStates[0][ans.length - i - 2]) + int(rowStates[0][ans.length - i - 2]);
            if(numberOfActiveBits % 2 == 1){
              ans[ans.length - i - 2] = true;
            }else{
              ans[ans.length - i - 2] = false;
            }
            if(numberOfActiveBits > 1){
              nextAs = true;
            }else{
              nextAs = false;
            }
          }else{
            ans[ans.length - i - 1] = nextAs;
          }
        }
        
        boolean[] as = new boolean[lampsA.length];
        for(int i = 0; i < lampsA.length; i ++){
          int numberOfActiveBits;
          numberOfActiveBits = int(as[lampsA.length - i - 1]) + int(ans[lampsA.length - i - 1]);
          if(numberOfActiveBits == 2){
            as[ans.length - i - 2] = true;
          }else{
            as[ans.length - i - 2] = false;
          }
          if(numberOfActiveBits == 1){
            lampsE[lampsA.length - i - 1].setStatus(true);
          }else{
            lampsE[lampsA.length - i - 1].setStatus(false);
          }
        }
      }else{
        asPlus.setStatus(false);
        asMinus.setStatus(true);
      }
    }
  }
  
  /*switch(mode){
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
  }*/
}
