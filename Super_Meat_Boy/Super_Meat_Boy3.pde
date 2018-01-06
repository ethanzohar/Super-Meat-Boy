boolean [] button = new boolean [256];
boolean XTrigger = false;
boolean T = false;
boolean lookRight = true;
boolean spaceTrigger = false;
boolean appendU = false;
boolean appendL = false;
boolean appendR = false;
boolean appendD2 = false;
boolean appendU2 = false;
boolean appendD = false;
boolean levelSwitch = false;
boolean layoutSwitch = false;


int a = 0;
int z = 0;

float [] layoutX = {
};
float [] layoutY = {
};
float [] bloodX = {
  -100
};
float [] bloodY = {
  -100
};
int [] bloodLevel = {
  1
};
float x = 120;
float y = 760;
float speedX;
float speedY;
float gravity = 1.6;

float distXL;
float distXR;
float distYU;
float distYD;
float jumpSpeed = -15.3;

int size = 40;
int jump = 1;
int blockType = 0;
int [] type = {
};
int [] bloodType = {
  1
};
int frame = 0;
int playerSpeed = 8;
int cryingFrame = 0;
int endX = 620;
int endY = 417;
int level = 1;

PImage [] forest = new PImage [23];
PImage [] run = new PImage [16];
PImage [] runL = new PImage [16];
PImage [] blood = new PImage [4];
PImage [] crying = new PImage [3];

PImage standingL;
PImage standing;
PImage wallRideLeft;
PImage wallRideRight;
PImage forestBG;
PImage saw;

boolean [][] bloodU;
boolean [][] bloodD;
boolean [][] bloodL;
boolean [][] bloodR;

void setup() {
  size(1360, 880);
  for (int i = 0; i < forest.length; i++) { 
    forest[i] = loadImage("Forest" + (i+1) + ".png");
    forest[i].resize(size, size);
  }
  for (int i = 0; i < blood.length; i++) {
    blood[i] = loadImage("Blood" + i + ".png");
    blood[i].resize(size, size);
  }
  for (int i = 0; i < run.length; i++) {
    run[i] = loadImage("Run" + (i+1) + ".png");
    run[i].resize(size, size);
    runL[i] = loadImage("RunL" + (i+1) + ".png");
    runL[i].resize(size, size);
  }

  for (int i = 0; i < crying.length; i++) {
    crying[i] = loadImage("crying" + (i+1) + ".png");
    //    crying[i].resize(size,size);
  }

  standing = loadImage("Standing.png");
  standing.resize(size, size);
  standingL = loadImage("StandingL.png");
  standingL.resize(size, size);
  wallRideRight = loadImage("WallRideR.png");
  wallRideRight.resize(size, size);
  wallRideLeft = loadImage("WallRideL.png");
  wallRideLeft.resize(size, size);
  saw = loadImage("saw.png");
  forestBG = loadImage("forestbg.png");
  forestBG.resize(width, height);

  bloodD = new boolean [width/size] [height/size];
  bloodU = new boolean [width/size] [height/size];
  bloodL = new boolean [width/size] [height/size];
  bloodR = new boolean [width/size] [height/size];
}
void draw() {
  if (!layoutSwitch) {
    String lines [] = loadStrings("Level" + level + ".txt");
    layoutX = new float[lines.length];
    layoutY = new float[lines.length];
    type = new int[lines.length];
    for (int i = 0; i < lines.length; i++) {
      String [] item = split(lines[i], " ");
      layoutX[i] = float(item[0]);
      layoutY[i] = float(item[1]);
      type[i] = int(item[2]);
    }
    if (level == 2) {
      x = 120;
      y = 640;
      endX = 740;
      endY = 257;
    } else if (level == 3) {
      x = 240;
      y = 800;
      endX = 740;
      endY = 257;
    }
    layoutSwitch = true;
  }
  image(forestBG, 0, 0);
  pushMatrix();
  imageMode(CENTER);
  translate(width/2, height/2);
  rotate(z);
  image(saw, 0, 0);
  imageMode(CORNER);
  popMatrix();
  levelEdit();
  player();
  levelCreator();
  z++;
//  for (int i = 0; i < width; i+=size) {
//    line(i, 0, i, height);
//    line(0, i, width, i);
//  }
  if (button['D']) {
    x = 400;
    y = 400;
    speedX = 0;
    speedY = 0;
  }
  if (button['T'] && T == false) {
    blockType++;
    T = true;
  } else  if (!button['T']) { 
    T = false;
  }
  if (blockType > forest.length-1) {
    blockType = 0;
  }
  frame++;
  if (frameCount % 3 == 0) {
    cryingFrame++;
  }
  if (frame > run.length-1) {
    frame = 0;
  }
  if (cryingFrame > crying.length-1) {
    cryingFrame = 0;
  }
  imageMode(CENTER);
  image(crying[cryingFrame], endX, endY);
  imageMode(CORNER);
  //  for (int i = 0; i < layoutX.length; i++) {
  //    if (i < layoutX.length-2) {
  //      if (layoutX[i] == layoutX[i+1] && layoutY[i] == layoutY[i+1]) {
  //        textAlign(CENTER);
  //        text(i, layoutX[i], layoutY[i]);
  //      }
  //    }
  //  }
}

void levelEdit() {
  rectMode(CENTER);
  int i = 0;
  while (i < layoutX.length) {
    if (layoutX[i]%size > size/2) {
      layoutX[i] = (layoutX[i]-(layoutX[i]%size))+size/2;
    } else if (layoutX[i]%size/2 < size/2) {
      layoutX[i] = (layoutX[i]-(layoutX[i]%size))+size/2;
    }
    if (layoutY[i]%size > size/2) {
      layoutY[i] = (layoutY[i]-(layoutY[i]%size))+size/2;
    } else if (layoutY[i]%size/2 < size/2) {
      layoutY[i] = (layoutY[i]-(layoutY[i]%size))+size/2;
    }
    fill(255, 0, 0);
    imageMode(CENTER);
    //    rect(layoutX[i], layoutY[i], size, size);
    textAlign(CENTER);
    image(forest[type[i]], layoutX[i], layoutY[i]);
    //    text(i, layoutX[i], layoutY[i]);
    i++;
  }
  imageMode(CENTER);
  image(forest[blockType], mouseX, mouseY);
  rectMode(CORNER);
}

void keyPressed() {
  button[keyCode] = true;
}
void keyReleased() {
  button[keyCode] = false;
}
void mousePressed() {
  layoutX = append(layoutX, mouseX);
  layoutY = append(layoutY, mouseY);
  type = append(type, blockType);
}

