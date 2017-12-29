void drawLamps(){
  background(32);
  for(int i = 0; i < lampsA.length; i ++){
    lampsA[i].draw();
  }
  for(int i = 0; i < lampsB.length; i ++){
    lampsB[i].draw();
  }
  for(int i = 0; i < lampsU.length; i ++){
    lampsU[i].draw();
  }
  for(int i = 0; i < lampsE.length; i ++){
    lampsE[i].draw();
  }
  switchPlus.draw();
  switchMinus.draw();
  asPlus.draw();
  asMinus.draw();
}
