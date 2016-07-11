class ColorFall extends BasicBitsScreen {
  ArrayList<YLine> lines = new ArrayList<YLine>();

  float lineY;
  float dropSpeed, upSpeed, downSpeed, shrinkSpeed;
  float fullBarY, fullBarH;

  int stateTime;
  int scene;

  color bitsBarColor;


  ColorFall(float w, float h) {
    super(w, h);
    //dWidth = sWidth / 3 / 12 * 10;
    //sX = 0 + (sWidth/3/12); //sWidth / 3;



    dropSpeed = sMultiple;
    upSpeed = 0;
    downSpeed = 0;
  }

  void show() {

    if (state == 0) {
      sY = sHeight/2;
      upSpeed = -5*sMultiple;
      downSpeed = 0;
      for (int i=lines.size()-1; i>=0; i--) {
        lines.remove(i);
      }
      fullBarY = 0;
      fullBarH = sHeight;
      shrinkSpeed = sMultiple*3;

      bitBarWidth = dWidth / 64;

      //scene = int(random(3));
      if (scene > 0) {
        scene = scene - 1;
      } else {
        scene = 3;
      }
      println("scene : " + str(scene));
      state++;
    }

    if (state == 1) {
      background(bgColor);
      for (int i=0; i<hubNetwork.bits.length; i++) {
        float startX = sX + (i*bitBarWidth*nodePerHub);     
        drawNodeBars(startX, fullBarY, bitBarWidth, fullBarH, hubNetwork.bits[i]);
      }

      fullBarY = fullBarY + shrinkSpeed;
      fullBarH = fullBarH - 2*shrinkSpeed;
      shrinkSpeed = shrinkSpeed * 1.1;

      if (fullBarH <= bitBarWidth*2) state++;
    }

    if (state == 2) {
      background(bgColor);
      moveUpHubBits();
      if (sY <= -sMultiple/2) {
        state++;
        stateTime = millis();
      }
    }

    if (state == 3) {
      filter(blur);
      if (scene == 0) dropOneLine();
      if (scene == 1) dropTwoLines();
      if (scene == 2) dropMultiYLines(); 
      if (scene == 3) dropMultiColorLines();
      
      //dropMultiYLines();
      //dropOneLine();
      //dropTwoLines();
      //dropMultiColorLines();
      drawTopHubBits();

      if ((millis() - stateTime) > 6000) {
        bitsBarColor = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], 30);
        //bitsBarColor = color(0, hubNetwork.hubData[0], 0, 60);
        state++;
        stateTime = millis();
      }
    }

    if (state == 4) {
      filter(blur);
      for (int i=lines.size()-1; i>=0; i--) {
        lines.remove(i);
      }
      moveDownHubBits(bitsBarColor);

      if ((millis() - stateTime) > 3000) {
        state = 0;
        //sY = sHeight;
      }
    }
  }


  void drawTopHubBits() {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*5, hubNetwork.bits[i]);
      //drawNodeBars01(startX, sY+sMultiple*10, bitBarWidth, bitBarWidth*2, hubNetwork.bits[i]);
    }
  }

  void moveUpHubBits() {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*2, hubNetwork.bits[i]);
      //drawNodeBars01(startX, sY, bitBarWidth, bitBarWidth*2, hubNetwork.bits[i]);
    }
    sY = sY + upSpeed;
    upSpeed = min(-sMultiple, upSpeed * 0.98);
  }

  void moveDownHubBits(color barColor) {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*sMultiple*15, hubNetwork.bits[i], barColor, color(255, 30));
    }
    sY = sY + downSpeed;
    downSpeed = max(5*sMultiple, downSpeed + 0.5*sMultiple);
  }


  void dropOneLine() {
    lineY = dWidth / 64 * 6;

    color lineColor1 = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], hubNetwork.hubData[3]);
    color lineColor2 = color(hubNetwork.hubData[4], hubNetwork.hubData[5], hubNetwork.hubData[6], hubNetwork.hubData[7]);

    YLine newLine1 = new YLine(sX, lineY, dWidth, lineColor1);
    YLine newLine2 = new YLine(sX, lineY+1, dWidth, lineColor2);

    newLine1.initDropSpeed(sMultiple);
    newLine2.initDropSpeed(sMultiple);

    newLine1.setStrokeWeight(sMultiple*3);
    newLine2.setStrokeWeight(sMultiple*3);

    lines.add(newLine1);
    lines.add(newLine2);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.drop();
      line.show();
    }
  }


  void dropTwoLines() {
    lineY = dWidth / 64 * 6;

    color lineColor1 = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], hubNetwork.hubData[3]);
    color lineColor2 = color(hubNetwork.hubData[4], hubNetwork.hubData[5], hubNetwork.hubData[6], hubNetwork.hubData[7]);

    YLine newLine1 = new YLine(sX, lineY, dWidth/2, lineColor1);
    YLine newLine2 = new YLine(sX+dWidth/2, lineY+1, dWidth/2, lineColor2);

    newLine1.initDropSpeed(sMultiple);
    newLine2.initDropSpeed(sMultiple);

    newLine1.setStrokeWeight(sMultiple*3);
    newLine2.setStrokeWeight(sMultiple*3);

    lines.add(newLine1);
    lines.add(newLine2);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.drop();
      line.show();
    }
  }

  void dropMultiYLines() {
    lineY = dWidth / 64 * 6;

    for (int i=0; i<hubNetwork.bits.length; i++) {
      color lineColor1 = make8BitColor(hubNetwork.bits[i]);
      YLine newLine1 = new YLine(sX+dWidth/8*i, lineY, dWidth/8, lineColor1);
      newLine1.initDropSpeed(sMultiple);
      newLine1.setStrokeWeight(sMultiple*3);
      lines.add(newLine1);
    }

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.drop();
      line.show();
    }
  }

  color make8BitColor(int[] bits) {
    int r = 256 / 8 * (bits[0]*4 + bits[1]*2 + bits[2]);
    int g = 256 / 8 * (bits[3]*4 + bits[4]*2 + bits[5]);
    int b = 256 / 4 * (bits[6]*2 + bits[7]);
    return color(r, g, b);
  }

  void dropMultiColorLines() {
    lineY = dWidth / 64 * 6;

    MultiYLine newLine = new MultiYLine(sX, lineY, dWidth, hubNetwork.hubData);
    newLine.initDropSpeed(sMultiple);
    newLine.setStrokeWeight(sMultiple*3);
    lines.add(newLine);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.drop();
      line.show();
    }
  }
}