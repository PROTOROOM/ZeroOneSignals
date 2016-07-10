class ColorFall extends BasicBitsScreen {
  ArrayList<YLine> lines = new ArrayList<YLine>();

  float lineY;
  float dropSpeed, upSpeed, shrinkSpeed;
  float fullBarY, fullBarH;


  ColorFall(float w, float h) {
    super(w, h);
    //dWidth = sWidth / 3 / 12 * 10;
    //sX = 0 + (sWidth/3/12); //sWidth / 3;



    dropSpeed = sMultiple;
    upSpeed = 0;
  }

  void show() {

    if (state == 0) {
      sY = sHeight/2;
      upSpeed = -5*sMultiple;
      for (int i=lines.size()-1; i>=0; i--) {
        lines.remove(i);
      }
      fullBarY = 0;
      fullBarH = sHeight;
      shrinkSpeed = sMultiple*3;

      bitBarWidth = dWidth / 64;


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
      }
    }

    if (state == 3) {
      //dropOneLine();
      //dropTwoLines();
      dropMultiColorLines();
      drawTopHubBits();
    }
  }


  void drawTopHubBits() {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*5, hubNetwork.bits[i]);
    }
  }

  void moveUpHubBits() {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*2, hubNetwork.bits[i]);
    }
    sY = sY + upSpeed;
    upSpeed = min(-sMultiple, upSpeed * 0.98);
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


  void dropMultiColorLines() {
    lineY = dWidth / 64 * 6;
    color[] lineColors = {
      color(hubNetwork.hubData[0], 0, 0), 
      color(0, hubNetwork.hubData[1], 0), 
      color(0, 0, hubNetwork.hubData[2]), 
      color(hubNetwork.hubData[3]), 
      color(hubNetwork.hubData[4], 0, 0), 
      color(0, hubNetwork.hubData[5], 0), 
      color(0, 0, hubNetwork.hubData[6]), 
      color(hubNetwork.hubData[7])
    };

    MultiYLine newLine = new MultiYLine(sX, lineY, dWidth, lineColors);
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