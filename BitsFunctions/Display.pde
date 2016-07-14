class Display {
  HubNetwork h;
  InputOutput red, green;

  float startX, startY;
  int dWidth, dHeight;
  boolean needToClearBackground, needToClearCanvas;

  PGraphics canvas;
  int canvasWidth, canvasHeight;


  Display(int screenWidth, int screenHeight, HubNetwork hub) {
    needToClearBackground = true;
    needToClearCanvas = true;
    setHubConf(hub);

    if (screenWidth >= 1900) {
      startX = 506 - 270;
      dWidth = int(270 * 2);
    } else {
      startX = screenWidth/3/12;
      dWidth = int(screenWidth/3/12*10);
    }

    startY = 0;
    dHeight = screenHeight;

    canvasWidth = dWidth;
    canvasHeight = int(dHeight / 3 * 2);
    canvas = createGraphics(canvasWidth, canvasHeight);

    red = new InputOutput("赤", canvasWidth/2, canvasHeight/2).setColor(#66CCFF);
    //green = new InputOutput("緑", dWidth/2, dHeight/2).green(1);
    green = new InputOutput("緑", canvasWidth/2, canvasHeight/2).setColor(#333333);
    red.setHubConf(hub, 1);
    green.setHubConf(hub, 2);
    red.setDisplay(this);
    green.setDisplay(this);
  }

  void setHubConf(HubNetwork hub) {
    h = hub;
  }

  void show() {
    if (needToClearBackground) {
      noStroke();
      fill(200);
      rect(startX, startY, dWidth, dHeight);
      needToClearBackground = false;
    }

    canvas.beginDraw();
    if (needToClearCanvas) {
      canvas.background(255);
      needToClearCanvas = false;
    }
    if (h.dataChanged(0)) {
      //red.penDown(h.bits[0][0]).go(h.bits[0][1]).turnRight(h.bits[0][2]).turnRight(h.bits[0][3]);
      red.penDown(h.bits[0][0]).up(h.bits[0][1]).turnLeft(h.bits[0][2]).left(h.bits[0][3]).bigPen(h.bits[0][4]).down(h.bits[0][5]).right(h.bits[0][6]);
    }
    if (h.dataChanged(1)) {
      green.penDown(h.bits[1][0]).turnRight(h.bits[1][1]).go(h.bits[1][2]).turnLeft(h.bits[1][3]).play(h.bits[1][3]);
    }

    canvas.endDraw();
    image(canvas, startX, startY);

    red.show(1);
    green.show(1);
  }
} // Display end