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


    //red = new InputOutput(this, "赤", 30, 25).red(1);
    //black = new InputOutput(this, "緑", 30, 25).blue(1);
    //green = new InputOutput("緑", canvasWidth/2, canvasHeight/2).setColor(#333333);
    //red.setHubConf(hub, 5);
    //black.setHubConf(hub, 6);

    codeTop = loadImage("folder.png");
    codeTop.resize(dWidth - padding*2, 503);
  }

  void setHubConf(HubNetwork hub) {
    h = hub;
  }

  // ################################################### SETUP for new Scene
  void setupInputOutputs(int scene) {
    // init all InputOutput Objects
    if (scene == 0) {
      canvasRow = 120;
      canvasCol = 20;
      canvasStepWidth = canvasWidth / canvasCol;
      canvasStepHeight = canvasHeight / canvasRow;

      tables = new InputOutput[8];
      for (int i=0; i<tables.length; i++) {
        InputOutput t =  new InputOutput(this, tableNames[i], canvasCol/2, canvasRow/2).setColor(tableColors[i]);
        t.setHubConf(h, i+1);
        tables[i] = t;
      }
    }

    if (scene == 1) {
      canvasRow = 30;
      canvasCol = 10;
      canvasStepWidth = canvasWidth / canvasCol;
      canvasStepHeight = canvasHeight / canvasRow;

      tables = new InputOutput[2];
      InputOutput t1 = new InputOutput(this, tableNames[0], canvasCol/2, canvasRow/2).setColor(tableColors[0]);
      InputOutput t2 = new InputOutput(this, tableNames[1], canvasCol/2, canvasRow/2).setColor(tableColors[1]);

      t1.setHubConf(h, 1);
      t2.setHubConf(h, 1);

      tables[0] = t1;
      tables[1] = t2;
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
      canvas.background(255);
      drawCanvasGrid(canvasRow, canvasCol);
      needToClearCanvas = false;
    }


    for (int i=0; i<tables.length; i++) {
      if (h.dataChanged(i)) {

        //tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).up(h.bits[i][3]).right(h.bits[i][4]).down(h.bits[i][5]).left(h.bits[i][6]).upLeft(h.bits[i][7]);

        //tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).up(h.bits[i][3]).right(h.bits[i][4]).down(h.bits[i][5]).left(h.bits[i][6]);//.upLeft(h.bits[i][7]);

        //tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
        //  .down(h.bits[i][4]).left(h.bits[i][5]);

        if (i == 2) {
          tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).left(h.bits[i][3])
            .red(h.bits[i][4]).down(h.bits[i][5]).red(h.bits[i][6]).green(h.bits[i][6]);
        } else if (i == 3) {
          tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
            .up(h.bits[i][4]).green(h.bits[i][5]).upRight(h.bits[i][6]).black(h.bits[i][6]);
        } else {

          tables[i].penDown(h.bits[i][0]).bigPen(h.bits[i][1]).downLeft(h.bits[i][2]).right(h.bits[i][3])
            .downLeft(h.bits[i][4]).upLeft(h.bits[i][5]).up(h.bits[i][6]).down(h.bits[i][6]);
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
    canvas.stroke(220);
    canvas.strokeWeight(1);

    canvasStepWidth = canvasWidth / col;
    canvasStepHeight = canvasHeight / row;

    for (int i=0; i<col; i++) {
      canvas.line(i*canvasStepWidth, startY, i*canvasStepWidth, canvasHeight);
    }
    for (int i=0; i<row; i++) {
      canvas.line(0, i*canvasStepHeight, canvasWidth, i*canvasStepHeight);
    }
  }

  void drawCodeFolder() {
    float folderX = startX + padding;
    float folderY = canvasHeight-padding*4;
    image(codeTop, folderX, folderY);


    float codeX = folderX + 2*padding;
    float codeY = folderY + padding*13;
    noStroke();
    //stroke(0);
    fill(255);
    rect(codeX+padding, folderY+10*padding, dWidth-8*padding, dHeight-codeY);


    String codeName;
    String codeRed;
    //String codeName = "上上4";
    //String codeRed = ".上("+str(h.bits[3][0])+").上("+str(h.bits[3][1])+").右("+str(h.bits[3][2])+").左("+str(h.bits[0][3])+").上("+str(h.bits[3][4])+").右("+str(h.bits[3][5])+").左("+str(h.bits[0][6])+").下("+str(h.bits[0][7])+");";
    ////String codeRed2 = "      .上("+str(h.bits[3][4])+").右("+str(h.bits[3][5])+").左("+str(h.bits[0][6])+").下("+str(h.bits[0][7])+");";
    //textSize(20);
    //fill(0);
    //text(codeName, codeX, codeY);
    //text(codeRed, codeX, codeY+30);

    for (int i=0; i<8; i++) {
      codeName = "上上5";
      codeRed = ".上("+str(h.bits[3][0])+").上("+str(h.bits[3][1])+").右("+str(h.bits[3][2])+").左("+str(h.bits[0][3])+").上("+str(h.bits[3][4])+").右("+str(h.bits[3][5])+").左("+str(h.bits[0][6])+").下("+str(h.bits[0][7])+");";
      //String codeRed2 = "      .上("+str(h.bits[3][4])+").右("+str(h.bits[3][5])+").左("+str(h.bits[0][6])+").下("+str(h.bits[0][7])+");";
      textSize(18);
      fill(0);
      text(codeName, codeX, codeY+50*i);
      text(codeRed, codeX, codeY+50*i+25);
    }
  }

  void saveCanvas() {
    saveFrame = true;
  }
} // Display end