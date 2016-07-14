class ColorFall extends BasicBitsScreen {
  ArrayList<YLine> lines = new ArrayList<YLine>();

  float lineY;
  float dropSpeed, upSpeed, downSpeed, shrinkSpeed;
  float fullBarY, fullBarH;
  float bH, topHubBitsHeight;

  int stateTime;
  int scene;

  color bitsBarColor;
  color dropLine64Color;

  float[] color8FallingSpeed = new float[8];

  float dW, dWgap;// XXX
  float testY = 0; //XXX
  float oX, oY; //XXX

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
      topHubBitsHeight = bitBarWidth * 10; 
      bH = 0;

      dW = dWidth / 8; //XXX
      dWgap = 1; //XXX

      //scene = int(random(3));
      if (scene > 0) {
        scene = scene - 1;
      } else {
        scene = 1; // 1 for bw, 4 for color
      }
      println("scene : " + str(scene));
      state++;
    }

    if (state == 1) {
      fillBackground();
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
      fillBackground();
      moveUpHubBits();
      if (sY <= -sMultiple/2) {
        state++;
        stateTime = millis();
      }
    }

    if (state == 3) {
      drawTopHubBits(bH);
      bH = bH + sMultiple;

      if (bH > topHubBitsHeight) {
        bH = topHubBitsHeight;
        if (millis() - stateTime > 1000) {
          state++;
          stateTime = millis();
          color8FallingSpeed = getFallingSpeed(8);
          if (scene == 0) {
            //dropLine64Color = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2]);
            dropLine64Color = color(random(255), random(255), random(255));
          }
        }
      }
    }

    if (state == 4) {
      //scene = 2;
      //filter(blur);
      
      /* Color drop */
      //if (scene == 0) { 
      //  //filter(blur); 
      //  dropLine64(topHubBitsHeight);
      //}
      //if (scene == 1) dropLine32(topHubBitsHeight);
      //if (scene == 2) {
      //  dropLine8(topHubBitsHeight, color8FallingSpeed);
      //}
      //if (scene == 3) dropMultiColorLines(topHubBitsHeight);

      //if (scene == 4) {
      //  if (frameCount % 8 == 0) dropLine1(topHubBitsHeight);
      //}


      /* Black & White drop */
      if (scene == 0) {
        dropLine8s(topHubBitsHeight, color8FallingSpeed);
      }
      //if (scene == 3) dropMultiColorLines(topHubBitsHeight);

      if (scene == 1) {
        if (frameCount % 8 == 0) dropLine1(topHubBitsHeight);
      }


      //if (frameCount % 5 == 0) dropLine1(topHubBitsHeight);
      //dropMultiYLines();
      //dropOneLine();
      //dropTwoLines();
      //dropMultiColorLines();
      drawTopHubBits(topHubBitsHeight);


      if ((millis() - stateTime) > 30000) {
        bitsBarColor = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], 10);
        //bitsBarColor = color(0, hubNetwork.hubData[0], 0, 60);
        state++;
        stateTime = millis();
      }
    }

    if (state == 5) {

      for (int i=lines.size()-1; i>=0; i--) {
        lines.remove(i);
      }
      //moveDownHubBits(bitsBarColor);
      //filter(blur);
      if ((millis() - stateTime) > 3000) {
        state = 0;
        //sY = sHeight;
      }
    }
  }


  void drawTopHubBits(float barHeight) {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, barHeight, hubNetwork.bits[i]);
      //drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*5, hubNetwork.bits[i]);
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
    upSpeed = min(-2*sMultiple, upSpeed * 0.98);
  }

  void moveDownHubBits(color barColor) {
    //bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, sY, bitBarWidth, bitBarWidth*sMultiple*15, hubNetwork.bits[i], barColor, color(255, 10));
    }
    sY = sY + downSpeed;
    downSpeed = max(10*sMultiple, downSpeed + sMultiple);
  }


  void dropLine64(float y) {
    //lineY = dWidth / 64 * 6;
    lineY = y;

    //color lineColor1 = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], hubNetwork.hubData[3]);
    //color lineColor2 = color(hubNetwork.hubData[4], hubNetwork.hubData[5], hubNetwork.hubData[6], hubNetwork.hubData[7]);

    int r = int((hubNetwork.hubData[0] + hubNetwork.hubData[4]) / 2);
    int g = int((hubNetwork.hubData[1] + hubNetwork.hubData[5]) / 2);
    int b = int((hubNetwork.hubData[2] + hubNetwork.hubData[6]) / 2);
    int a = int((hubNetwork.hubData[3] + hubNetwork.hubData[7]) / 2);

    // Failed Experiment. bad.. XXX 
    //int r, g, b, a;
    //int gap = 3;
    //if (hubNetwork.hubData[0] > hubNetwork.hubData[4]) {
    //  r = int(min(255, red(dropLine64Color) + gap));
    //} else {
    //  r = int(max(0, red(dropLine64Color) - gap));
    //}
    //if (hubNetwork.hubData[1] > hubNetwork.hubData[5]) {
    //  g = int(min(255, green(dropLine64Color) + gap));
    //} else {
    //  g = int(max(0, green(dropLine64Color) - gap));
    //}
    //if (hubNetwork.hubData[2] > hubNetwork.hubData[6]) {
    //  b = int(min(255, blue(dropLine64Color) + gap));
    //} else {
    //  b = int(max(0, blue(dropLine64Color) - gap));
    //}
    //if (hubNetwork.hubData[3] > hubNetwork.hubData[7]) {
    //  a = int(min(255, alpha(dropLine64Color) + gap));
    //} else {
    //  a = int(max(0, alpha(dropLine64Color) - gap));
    //}

    dropLine64Color = color(r, g, b, a);

    YLine newLine1 = new YLine(sX, lineY, dWidth, dropLine64Color);
    //YLine newLine2 = new YLine(sX, lineY+1, dWidth, lineColor2);

    newLine1.initDropSpeed(sMultiple);
    //newLine2.initDropSpeed(sMultiple);

    newLine1.setStrokeWeight(sMultiple*2);
    //newLine2.setStrokeWeight(sMultiple*2);

    lines.add(newLine1);
    //lines.add(newLine2);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();
    }
  }


  void dropLine32(float y) {
    //lineY = dWidth / 64 * 6;
    lineY = y;

    color lineColor1 = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], hubNetwork.hubData[3]);
    color lineColor2 = color(hubNetwork.hubData[4], hubNetwork.hubData[5], hubNetwork.hubData[6], hubNetwork.hubData[7]);

    YLine newLine1 = new YLine(sX, lineY, dWidth/2, lineColor1);
    YLine newLine2 = new YLine(sX+dWidth/2, lineY, dWidth/2, lineColor2);

    newLine1.initDropSpeed(sMultiple);
    newLine2.initDropSpeed(sMultiple);

    newLine1.setStrokeWeight(sMultiple*3);
    newLine2.setStrokeWeight(sMultiple*3);

    lines.add(newLine1);
    lines.add(newLine2);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();
    }
  }

  void dropLine32s(float y) {
    //lineY = dWidth / 64 * 6;
    lineY = y;

    float left = (hubNetwork.hubData[0]+ hubNetwork.hubData[1]);
    float right = (hubNetwork.hubData[4]+ hubNetwork.hubData[5]);
    float r1 = (hubNetwork.hubData[2]+ hubNetwork.hubData[3]);
    float r2 = (hubNetwork.hubData[6]+ hubNetwork.hubData[7]);
    color lineColor1 = color(map(left, 0, 510, 0, 255), map(r1, 0, 510, 0, 255));
    color lineColor2 = color(map(right, 0, 510, 0, 255), map(r2, 0, 510, 0, 255));



    YLine newLine1 = new YLine(sX, lineY, dW, lineColor1);
    YLine newLine2 = new YLine(sX+dWidth/2, lineY, dW, lineColor2);

    newLine1.initDropSpeed(sMultiple);
    newLine2.initDropSpeed(sMultiple);

    newLine1.setStrokeWeight(sMultiple*3);
    newLine2.setStrokeWeight(sMultiple*3);

    lines.add(newLine1);
    lines.add(newLine2);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();
    }

    dW = dW - 1;
    if (dW <= 0) dW = dWidth/2;
  }

  float[] getFallingSpeed(int num) {
    float[] fSpeed = new float[num];

    for (int i=0; i<num; i++) {
      fSpeed[i] = random(sMultiple/2, 1*sMultiple);
    }

    return fSpeed;
  }

  void dropLine8(float y, float[] speed) {
    //lineY = dWidth / 64 * 6;
    lineY = y;

    for (int i=0; i<hubNetwork.bits.length; i++) {
      color lineColor1 = make8BitColor(hubNetwork.bits[i]);
      YLine newLine1 = new YLine(sX+dWidth/8*i, lineY, dWidth/8, lineColor1);
      newLine1.initDropSpeed(speed[i]);
      newLine1.setStrokeWeight(sMultiple*3);
      newLine1.setRail(i);
      lines.add(newLine1);
    }

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();


      //if (line.rail == 1) line.setSRatio(1.4);
    }
  }

  // XXX
  void dropLine8s(float y, float[] speed) {
    //lineY = dWidth / 64 * 6;
    lineY = y;

    for (int i=0; i<hubNetwork.bits.length; i++) {
      //color lineColor1 = make8BitColor(hubNetwork.bits[i]);
      color lineColor1 = color(hubNetwork.hubData[i]);
      YLine newLine1 = new YLine(sX+dWidth/8*i, lineY, dW, lineColor1);
      newLine1.initDropSpeed(speed[i]);
      newLine1.setStrokeWeight(sMultiple*3);
      newLine1.setRail(i);
      lines.add(newLine1);
    }
    
    //XXX compare real & simulation
    //print("simul   ");print(hubNetwork.hubDataMin[0]);print("---");println(hubNetwork.hubDataMax[0]);
    //print("real   ");print(hubNetwork.hubDataMin[4]);print("---");println(hubNetwork.hubDataMax[4]);
    //print(hubNetwork.hubData[0]);print("-----");println(hubNetwork.hubData[4]);
    strokeWeight(2);
    //stroke(255, 0, 0);
    //point(800+hubNetwork.hubData[2], testY);
    //stroke(255);
    //point(800+hubNetwork.hubData[4], testY);
    //stroke(255, 255, 0);
    //point(800+hubNetwork.hubData[5], testY);

    stroke(0, hubNetwork.hubData[4]);
    line(oX, oY, 800+hubNetwork.hubData[4], testY);
    oX = 800+hubNetwork.hubData[4];
    oY = testY;
    testY = testY + 3;
    
    if (testY > sHeight) testY = 0;

    if (hubNetwork.hubDataOld[4] != hubNetwork.hubData[4]) {
      
      println("diff");//XXX 
      dW = dW - dWgap*0.2;
    } else {
      println("same");//XXX
      
      dW = dW - dWgap;
    }
    //if (dW < 0 || dW > dWidth/8 ) dWgap = dWgap * -1;
    if (dW < 0) dW = dWidth / 8;

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();


      //if (line.rail == 1) line.setSRatio(1.4);
    }
  }

  void dropLine1(float y) {
    lineY = y;

    for (int i=0; i<hubNetwork.bits.length; i++) {
      BWLine newLine = new BWLine(sX+dWidth/8*i, lineY, dWidth/8, hubNetwork.bits[i]);
      newLine.initDropSpeed(sMultiple*2);
      //newLine.setSRatio(sMultiple);
      //newLine.setBitHeight();
      lines.add(newLine);
    }

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();


      //if (line.rail == 1) line.setSRatio(1.4);
    }
  }


  //experiments
  void dropLine1s(float y) {
    lineY = y;

    //for (int i=0; i<8; i++) {
    //  BWLine newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[i], 255-30*i);
    //  newLine.initDropSpeed(sMultiple*5);
    //  lines.add(newLine);
    //}

    BWLine newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[0], 200);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);

    newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[1], 150);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);

    newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[2], 120);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);

    newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[3], 100);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);

    newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[4], 80);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);

    newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[5], 60);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);

    newLine = new BWLine(sX, lineY, dWidth/8, hubNetwork.bits[6], 25);
    newLine.initDropSpeed(sMultiple*5);
    lines.add(newLine);


    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();
    }
  }

  color make8BitColor(int[] bits) {
    int r = 256 / 8 * (bits[0]*4 + bits[1]*2 + bits[2]);
    int g = 256 / 8 * (bits[3]*4 + bits[4]*2 + bits[5]);
    int b = 256 / 4 * (bits[6]*2 + bits[7]);
    return color(r, g, b);
  }

  void dropMultiColorLines(float y) {
    //lineY = dWidth / 64 * 6;
    lineY = y;

    MultiYLine newLine = new MultiYLine(sX, lineY, dWidth, hubNetwork.hubData);
    newLine.initDropSpeed(sMultiple);
    newLine.setStrokeWeight(sMultiple*3);
    lines.add(newLine);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);
      line.show();
      line.drop();
    }
  }
}