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
  
  PImage codeTop;
  int padding = 10;


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
    canvasHeight = int(dHeight / 4 * 3);
    canvas = createGraphics(canvasWidth, canvasHeight, P2D);
    // (60, 12), 
    canvasCol = 60;
    canvasRow = 90;
    canvasStepWidth = canvasWidth / canvasCol;
    canvasStepHeight = canvasHeight / canvasRow;


    red = new InputOutput(this, "赤", 30, 25).red(1);
    black = new InputOutput(this, "緑", 30, 25).blue(1);
    //green = new InputOutput("緑", canvasWidth/2, canvasHeight/2).setColor(#333333);
    red.setHubConf(hub, 5);
    black.setHubConf(hub, 6);

    codeTop = loadImage("folder_top.png");
    codeTop.resize(dWidth - padding*2, 95);
  }

  void setHubConf(HubNetwork hub) {
    h = hub;
  }

  void show() {
    if (needToClearBackground) {
      noStroke();
      fill(255);
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
      red.penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).up(h.bits[i][3]).right(h.bits[i][4]).red(h.bits[i][5]).left(h.bits[i][6]).blue(h.bits[i][7]);
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
    
    image(codeTop, startX+padding, canvasHeight-padding*4);
    
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