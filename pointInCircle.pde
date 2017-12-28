boolean pointInCircle(int pointX, int pointY, int centerX, int centerY, int size){
  if(sqrt(sq(pointX - centerX) + sq(pointY - centerY)) < size / 2){
    return true;
  }
  return false;
}
