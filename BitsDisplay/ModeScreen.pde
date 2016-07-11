class ModeScreen {
  HubNetwork hubNetwork;
  float sWidth, sHeight, sMultiple;
  float sX, sY;
  float dWidth;
  int c;
  int state;

  ModeScreen(float w, float h) {
    sWidth = w;
    sHeight = h;
    sMultiple = w / 640;
    setStartPosition(0, 0);
    dWidth = sWidth;
    state = 0;
  }

  void setHubNetwork(HubNetwork hn) {
    hubNetwork = hn;
  }

  void setStartPosition(float sx, float sy) {
    sX = sx;
    sY = sy;
  }

  void setDisplayWidth(float dw) {
    dWidth = dw;
  }

  void show() {
    fill(255, 0, 0);
    rect(0, 0, dWidth, sHeight);
    stroke(255);
    strokeWeight(4);
    line(0, 0, dWidth, sHeight);
    line(dWidth, 0, 0, sHeight);
  }

  void reset() {
    state = 0;
  }

  void showOnce() {
  }

  void up() {
  }
}


/**
 Screen for testing display size, color, etc...
 **/
class TestModeScreen extends ModeScreen {
  float uw, uh;

  TestModeScreen(float w, float h) {
    super(w, h);
    uw = sWidth / 12;
    uh = sHeight / 4;
  } 

  void show() {
    background(0, 0, 255);

    noStroke();

    fill(0, 255, 0);
    rect(uw, 0, uw*10, sHeight);

    fill(255, 0, 0);
    rect(uw*2, 0, uw*8, sHeight);

    fill(0);
    rect(uw*3, 0, uw*6, sHeight);

    stroke(255);
    strokeWeight(2);
    line(sWidth/2, 0, sWidth/2, sHeight);

    line(0, uh, sWidth, uh);
    line(0, uh*2, sWidth, uh*2);
    line(0, uh*3, sWidth, uh*3);
  }
}


class BasicBitsScreen extends ModeScreen {
  int nodePerHub;
  float bitBarWidth;


  BasicBitsScreen(float w, float h) {
    super(w, h);
    nodePerHub = 8;
    bitBarWidth = 30*sMultiple;

    float startX = sWidth/2 - bitBarWidth*nodePerHub/2;
    setStartPosition(startX, 0);
  }


  void show() {
    background(0);
    for (int i=0; i<hubNetwork.bits.length; i++) {
      drawNodeBars(sX, i*20*sMultiple+70, bitBarWidth, bitBarWidth/7, hubNetwork.bits[i]);
    }
  }


  void drawNodeBars(float sx, float sy, float bw, float bh, int[] bits) {
    noStroke();
    for (int i=0; i<nodePerHub; i++) {
      if (bits[i] == 1) {
        fill(200);
      } else {
        fill(20);
      }
      rect(sx+bw*i, sy, bw, bh);
    }
  }

  void drawNodeBars01(float sx, float sy, float bw, float bh, int[] bits) {
    noStroke();
    //fill(0);
    char num;
    for (int i=0; i<nodePerHub; i++) {
      if (bits[i] == 1) {
        //fill(200);
        num = '1';
      } else {
        //fill(20);
        num = '0';
      }
      fill(0);
      rect(sx+bw*i, sy, bw, bh);
      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(sMultiple*5);
      text(num, sx+bw*i, sy+sMultiple*3);
    }
  }

  void drawNodeBars(float sx, float sy, float bw, float bh, int[] bits, color onColor, color offColor) {
    noStroke();
    for (int i=0; i<nodePerHub; i++) {
      if (bits[i] == 1) {
        fill(onColor);
      } else {
        fill(offColor);
      }
      rect(sx+bw*i, sy, bw, bh);
    }
  }
}