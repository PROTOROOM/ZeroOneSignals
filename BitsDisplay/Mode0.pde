class FullBitsScreen extends BasicBitsScreen {
  float dH, dT;

  FullBitsScreen(float w, float h) {
    super(w, h);
    dH = sHeight;
    dT = 0;
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
    up();
  }

  void up() {
    dH = dH - 0.2*sMultiple;
  }

  void middle() {
    dH = dH - 0.8*sMultiple;
    dT = dT + 0.4*sMultiple;
  }
}