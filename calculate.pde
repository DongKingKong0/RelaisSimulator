
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
