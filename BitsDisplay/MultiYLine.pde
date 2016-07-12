class MultiYLine extends YLine {
  int[] bitData;
  color[] lineColors = new color[8];
  float sLineWidth;
  boolean isChanged, isChanged2;

  MultiYLine(float sX, float sY, float w, int[] data) {
    super(sX, sY, w, color(0));
    bitData = data;
    sLineWidth = lineWidth / bitData.length;

    isChanged = false;
    isChanged2 = false;

    for (int i=0; i<bitData.length; i++) {
      lineColors[i] = chooseColor(i);
    }
  }

  void show() {
    strokeCap(SQUARE);
    strokeWeight(sWeight);
    for (int i=0; i<bitData.length; i++) {
      stroke(lineColors[i]);
      float lx = x+i*sLineWidth;
      line(lx, y, lx+sLineWidth, y);
    }
  }

  color chooseColor(int i) {
    color c = color(0);
    if (i == 0) c = color(bitData[i], 0, 0);
    if (i == 1) c = color(0, bitData[i], 0);
    if (i == 2) c = color(0, 0, bitData[i]);
    if (i == 3) c = color(bitData[i]);
    if (i == 4) c = color(bitData[i], 0, 0);
    if (i == 5) c = color(0, bitData[i], 0);
    if (i == 6) c = color(0, 0, bitData[i]);
    if (i == 7) c = color(bitData[i]);

    return c;
  }

  //if (y > height/7 && !isChanged) {
  //  lineColors[0] = lineColors[0] + lineColors[1];
  //  lineColors[1] = lineColors[0];

  //lineColors[4] = lineColors[4] + lineColors[5] + lineColors[6] + lineColors[7];
  //lineColors[5] = lineColors[4];
  //lineColors[6] = lineColors[4];
  //lineColors[7] = lineColors[4];

  //lineColors[6] = lineColors[6] + lineColors[7];
  //lineColors[7] = lineColors[6];

  //isChanged = true;
  //}
  //    
  //if ( y > height/3 && !isChanged2) {
  //  lineColors[0] = lineColors[0]
  //}
}


class BWLine extends YLine {
  float bitW, bitH;
  int[] bits;
  BWLine(float sX, float sY, float w, int[] aBits) {
    super(sX, sY, w, color(255));
    bitW = w/8;
    bitH = w/8;
    bits = aBits;
  }

  void show() {
    for (int i=0; i<bits.length; i++) {
      if (bits[i] == 1) {
        fill(255);
      } else {
        fill(0);
      }
      rect(x+bitW*i, y, bitW, bitH);
    }

    //bitH = bitH + dropSpeed;
    bitH = dropSpeed;
  }

  void drop() {
    //dropSpeed = dropSpeed + sRatio;
    y = y + dropSpeed;
    //sWeight = sWeight * sRatio;
    if (y > height) isOut = true;
  }
}

class YLine {
  float x, y, lineWidth, sWeight;
  color c;
  boolean isOut;
  float dropSpeed, sRatio;
  int rail;

  YLine(float sX, float sY, float w, color initColor) {
    x = sX;
    y = sY;
    lineWidth = w; 
    c = initColor;
    isOut = false;
    dropSpeed = 1;

    //sRatio = random(1.005, 1.01);
    sRatio = 1.02;
    rail = -1;
  }

  void initDropSpeed(float s) {
    dropSpeed = s;
  }

  void setStrokeWeight(float value) {
    sWeight = value;
  }

  void setRail(int n) {
    rail = n;
  }

  void setSRatio(float r) {
    sRatio = r;
  }

  void move(float speed) {
    y = y + speed;
    if (y > height) isOut = true;
  }

  void drop() {
    dropSpeed = dropSpeed * sRatio;
    y = y + dropSpeed;
    sWeight = sWeight * sRatio;
    if (y > height) isOut = true;
  }


  void show() {
    stroke(c);
    strokeCap(SQUARE);
    strokeWeight(sWeight);
    line(x, y, x+lineWidth, y);
    //fill(c);
    //rect(x, y, lineWidth, 1);
  }
}