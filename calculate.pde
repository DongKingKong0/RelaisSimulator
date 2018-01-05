
boolean pSwitchPlus, pSwitchMinus;

void calculate(){
  updateLamps();
  
  if(mode == 0){
    boolean[][] rowStates = new boolean[2][lampsA.length];
    for(int i = 0; i < rowStates[0].length; i ++){
      rowStates[0][i] = lampsA[i].getStatus();
      rowStates[1][i] = lampsB[i].getStatus();
    }
    boolean[][] result = addition(rowStates);
    for(int i = 0; i < result[0].length - 1; i ++){
      lampsU[i].setStatus(result[0][i]);
    }
    for(int i = 0; i < result[0].length; i ++){
      lampsE[i].setStatus(result[1][i]);
    }
    asPlus.setStatus(true);
    asMinus.setStatus(false);
  }else{
    for(int i = 0; i < lampsU.length; i ++){
      lampsU[i].setStatus(false);
    }
    
    boolean[][] rowStates = new boolean[2][lampsA.length];
    for(int i = 0; i < rowStates[0].length; i ++){
      rowStates[0][i] = lampsA[i].getStatus();
      rowStates[1][i] = lampsB[i].getStatus();
    }
    int firstLampIndex = -1;
    for(int i = 0; i < rowStates[0].length; i ++){
      if(lampsA[rowStates[0].length - i - 1].getStatus() ^ lampsB[rowStates[0].length - i - 1].getStatus()){
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
        boolean[][] result = addition(rowStates);
        boolean[][] states = new boolean[2][result[0].length - 1];
        states[1][states[0].length - 1] = result[1][0];
        for(int i = 0; i < states[0].length; i ++){
          states[0][i] = result[1][i + 1];
        }
        
        result = addition(states);
        for(int i = 0; i < lampsE.length; i ++){
          lampsE[i].setStatus(result[1][i]);
        }
      }else{
        asPlus.setStatus(false);
        asMinus.setStatus(true);
        
        for(int i = 0; i < rowStates[0].length; i ++){
          rowStates[1][i] = !rowStates[1][i];
        }
        boolean[][] result = addition(rowStates);
        for(int i = 0; i < result[0].length; i ++){
          result[1][i] = !result[1][i];
        }
        result[1][0] = false;
        for(int i = 0; i < lampsE.length; i ++){
          lampsE[i].setStatus(result[1][i]);
        }
      }
    }else{
      for(int i = 0; i < lampsE.length; i ++){
        lampsE[i].setStatus(false);
      }
      asPlus.setStatus(false);
      asMinus.setStatus(true);
    }
  }
}


void updateLamps(){
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
  if(switchPlus.getStatus() != pSwitchPlus){
    switchMinus.setStatus(!switchPlus.getStatus());
  }
  if(switchMinus.getStatus() != pSwitchMinus){
    switchPlus.setStatus(!switchMinus.getStatus());
  }
  if(switchPlus.getStatus()){
    mode = 0;
  }else{
    mode = 1;
  }
  asPlus.update();
  asMinus.update();
  pSwitchPlus = switchPlus.getStatus();
  pSwitchMinus = switchMinus.getStatus();
}


boolean[][] addition(boolean[][] input){
  boolean[][] output = new boolean[2][input[0].length + 1];
  int maxI = output[0].length - 1;
  for(int i = 0; i < maxI + 1; i ++){
    int numberOfActiveBits;
    if(i < maxI){
      numberOfActiveBits = int(input[0][maxI - i - 1]) + int(input[1][maxI - i - 1]) + int(output[0][maxI - i]);
      if(numberOfActiveBits % 2 == 1){
        output[1][maxI - i] = true;
      }else{
        output[1][maxI - i] = false;
      }
      if(numberOfActiveBits > 1){
        output[0][maxI - i - 1] = true;
      }else{
        output[0][maxI - i - 1] = false;
      }
    }else{
      output[1][0] = output[0][0];
    }
  }
  return output;
}
