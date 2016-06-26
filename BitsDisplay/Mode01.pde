class ColorFall extends BasicBitsScreen {
  ArrayList<YLine> lines = new ArrayList<YLine>();

  ColorFall(float w, float h) {
    super(w, h);
  }

  void show() {
    
    strokeWeight(0.5);
    
    color lineColor = color(hubNetwork.hubData[0], hubNetwork.hubData[1], hubNetwork.hubData[2]);
    YLine newLine = new YLine(lineColor);
    lines.add(newLine);

    for (int i=lines.size()-1; i>=0; i--) {
      YLine line = lines.get(i);
      if (line.isOut) lines.remove(i);

      line.move();
      line.show();
    }
    
    drawTopHubBits();
  }
  

  void drawTopHubBits() {
    bitBarWidth = sWidth / 64;
    for (int i=0; i<hubNetwork.bits.length; i++) {
      float startX = i*bitBarWidth*nodePerHub;     
      drawNodeBars(startX, 0, bitBarWidth, hubNetwork.bits[i]);
    }
  }
}


class YLine {
  float y;
  color c;
  boolean isOut;

  YLine(color initColor) {
    y = 0;
    c = initColor;
    isOut = false;
  }

  void move() {
    y = y + 1;
    if (y > height) isOut = true;
  }

  void show() {
    stroke(c);
    line(0, y, displayWidth, y);
  }
}