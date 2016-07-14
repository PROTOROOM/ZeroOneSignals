class Display {
  HubNetwork h;
  InputOutput red, green, black;

  float startX, startY;
  int dWidth, dHeight;
  boolean needToClearBackground, needToClearCanvas;

  PGraphics canvas;
  int canvasWidth, canvasHeight;
  int canvasRow, canvasCol;
  float canvasStepWidth, canvasStepHeight;


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
    canvas = createGraphics(canvasWidth, canvasHeight, P2D);
    canvasCol = 60;
    canvasRow = 60;
    canvasStepWidth = canvasWidth / canvasCol;
    canvasStepHeight = canvasHeight / canvasRow;


    red = new InputOutput(this, "赤", 30, 30).red(1);
    black = new InputOutput(this, "緑", 35, 35).black(1);
    //green = new InputOutput("緑", canvasWidth/2, canvasHeight/2).setColor(#333333);
    red.setHubConf(hub, 5);
    black.setHubConf(hub, 6);
    //green.setHubConf(hub, 6);
    //red.setDisplay(this);
    //green.setDisplay(this);
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

    canvas.smooth();
    canvas.beginDraw();


    if (needToClearCanvas) {
      canvas.background(255);
      drawCanvasGrid();
      needToClearCanvas = false;
    }

    int i = 0;
    if (h.dataChanged(i)) {
      //red.penDown(h.bits[0][0]).goReal(h.bits[0][1]).turnRight(h.bits[0][2]).turnRight(h.bits[0][3]);
      red.penDown(h.bits[i][0]).bigPen(h.bits[i][1]).upRight(h.bits[i][2]).downLeft(h.bits[i][3]).downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).downRight(h.bits[i][6]).upRight(h.bits[i][7]);
    }
    i = 1;
    if (h.dataChanged(i)) {
      //red.penDown(h.bits[0][0]).goReal(h.bits[0][1]).turnRight(h.bits[0][2]).turnRight(h.bits[0][3]);
      black.penDown(h.bits[i][0]).upRight(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3]).downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).downRight(h.bits[i][6]).bigPen(h.bits[i][7]);
    }







    canvas.endDraw();
    image(canvas, startX, startY);

    red.show(1);
    black.show(1);
    //green.show(1);
  }

  void drawCanvasGrid() {
    canvas.stroke(220);
    canvas.strokeWeight(1);
    for (int i=0; i<canvasCol; i++) {
      canvas.line(i*canvasStepWidth, startY, i*canvasStepWidth, canvasHeight);
    }
    for (int i=0; i<canvasRow; i++) {
      canvas.line(0, i*canvasStepHeight, canvasWidth, i*canvasStepHeight);
    }
  }
} // Display end