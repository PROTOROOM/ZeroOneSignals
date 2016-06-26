class ModeScreen {
  HubNetwork hubNetwork;
  float sWidth, sHeight;
  int c;

  ModeScreen(float w, float h) {
    sWidth = w;
    sHeight = h;
  }
  
  void setHubNetwork(HubNetwork hn) {
    hubNetwork = hn;
  }

  void show() {
    fill(255, 0, 0);
    rect(0, 0, sWidth, sHeight);
    stroke(255);
    strokeWeight(4);
    line(0, 0, sWidth, sHeight);
    line(sWidth, 0, 0, sHeight);
  }

  void showOnce() {
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
  
  BasicBitsScreen(float w, float h) {
    super(w, h);
  }


  void show() {
    background(0);
    for (int i=0; i<8; i++) {
      drawBars(i*20+70, hubNetwork.bits[i]);
    }
  }


  void drawBars(float sy, int[] bits) {
    int nodeNumber = 8;
    float nw = 30;
    float startX = sWidth/2 - nw*nodeNumber/2;

    for (int i=0; i<nodeNumber; i++) {
      if (bits[i] == 1) {
        fill(200);
      } else {
        fill(50);
      }
      rect(startX+nw*i, sy, nw, nw/7);
    }
  }
}