void levelCreator() {
  String [] level1 = new String[layoutX.length];
  String [] level2 = new String[layoutX.length];
  String [] level3 = new String[layoutX.length];
  if (button['X'] && XTrigger == false) {
    for (int i=0; i<layoutX.length; i++) {
      level3[i] = str(layoutX[i]) + ' ' + str(layoutY[i]) + ' ' + str(type[i]);
//      level1[i] = layoutX[i] + ' ' + layoutY[i] + ' ' + type[i];
    }
    XTrigger = true;
    saveStrings("data/Level" + level + ".txt", level3);
  }
}
