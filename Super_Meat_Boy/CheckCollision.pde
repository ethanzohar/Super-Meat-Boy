void checkCollision() {
  connectedU = false;
  connectedD = false;
  connectedL = false;
  connectedR = false;
  for (int i = 0; i < layoutX.length; i++) {
    
    if (((layoutY[i]-25<=y&&y<=layoutY[i]+25) || (y+size <= layoutY[i]+25 && y+size >= layoutY[i]-25)) && (x <= layoutX[i]+25) && (x - layoutX[i]+25 > 0)) {
      //connectedL = true;
    }
    if (((y <= layoutY[i]+25 && y >= layoutY[i]-25) || (y+size <= layoutY[i]+25 && y+size >= layoutY[i]-25)) && (x+size >= layoutX[i]-25) && (x+size - layoutX[i]-25 < 0)) {
      //connectedR = true;
    }
    if (((x <= layoutX[i]+25 && x >= layoutX[i]-25) || (x+size <= layoutX[i]+25 && x+size >= layoutX[i]-25)) && (y <= layoutY[i]+25) && (y - layoutY[i]+25 > 0)) {
      //connectedU = true;
    }
    if (((x <= layoutX[i]+25 && x >= layoutX[i]-25) || (x+size <= layoutX[i]+25 && x+size >= layoutX[i]-25)) && (y+size >= layoutY[i]-25) && (y+size - layoutY[i]-25 < 0)) {
      //connectedD = true;
    }
  }
}