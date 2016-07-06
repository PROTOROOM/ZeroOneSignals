class ColorFall extends BasicBitsScreen {
  ArrayList<YLine> lines = new ArrayList<YLine>();
  float sX, sY, dWidth;
  float dropSpeed;


  ColorFall(float w, float h) {
    super(w, h);
    sX = sWidth / 3;
    sY = dWidth / 64 * 7;
    dWidth = sWidth / 3;
    dropSpeed = sMultiple;
  }

  void show() {

    strokeWeight(sMultiple*3);

    color lineColor1 = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2], hubNetwork.hubData[3]);
    color lineColor2 = color(hubNetwork.hubData[4], hubNetwork.hubData[5], hubNetwork.hubData[6], hubNetwork.hubData[7]);
    //YLine newLine1 = new YLine(sX, sY, dWidth/2, lineColor1);
    //YLine newLine2 = new YLine(sX+dWidth/2, sY+1, dWidth/2, lineColor2);

    YLine newLine1 = new YLine(sX, sY, dWidth, lineColor1);
    YLine newLine2 = new YLine(sX, sY+1, dWidth, lineColor2);

    lines.add(newLine1);
    lines.add(newLine2);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);

      line.move(dropSpeed/3);
      line.show();
    }

    drawTopHubBits();
  }


  void drawTopHubBits() {
    bitBarWidth = dWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = sX + (i*bitBarWidth*nodePerHub);     
      drawNodeBars(startX, 0, bitBarWidth, bitBarWidth*5, hubNetwork.bits[i]);
    }
  }
}


class YLine {
  float x, y, lineWidth;
  color c;
  boolean isOut;

  YLine(float sX, float sY, float w, color initColor) {
    x = sX;
    y = sY;
    lineWidth = w; 
    c = initColor;
    isOut = false;
  }

  void move(float dropSpeed) {
    y = y + dropSpeed;
    if (y > height) isOut = true;
  }

  void show() {
    stroke(c);
    strokeCap(SQUARE);
    line(x, y, x+lineWidth, y);
    //fill(c);
    //rect(x, y, lineWidth, 1);
  }
}