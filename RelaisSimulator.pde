
int maxNumber = 5;
int lampSize = 25;
boolean pmousePressed;
LampA[] lampsA;
LampB[] lampsB;
LampU[] lampsU;
LampE[] lampsE;

void setup(){
  size(4 * lampSize * (maxNumber + 2), lampSize * 16);
  lampsA = new LampA[maxNumber];
  lampsB = new LampB[maxNumber];
  lampsU = new LampU[maxNumber];
  lampsE = new LampE[maxNumber + 1];
  for(int i = 0; i < lampsA.length; i ++){
    lampsA[i] = new LampA(lampSize, i * lampSize * 4 + lampSize * 8, lampSize * 3, i);
    lampsA[i].setValue(maxNumber - 1 - i, true);
  }
  for(int i = 0; i < lampsB.length; i ++){
    lampsB[i] = new LampB(lampSize, i * lampSize * 4 + lampSize * 8, lampSize * 6, i);
    lampsB[i].setValue(maxNumber - 1 - i, true);
  }
  for(int i = 0; i < lampsU.length; i ++){
    lampsU[i] = new LampU(lampSize, i * lampSize * 4 + lampSize * 4, lampSize * 9, i);
    lampsU[i].setValue(false);
    lampsU[i].setUnclickable();
  }
  for(int i = 0; i < lampsE.length; i ++){
    lampsE[i] = new LampE(lampSize, i * lampSize * 4 + lampSize * 4, lampSize * 12, i);
    lampsE[i].setValue(maxNumber - i, true);
    lampsE[i].setUnclickable();
  }
  noStroke();
  textAlign(CENTER);
}


void draw(){
  background(32);
  for(int i = 0; i < lampsA.length; i ++){
    lampsA[i].update();
    lampsA[i].draw();
  }
  for(int i = 0; i < lampsB.length; i ++){
    lampsB[i].update();
    lampsB[i].draw();
  }
  for(int i = 0; i < lampsU.length; i ++){
    lampsU[i].update();
    lampsU[i].draw();
  }
  for(int i = 0; i < lampsE.length; i ++){
    lampsE[i].update();
    lampsE[i].draw();
  }
  pmousePressed = mousePressed;
}
