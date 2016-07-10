class MYLine {
  float x, y, lineWidth;
  
  MYLine(float sX, float sY, float w, color[] initColors) {
  }
  
  void drop() {
  }
}


class YLine {
  float x, y, lineWidth, sWeight;
  color c;
  boolean isOut;
  float dropSpeed, sRatio;

  YLine(float sX, float sY, float w, color initColor) {
    x = sX;
    y = sY;
    lineWidth = w; 
    c = initColor;
    isOut = false;
    dropSpeed = 1;

    //sRatio = random(1.01, 1.03);
    sRatio = 1.01;
  }
  
  void initDropSpeed(float s) {
    dropSpeed = s;
  }
  
  void setStrokeWeight(float value) {
    sWeight = value;
  }

  void move(float speed) {
    y = y + speed;
    if (y > height) isOut = true;
  }

  void drop() {
    dropSpeed = dropSpeed * sRatio;
    y = y + dropSpeed;
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