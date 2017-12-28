
int maxNumber = 5;
int lampSize = 25;
boolean pmousePressed;
Lamp[] lampsA;
Lamp[] lampsB;
Lamp[] lampsU;
Lamp[] lampsE;

void setup(){
  size(4 * lampSize * (maxNumber + 2), lampSize * 16);
  lampsA = new Lamp[maxNumber];
  lampsB = new Lamp[maxNumber];
  lampsU = new Lamp[maxNumber];
  lampsE = new Lamp[maxNumber + 1];
  for(int i = 0; i < lampsA.length; i ++){
    lampsA[i] = new Lamp(lampSize, i * lampSize * 4 + lampSize * 8, lampSize * 3, 255, 255, 200, i);
    lampsA[i].setValue(maxNumber - 1 - i, true);
  }
  for(int i = 0; i < lampsB.length; i ++){
    lampsB[i] = new Lamp(lampSize, i * lampSize * 4 + lampSize * 8, lampSize * 6, 255, 200, 0, i);
    lampsB[i].setValue(maxNumber - 1 - i, true);
  }
  for(int i = 0; i < lampsU.length; i ++){
    lampsU[i] = new Lamp(lampSize, i * lampSize * 4 + lampSize * 4, lampSize * 9, 255, 0, 0, i);
    lampsU[i].setValue(false);
    lampsU[i].setUnclickable();
  }
  for(int i = 0; i < lampsE.length; i ++){
    lampsE[i] = new Lamp(lampSize, i * lampSize * 4 + lampSize * 4, lampSize * 12, 0, 255, 0, i);
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
    lampsE[i].calculateStatus();
    lampsE[i].draw();
  }
  pmousePressed = mousePressed;
}
