boolean trigger = false;
boolean connectedL = false;
boolean connectedR = false;
boolean connectedU = false;
boolean connectedD = false;
boolean wallrideL;
boolean wallrideR;
boolean wallride;
boolean jumpTrigger = false;
boolean walljumpL = false;
boolean walljumpR = false;
boolean rightTrigger;
boolean leftTrigger;
float blockX;
float blockY;

void player() {

  speedX = 0;

  if (button[LEFT] && !wallride) {
    speedX = -playerSpeed;
    lookRight = false;
  }
  if (button[RIGHT] && !wallride) {
    speedX = playerSpeed;
    lookRight = true;
  }
  if (!button[' ']) {
    spaceTrigger = false;
  }
  if (button[' '] && jump > 0) {
    speedY = jumpSpeed;
    jump--;
  }
  if (connectedD == false) {
    speedY = speedY + gravity;
  } else {
    jump = 1;
    gravity = 0.6;
  }

  float px = x;
  float py = y;

  connectedU = false;
  connectedD = false;
  connectedR = false;
  connectedL = false;

  x += speedX;

  if (speedX>0) {
    for (int i = 0; i < layoutX.length; i++) {
      if (abs(layoutY[i]-size/2-y)<size && layoutX[i]-(size+size/2)<x&&x<layoutX[i]-size/2) {
        connectedR = true;
        if (!bloodR[int(x/size)][int(y/size)] && type[i] != 22) {
          bloodX = append(bloodX, layoutX[i]);
          bloodY = append(bloodY, layoutY[i]);
          bloodType = append(bloodType, 1);
          bloodLevel = append(bloodLevel, level);
          bloodR[int(x/size)][int(y/size)] = true;
        }
        if (type[i] == 22) {
          level++;
          x = 100;
          y = 100;
          layoutSwitch = false;
        }
      }
    }
  }
  if (speedX<0) {
    for (int i = 0; i < layoutX.length; i++) {

      if (abs(layoutY[i]-size/2-y)<size && layoutX[i]-size/2<x&&x<layoutX[i]+size/2) {
        connectedL = true;
        if (!bloodL[int(x/size)][int(y/size)] && type[i] != 22) {
          bloodX = append(bloodX, layoutX[i]);
          bloodY = append(bloodY, layoutY[i]);
          bloodType = append(bloodType, 3);
          bloodLevel = append(bloodLevel, level);
          bloodL[int(x/size)][int(y/size)] = true;
        }
        if (type[i] == 22) {
          level++;
          x = 100;
          y = 100;
          layoutSwitch = false;
        }
      }
    }
  }

  float fx = x;
  x = px;

  y+= speedY;
  if (speedY>0) {
    for (int i = 0; i < layoutX.length; i++) {
      if (abs(layoutX[i]-size/2-x)<size && layoutY[i]-(size+size/2)<y&&y<layoutY[i]-size/2) {
        connectedD = true;
        if (!bloodD[int(x/size)][int(y/size)] && type[i] != 22) {
          bloodX = append(bloodX, layoutX[i]);
          bloodY = append(bloodY, layoutY[i]);
          bloodType = append(bloodType, 2);
          bloodLevel = append(bloodLevel, level);
          bloodD[int(x/size)][int(y/size)] = true;
        }
        if (type[i] == 22) {
          level++;
          x = 100;
          y = 100;
          layoutSwitch = false;
        }
      }
    }
  }
  if (speedY<0) {
    for (int i = 0; i < layoutX.length; i++) {
      if (abs(layoutX[i]-size/2-x)<size && layoutY[i]-size/2<y&&y<layoutY[i]+size/2) {
        connectedU = true;
        speedY = 0;
        if (!bloodU[int(x/size)][int(y/size)] && type[i] != 22) {
          bloodX = append(bloodX, layoutX[i]);
          bloodY = append(bloodY, layoutY[i]);
          bloodType = append(bloodType, 0);
          bloodLevel = append(bloodLevel, level);
          bloodU[int(x/size)][int(y/size)] = true;
        }
        if (type[i] == 22) {
          level++;
          x = 100;
          y = 100;
          layoutSwitch = false;
        }
      }
    }
  }

  x = fx;

  if (connectedR||connectedL) {
    x = px;
  }
  if (connectedU||connectedD) {
    y = py;
  }

  if (connectedR||connectedL) {
    x = round(x/size)*size;
  }
  if (connectedU||connectedD) {
    y = round(y/size)*size;
  }

  if (button[' '] && speedY >= 0) {
    if (connectedL && !connectedD && button[LEFT]) {
      wallride = true;
      wallrideL = true;
      walljumpL = true;
    }
    if (connectedR && !connectedD && button[RIGHT]) {
      wallride = true;
      wallrideR = true;
      walljumpR = true;
    }
  } else if (speedY >= 0) {
    wallride = false;
    wallrideL = false;
    wallrideR = false;
  }
  if (wallrideL && button[' '] && !button[LEFT] && button[RIGHT]) {
    speedY = jumpSpeed;
    wallride = false;
    wallrideL = false;
  }
  if (wallrideR && button[' '] && !button[RIGHT] && button[LEFT]) {
    speedY = jumpSpeed;
    wallride = false;
    wallrideR = false;
  }

  if (wallride && speedY >= 0) {
    speedY = 0;
    gravity = 0;
  } else {
    gravity = 0.6;
  }

  fill(0, 255, 0);
  imageMode(CORNER);
  if (wallrideR) {
    image(wallRideRight, x+5, y);
  } else if (wallrideL) {
    image(wallRideLeft, x-5, y);
  } else if (speedX > 0) {
    image(run[frame], x, y);
  } else if (speedX < 0) {
    image(runL[frame], x, y);
  } else if (lookRight) {
    image(standing, x, y);
  } else {
    image(standingL, x, y);
  }

  for (int j = 0; j < bloodX.length; j++) {
    for (int i = 0; i < layoutX.length; i++) {
      imageMode(CENTER);
      if (bloodX[j] == layoutX[i] && bloodY[j] == layoutY[i] && bloodLevel[j] == level) {
        image(blood[bloodType[j]], bloodX[j], bloodY[j]);
        imageMode(CORNER);
      }
    }
  }
  if (speedX == 0) {
    frame = 0;
  }
  //  rect(x, y, size, size);
}
//  println(wallrideL, connectedL, wallrideR, connectedR, jump, wallride, speedY, walljumpL);
//  println(wallride, jump);
//  println(connectedL);

