class HubBitsDisplay {
  float startX, startY;
  int dWidth, dHeight;
  HubNetwork h;

  float cellW;
  int colNum, rowNum;

  HubBitsDisplay(int screenWidth, int screenHeight, HubNetwork hub) {
    setHubConf(hub);

    if (screenWidth >= 1900) {
      startX = 506 - 270;
      dWidth = int(270 * 2);
    } else {
      startX = screenWidth/3/12;
      dWidth = int(screenWidth/3/12*10);
    }
    colNum = 17;
  }

  void setHubConf(HubNetwork hub) {
    h = hub;
  }


  void show() {
    fillBackground();

    for (int i=0; i<h.bits.length; i++) {
      for (int j=0; j<h.bits[i].length; j++) {

        float x = startX + cellW + i*cellW*2;
        float y = cellW*24 + j*cellW*3;

        if (h.bits[j][i] == 1) {
          fill(tableColors[j]); // be carefull i & j !! TODO
        } else {
          fill(255);
        }
        noStroke();
        rect(x, y, cellW, cellW);
      }
    }

    showGrid();
  }

  void showGrid() {

    cellW = dWidth / colNum;
    rowNum = int(height / cellW);
    strokeWeight(1);
    stroke(230);
    for (int i=1; i<colNum; i++) {
      float x = startX+cellW*i;
      line(x, 0, x, height);
    }

    for (int i=1; i<rowNum; i++) {
      float y = startY + cellW*i;
      line(startX, y, startX+dWidth, y);
    }
  }

  void showGridSlowly() {
    fillBackground();
    cellW = dWidth / colNum;
    rowNum = int(height / cellW);
    strokeWeight(1);
    stroke(230);
    for (int i=1; i<colNum; i++) {
      float x = startX+cellW*i;
      line(x, 0, x, height);
      
    }
    for (int i=1; i<rowNum; i++) {
      float y = startY + cellW*i;
      line(startX, y, startX+dWidth, y);
    }
  }

  void fillBackground() {
    fill(255);
    noStroke();
    rect(startX, 0, dWidth, height);
  }
}