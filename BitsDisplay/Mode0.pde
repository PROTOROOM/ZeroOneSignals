class NodeToHub extends BasicBitsScreen {
  float cellW;
  int colNum, rowNum;

  NodeToHub(float w, float h) {
    super(w, h);
    //bitBarWidth = dWidth / 64;
    //colNum = 17;
    colNum = 64;
  }

  //void show() {
  //  bitBarWidth = dWidth / 64;
  //  for (int i=0; i<hubNetwork.bits.length; i++) {
  //    float startX = sX + (i*bitBarWidth*nodePerHub);     
  //    drawNodeBars(startX, sY, bitBarWidth, sHeight, hubNetwork.bits[i]);
  //  }
  //}

  void show() {
    fillBackground();

    for (int i=0; i<hubNetwork.bits.length; i++) {
      
      
      for (int j=0; j<hubNetwork.bits[i].length; j++) {

        float x = sX + cellW + i*cellW*2;
        float y = cellW*24 + j*cellW*3;

        if (hubNetwork.bits[j][i] == 1) {
          fill(0);
        } else {
          fill(255);
        }
        noStroke();
        rect(x, y, cellW, cellW);
      }
    }


    cellW = dWidth / colNum;
    rowNum = int(sHeight / cellW);
    strokeWeight(1);
    stroke(230);
    for (int i=1; i<colNum; i++) {
      float x = sX+cellW*i;
      line(x, 0, x, sHeight);
    }

    for (int i=1; i<rowNum; i++) {
      float y = sY + cellW*i;
      line(sX, y, sX+dWidth, y);
    }
  }
}



class FullBitsScreen extends BasicBitsScreen {
  float dH, dT;
  float upSpeed;

  FullBitsScreen(float w, float h) {
    super(w, h);
    dH = sHeight;
    dT = 0;
    //upSpeed = 0.2*sMultiple;
    upSpeed = 20;
  }

  void show() {
    float sX = sWidth / 3;
    float bitBarWidth = (sWidth / 3) / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, dT, bitBarWidth, dH, hubNetwork.bits[i]);
    }

    //dH = dH - 0.2*sMultiple;
    //dT = dT + 0.4*sMultiple;
    //middle();
    //up();
  }

  void up() {
    upSpeed = max(1, upSpeed*0.97);
    dH = dH - upSpeed;
  }

  void middle() {
    dH = dH - 0.8*sMultiple;
    dT = dT + 0.4*sMultiple;
  }
}