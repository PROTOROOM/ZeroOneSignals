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

    // ---------------------------------------------- SCENE 1
    if (scene == 1) {
      setupCanvas(10, 60);


      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(5);
        tables[i].setDefaultPen(1);
      }

      tables[0].setBigPen(25);
      tables[0].setDefaultPen(10);
      tables[2].setBigPen(35);
      tables[2].setDefaultPen(20);

      tables[3].setBigPen(20);
      tables[3].setDefaultPen(10);
      tables[4].setBigPen(10);
      tables[4].setDefaultPen(8);
      tables[5].setBigPen(20);
      tables[5].setDefaultPen(13);
      tables[7].setBigPen(20);
      tables[7].setDefaultPen(15);
    }

    // ---------------------------------------------- SCENE 2
    if (scene == 2) {
      setupCanvas(20, 100);
      gridBackground = color(#ffff33);
      gridColor = color(#ff0000);

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(int(random(4, 15)));
        tables[i].setDefaultPen(int(random(1, 3)));
      }

      //tables[2].setBigPen(40);
      //tables[2].setDefaultPen(10);
      tables[5].setBigPen(30);
      tables[5].setDefaultPen(15);
      //tables[4].setBigPen(40);
      //tables[4].setDefaultPen(10);
      //tables[5].setBigPen(40);
      //tables[5].setDefaultPen(10);
    }

    // ---------------------------------------------- SCENE 3
    if (scene == 3) {
      setupCanvas(30, 90);
      //setupCanvas(30, 20);
      gridBackground = color(30);
      gridColor = color(60);

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(9);
        tables[i].setDefaultPen(3);
      }

      //tables[2].setBigPen(40);
      //tables[2].setDefaultPen(10);
      //tables[3].setBigPen(40);
      //tables[3].setDefaultPen(10);
      //tables[4].setBigPen(40);
      //tables[4].setDefaultPen(10);
      //tables[5].setBigPen(40);
      //tables[5].setDefaultPen(10);
    }

    // ---------------------------------------------- SCENE 4
    if (scene == 4) {
      setupCanvas(10, 50);
      showGrid = false;

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(5);
        tables[i].setDefaultPen(1);
      }

      //tables[2].setBigPen(40);
      //tables[2].setDefaultPen(10);
      tables[3].setBigPen(10);
      tables[3].setDefaultPen(6);
      tables[4].setBigPen(30);
      tables[4].setDefaultPen(1);
      //tables[5].setBigPen(40);
      //tables[5].setDefaultPen(10);
    }

    // ---------------------------------------------- SCENE 5
    if (scene == 5) {
      setupCanvas(10, 30);

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(4);
        tables[i].setDefaultPen(2);
      }

      tables[2].setBigPen(25);
      tables[2].setDefaultPen(15);
      tables[3].setBigPen(50);
      tables[3].setDefaultPen(23);
      tables[7].setBigPen(15);
      tables[7].setDefaultPen(7);
      //tables[5].setBigPen(40);
      //tables[5].setDefaultPen(10);
    }    

    // ---------------------------------------------- SCENE 6
    if (scene == 6) {
      setupCanvas(30, 90);
      //setupCanvas(30, 20);
      gridBackground = color(50);
      gridColor = color(70);

      for (int i=0; i<tables.length; i++) {
        tables[i].setStartPosition(canvasCol/2, canvasRow/2);
        tables[i].setBigPen(9);
        tables[i].setDefaultPen(3);
      }

      //tables[2].setBigPen(40);
      //tables[2].setDefaultPen(10);
      //tables[3].setBigPen(40);
      //tables[3].setDefaultPen(10);
      //tables[4].setBigPen(40);
      //tables[4].setDefaultPen(10);
      //tables[5].setBigPen(40);
      //tables[5].setDefaultPen(10);
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
    // ---------------------------------------------- SCENE 1
    if (scene == 1) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 0) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow1(h.bits[i][6]).red2(h.bits[i][7]).end();
          } else if (i == 1) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue2(h.bits[i][6]).blue1(h.bits[i][7]).end();
          } else if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).gray2(h.bits[i][7]).end();
          } else if (i == 4) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue4(h.bits[i][6]).gray1(h.bits[i][7]).end();
          } else if (i == 5) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 6) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).gray3(h.bits[i][5]).blue2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 7) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green1(h.bits[i][6]).yellow2(h.bits[i][7]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][7]).end();
          }
        }
      }
    }
    // ---------------------------------------------- SCENE 2
    if (scene == 2) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 5) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).red1(h.bits[i][6]).green2(h.bits[i][7]).end();
            //} else if (i == 5) {
            //  tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
            //    .up(h.bits[i][4]).upRight(h.bits[i][5]).green(h.bits[i][6]).black(h.bits[i][7]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .left(h.bits[i][4]).gray1(h.bits[i][5]).gray2(h.bits[i][6]).gray3(h.bits[i][7]).end();
          }
        }
      }
    }

    // ---------------------------------------------- SCENE 3
    if (scene == 3) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 0) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow1(h.bits[i][6]).red2(h.bits[i][7]).end();
          } else if (i == 1) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).blue2(h.bits[i][6]).blue1(h.bits[i][7]).end();
          } else if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow4(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow4(h.bits[i][6]).gray2(h.bits[i][7]).end();
          } else if (i == 4) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).blue4(h.bits[i][6]).gray1(h.bits[i][7]).end();
          } else if (i == 5) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).green2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 6) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).gray3(h.bits[i][5]).blue2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 7) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).green1(h.bits[i][6]).yellow2(h.bits[i][7]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][7]).end();
          }
        }
      }
    }


    // ---------------------------------------------- SCENE 4
    //if (scene == 4) {
    //  for (int i=0; i<tables.length; i++) {
    //    if (h.dataChanged(i)) {
    //      if (i == 2) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
    //          .green(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).blue(h.bits[i][7]).end();
    //      } else if (i == 3) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //          .up(h.bits[i][4]).upRight(h.bits[i][5]).blue(h.bits[i][6]).yellow(h.bits[i][7]).end();
    //      } else if (i == 4) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //          .up(h.bits[i][4]).upRight(h.bits[i][5]).green(h.bits[i][6]).black(h.bits[i][7]).end();
    //        //} else if (i == 5) {
    //        //  tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //        //    .up(h.bits[i][4]).green(h.bits[i][5]).upRight(h.bits[i][6]).black(h.bits[i][7]).end();
    //      } else {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //          .up(h.bits[i][4]).left(h.bits[i][5]).up(h.bits[i][6]).blue(h.bits[i][7]).end();
    //      }
    //    }
    //  }
    //}
    if (scene == 4) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 0) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow1(h.bits[i][6]).red2(h.bits[i][7]).end();
          } else if (i == 1) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue2(h.bits[i][6]).blue1(h.bits[i][7]).end();
          } else if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).gray2(h.bits[i][7]).end();
          } else if (i == 4) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue4(h.bits[i][6]).gray1(h.bits[i][7]).end();
          } else if (i == 5) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 6) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).gray3(h.bits[i][5]).blue2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 7) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green1(h.bits[i][6]).yellow2(h.bits[i][7]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][7]).end();
          }
        }
      }
    }




    // ---------------------------------------------- SCENE 5
    //if (scene == 5) {
    //  for (int i=0; i<tables.length; i++) {
    //    if (h.dataChanged(i)) {
    //      if (i == 2) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
    //          .yellow(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).black(h.bits[i][7]).end();
    //      } else if (i == 3) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //          .up(h.bits[i][4]).upRight(h.bits[i][5]).red(h.bits[i][6]).yellow(h.bits[i][7]).end();
    //      } else if (i == 4) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //          .up(h.bits[i][4]).right(h.bits[i][5]).red(h.bits[i][6]).black(h.bits[i][7]).end();
    //        //} else if (i == 5) {
    //        //  tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
    //        //    .up(h.bits[i][4]).green(h.bits[i][5]).upRight(h.bits[i][6]).black(h.bits[i][7]).end();
    //      } else {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).down(h.bits[i][2]).right(h.bits[i][3])
    //          .left(h.bits[i][4]).up(h.bits[i][5]).blue(h.bits[i][6]).down(h.bits[i][7]).end();
    //      }
    //    }
    //  }
    //}
    if (scene == 5) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 0) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow1(h.bits[i][6]).red2(h.bits[i][7]).end();
          } else if (i == 1) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue2(h.bits[i][6]).blue1(h.bits[i][7]).end();
          } else if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).gray2(h.bits[i][7]).end();
          } else if (i == 4) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue4(h.bits[i][6]).gray1(h.bits[i][7]).end();
          } else if (i == 5) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 6) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).gray3(h.bits[i][5]).blue2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 7) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green1(h.bits[i][6]).yellow2(h.bits[i][7]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][7]).end();
          }
        }
      }
    }




    // ---------------------------------------------- SCENE 6
    //if (scene == 6) {
    //  for (int i=0; i<tables.length; i++) {
    //    if (h.dataChanged(i)) {
    //      if (i == 2) {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).down(h.bits[i][2]).right(h.bits[i][3])
    //          .left(h.bits[i][4]).up(h.bits[i][5]).yellow(h.bits[i][6]).green(h.bits[i][7]).end();
    //      } else {
    //        tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).down(h.bits[i][2]).right(h.bits[i][3])
    //          .left(h.bits[i][4]).up(h.bits[i][5]).blue(h.bits[i][6]).red(h.bits[i][7]).end();
    //      }
    //    }
    //  }
    //}
    if (scene == 6) {
      for (int i=0; i<tables.length; i++) {
        if (h.dataChanged(i)) {
          if (i == 0) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).down(h.bits[i][5]).yellow1(h.bits[i][6]).red2(h.bits[i][7]).end();
          } else if (i == 1) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue2(h.bits[i][6]).blue1(h.bits[i][7]).end();
          } else if (i == 2) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 3) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).yellow4(h.bits[i][6]).gray2(h.bits[i][7]).end();
          } else if (i == 4) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).blue4(h.bits[i][6]).gray1(h.bits[i][7]).end();
          } else if (i == 5) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 6) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).gray3(h.bits[i][5]).blue2(h.bits[i][6]).red1(h.bits[i][7]).end();
          } else if (i == 7) {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .up(h.bits[i][4]).upRight(h.bits[i][5]).green1(h.bits[i][6]).yellow2(h.bits[i][7]).end();
          } else {
            tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).left(h.bits[i][2]).right(h.bits[i][3])
              .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][7]).end();
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
      for (int i=0; i<col+1; i++) {
        canvas.line(i*canvasStepWidth, startY, i*canvasStepWidth, canvasHeight);
      }
      for (int i=0; i<row+2; i++) {
        canvas.line(0, i*canvasStepHeight, canvasWidth, i*canvasStepHeight);
      }
    }
  }

  void drawCodeFolder() {
    float folderX = startX;
    float folderY = canvasHeight-padding*4;
    image(codeTop, folderX, folderY);


    float codeX = folderX + 2*padding-9;
    float codeY = folderY + padding*10;
    noStroke();
    //stroke(0);
    fill(255);
    //rect(codeX+padding, folderY+10*padding, dWidth-8*padding, dHeight-codeY);
    rect(startX, codeY-padding*3, dWidth, dHeight - folderY);


    String codeName;
    String codeRed;

    // print code string
    textFont(codeFont);
    textAlign(LEFT, BOTTOM);
    textSize(18);
    fill(0);
    for (int i=0; i<tables.length; i++) {
      int commandNumber = tables[i].commands.size();
      rect(codeX-6, codeY+i*55-16, 4, 35);
      int hi = tables[i].hi;
      text(tables[i].name, codeX, codeY+i*55);

      //stroke(255, 0, 0);
      //point(codeX, codeY+i*55);

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