class Display {
  HubNetwork h;
  InputOutput[] tables = new InputOutput[8];


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


    // init all InputOutput Objects
    for (int i=0; i<tables.length; i++) {
      InputOutput t =  new InputOutput(this, tableNames[i], canvasCol/2, canvasRow/2).setColor(tableColors[i]);
      t.setHubConf(hub, i+1);
      tables[i] = t;
    }

    //red = new InputOutput(this, "赤", 30, 25).red(1);
    //black = new InputOutput(this, "緑", 30, 25).blue(1);
    //green = new InputOutput("緑", canvasWidth/2, canvasHeight/2).setColor(#333333);
    //red.setHubConf(hub, 5);
    //black.setHubConf(hub, 6);

    codeTop = loadImage("folder_top.png");
    codeTop.resize(dWidth - padding*2, 95);
  }

  void setHubConf(HubNetwork hub) {
    h = hub;
  }

  void show(int mode) {
    if (needToClearBackground) {
      noStroke();
      fill(255);
      rect(startX, startY, dWidth, dHeight);
      needToClearBackground = false;
    }

    // ------------------- in Canvas
    canvas.smooth();
    canvas.beginDraw();


    if (needToClearCanvas) {
      canvas.background(255);
      drawCanvasGrid();
      needToClearCanvas = false;
    }


    for (int i=0; i<tables.length; i++) {
      if (h.dataChanged(i)) {

        //tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).up(h.bits[i][3]).right(h.bits[i][4]).down(h.bits[i][5]).left(h.bits[i][6]).upLeft(h.bits[i][7]);

        //tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).up(h.bits[i][3]).right(h.bits[i][4]).down(h.bits[i][5]).left(h.bits[i][6]);//.upLeft(h.bits[i][7]);

        //tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
        //  .down(h.bits[i][4]).left(h.bits[i][5]);

        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
          .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]);
        
      }
    }







    canvas.endDraw();
    image(canvas, startX, startY);
    // ------------------- in Canvas END

    for (int i=0; i<tables.length; i++) {
      if (h.dataChanged(i)) tables[i].show(1);
    }

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