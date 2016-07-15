class Display {
  HubNetwork h;
  InputOutput[] tables; // = new InputOutput[8];


  float startX, startY;
  int dWidth, dHeight;
  boolean needToClearBackground, needToClearCanvas;

  PGraphics canvas;
  int canvasWidth, canvasHeight;
  int canvasRow, canvasCol;
  float canvasStepWidth, canvasStepHeight;
  color gridBackground, gridColor;
  boolean showGrid;

  PImage codeTop;
  int padding = 10;

  boolean saveFrame;


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

    // default canvas row and col : change new in setupInputOutputs
    canvasRow = 120;
    canvasCol = 20;

    canvasStepWidth = canvasWidth / canvasCol;
    canvasStepHeight = canvasHeight / canvasRow;

    gridBackground = color(255);
    gridColor = color(220);
    showGrid = true;

    //red = new InputOutput(this, "赤", 30, 25).red(1);
    //black = new InputOutput(this, "緑", 30, 25).blue(1);
    //green = new InputOutput("緑", canvasWidth/2, canvasHeight/2).setColor(#333333);
    //red.setHubConf(hub, 5);
    //black.setHubConf(hub, 6);

    codeTop = loadImage("folder_top.png");
    codeTop.resize(dWidth, 93);
  }

  void setHubConf(HubNetwork hub) {
    h = hub;
  }

  void setupCanvas(int col, int row) {
    canvasRow = row;
    canvasCol = col;
    canvasStepWidth = canvasWidth / canvasCol;
    canvasStepHeight = canvasHeight / canvasRow;
    gridBackground = color(255);
    gridColor = color(220);
    showGrid = true;
  }

  // ################################################### SETUP1 for new Scene
  void setupInputOutputs(int scene) {
    // init all InputOutput Objects
    tables = new InputOutput[8];
    for (int i=0; i<tables.length; i++) {
      InputOutput t =  new InputOutput(this, tableNames[i]).setColor(tableColors[i]);
      t.setHubConf(h, i+1);
      tables[i] = t;
    }    

    if (scene == 1) {
      setupCanvas(20, 120);


      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(5);
        tables[i].setDefaultPen(1);
      }
    }

    if (scene == 2) {
      setupCanvas(20, 100);
      gridBackground = color(#666666);

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(5);
        tables[i].setDefaultPen(1);
      }

      tables[3].setBigPen(40);
      tables[3].setDefaultPen(10);
    }

    if (scene == 3) {
      setupCanvas(20, 100);
      showGrid = false;

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(5);
        tables[i].setDefaultPen(1);
      }

      tables[3].setBigPen(40);
      tables[3].setDefaultPen(10);
    }

    if (scene == 4) {
      setupCanvas(10, 30);

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(4);
        tables[i].setDefaultPen(2);
      }

      tables[3].setBigPen(40);
      tables[3].setDefaultPen(20);
    }
  }


  void clean() {
    needToClearBackground = true;
    needToClearCanvas = true;
  }


  void show(int scene) {
    if (saveFrame == true) {
      PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, "test.pdf");
      pdf.rect(startX, startY, dWidth, dHeight);
    }

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
      canvas.background(gridBackground);
      drawCanvasGrid(canvasRow, canvasCol);
      needToClearCanvas = false;
    }

    // SETUP2 for Scene
    if (scene == 1) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .red(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).green(h.bits[i][6]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).green(h.bits[i][5]).upRight(h.bits[i][6]).black(h.bits[i][6]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][6]).end();
          }
        }
      }
    }

    if (scene == 2) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .red(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).green(h.bits[i][6]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).green(h.bits[i][5]).upRight(h.bits[i][6]).yellow(h.bits[i][6]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][6]).end();
          }
        }
      }
    }

    if (scene == 3) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .green(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).blue(h.bits[i][6]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).blue(h.bits[i][5]).upRight(h.bits[i][6]).yellow(h.bits[i][6]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][6]).end();
          }
        }
      }
    }

    if (scene == 4) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .yellow(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).black(h.bits[i][6]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).red(h.bits[i][5]).upRight(h.bits[i][6]).yellow(h.bits[i][6]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).down(h.bits[i][2]).right(h.bits[i][3])
              .left(h.bits[i][4]).up(h.bits[i][5]).blue(h.bits[i][6]).down(h.bits[i][6]).end();
          }
        }
      }
    }


    canvas.endDraw();
    image(canvas, startX, startY);
    // ------------------- in Canvas END

    for (int i=0; i<tables.length; i++) {
      tables[i].show(1);
    }

    drawCodeFolder();

    if (saveFrame == true) {
      endRaw();
      saveFrame = false;
    }
  }


  void drawCanvasGrid(int row, int col) {
    canvas.stroke(gridColor);
    canvas.strokeWeight(1);

    //canvasStepWidth = canvasWidth / col;
    //canvasStepHeight = canvasHeight / row;

    if (showGrid) {
      for (int i=0; i<col; i++) {
        canvas.line(i*canvasStepWidth, startY, i*canvasStepWidth, canvasHeight);
      }
      for (int i=0; i<row; i++) {
        canvas.line(0, i*canvasStepHeight, canvasWidth, i*canvasStepHeight);
      }
    }
  }

  void drawCodeFolder() {
    float folderX = startX;
    float folderY = canvasHeight-padding*4;
    image(codeTop, folderX, folderY);


    float codeX = folderX + 2*padding;
    float codeY = folderY + padding*13;
    noStroke();
    //stroke(0);
    fill(255);
    //rect(codeX+padding, folderY+10*padding, dWidth-8*padding, dHeight-codeY);
    rect(startX, codeY-padding*2, dWidth, dHeight - folderY);


    String codeName;
    String codeRed;

    // print code string
    textSize(18);
    fill(0);
    for (int i=0; i<tables.length; i++) {
      int commandNumber = tables[i].commands.size();
      rect(codeX-12, codeY+i*55-13, 4, 37);
      int hi = tables[i].hi;
      text(tables[i].name, codeX, codeY+i*55);

      if (commandNumber > 0) {
        String commandString = "";

        for (int j=0; j<tables[i].commands.size(); j++) {
          String c = tables[i].commands.get(j);
          commandString = commandString + "." + c + "(" + str(h.bits[hi][j]) + ")";
        }
        commandString = commandString + ";";
        text(commandString, codeX, codeY+i*55+20);
      }
      
    }
  }

  void saveCanvas() {
    saveFrame = true;
  }
} // Display end