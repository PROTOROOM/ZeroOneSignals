class InputOutput {
  float x, y;
  float cX, cY;
  int pX, pY;

  float head;
  int direction; // 0(right) - 7 clockwise  


  boolean isPenDown;
  float penSize;
  color penColor;
  float stepSize;

  String name;
  int commandIndex;
  ArrayList<String> commands = new ArrayList<String>();


  // HubNetwork & index
  HubNetwork h;
  int hi;

  Display display;
  PGraphics c;

  //AudioOutput out;
  Oscil wave;


  //InputOutput(String aName, float posX, float posY) { // XXX change to grid postion system.
  InputOutput(Display d, String aName, int posX, int posY) {
    setDisplay(d);
    x = posX*display.canvasStepWidth;
    y = posY*display.canvasStepHeight;
    //pX = posX;
    //pY = posY;
    head = 0;
    isPenDown = false;
    penSize = 2;
    penColor = color(0);
    stepSize = 10;

    name = aName;
    commandIndex = 0;
    //hubIndex = id-1;
  }

  float getXfromCanvasPosX(int p) {
    return display.startX + display.canvasStepWidth * p;
  }
  float getYfromCanvasPosY(int p) {
    return display.startY + display.canvasStepHeight * p;
  }
  //float getCX(int p) {
  //  return display.canvasStepWidth * p;
  //}
  //float getCY(int p) {
  //  return display.canvasStepHeight * p;
  //}

  void show(int in) {
    if (isTrue(in)) {
      cX = display.startX + x;
      cY = display.startY + y;
      //float px = getXfromCanvasPosX(pX);
      //float py = getYfromCanvasPosY(pY);


      noStroke();
      fill(penColor);
      ellipse(cX, cY, penSize*4, penSize*4);
    }
  }

  void setHubConf(HubNetwork hub, int id) {
    h = hub;
    hi = id - 1;
  }

  void setDisplay(Display d) {
    display = d;
    c = display.canvas;
  }


  String getCodeString() {
    String codeString = name;

    for (int i=0; i<commands.size(); i++) {
      String c = commands.get(i);
      codeString = codeString + "." + c + "(" + h.bits[hi][i] + ")";
    }

    commands = new ArrayList<String>();
    return codeString;
  }

  void addCommand(String command) {
    commands.add(command);
  }

  boolean isTrue(int in) {
    if (in == 1) return true;
    else return false;
  }

  // ###################### Sound ######################
  //void setSound(AudioOutput o) {
  //  //out = o;
  //  //wave = w;
  //  //wave.patch(out);
  //  out = o;
  //}


  InputOutput play(int in) {
    //if (isTrue(in)) {
    //  OUT.playNote(1.0, 0.3, new SineInstrument( 123.47 ));
    //}
    return this;
  }

  // ###################### Color ######################
  InputOutput setColor(color c) {
    penColor = c;
    return this;
  }

  InputOutput red(int in) {
    if (isTrue(in)) {
      penColor = color(#ff3333);
    } 

    return this;
  }

  InputOutput black(int in) {
    if (isTrue(in)) {
      penColor = color(#000000);
    } 

    return this;
  }

  InputOutput blue(int in) {
    if (isTrue(in)) {
      penColor = color(#66CCFF);
    } 

    return this;
  }

  InputOutput green(int in) {
    if (isTrue(in)) {
      penColor = color(0, 255, 0);
    } 

    return this;
  }
  InputOutput penDown(int in) {
    if (isTrue(in)) {
      isPenDown = true;
    } else {
      isPenDown = false;
    }

    addCommand("penDown");
    return this;
  }

  InputOutput penUp(int in) {
    if (isTrue(in)) {
      isPenDown = false;
    } else {
      isPenDown = true;
    }
    return this;
  }

  InputOutput bigPen(int in) {
    if (isTrue(in)) {
      penSize = 6;
    } else {
      penSize = 2;
    }

    return this;
  }


  // ###################### Movement ######################


  //InputOutput go(int pxMove, int pyMove) { XXX
  //  float prevX = getCX(pX);
  //  float prevY = getCX(pY);

  //  pX = pX + pxMove;
  //  pY = pY + pyMove;

  //  float newX = getCX(pX);
  //  float newY = getCY(pY);

  //  if (isPenDown) {
  //    c.strokeWeight(penSize + 4);
  //    c.strokeWeight(penSize);
  //    c.stroke(penColor);
  //    c.strokeJoin(ROUND);    
  //    c.strokeCap(ROUND);
  //    c.line(prevX, prevY, newX, newY);
  //  }

  //  return this;
  //}


  //InputOutput turnRight(int in) {
  //  if (isTrue(in)) {
  //    head = head + 90;
  //  }

  //  return this;
  //}

  //InputOutput turnLeft(int in) {
  //  if (isTrue(in)) {
  //    head = head - 90;
  //  }

  //  return this;
  //}

  InputOutput right(int in) {
    if (isTrue(in)) {
      //head = 0;
      direction = 0;
      go(1);
    }

    addCommand("右");
    return this;
  }

  InputOutput left(int in) {
    if (isTrue(in)) {
      //head = PI;
      direction = 4;
      go(1);
    }

    addCommand("左");
    return this;
  }

  InputOutput up(int in) {
    if (isTrue(in)) {
      //head = PI/2*3;
      direction = 6;
      go(1);
    }
    addCommand("上");
    return this;
  }

  InputOutput down(int in) {
    if (isTrue(in)) {
      //head = PI/2;
      direction = 2;
      go(1);
    }

    addCommand("下");
    return this;
  }

  InputOutput upRight(int in) {
    if (isTrue(in)) {
      direction = 7;
      go(1);
    }

    addCommand("下");
    return this;
  }
  InputOutput upLeft(int in) {
    if (isTrue(in)) {
      direction = 5;
      go(1);
    }

    addCommand("下");
    return this;
  }
  InputOutput downRight(int in) {
    if (isTrue(in)) {
      direction = 1;
      go(1);
    }

    addCommand("下");
    return this;
  }
  InputOutput downLeft(int in) {
    if (isTrue(in)) {
      direction = 3;
      go(1);
    }

    addCommand("下");
    return this;
  }
  
  
  
  
    InputOutput go(int in) {
    if (isTrue(in)) {
      float prevX = x;
      float prevY = y;



      float stepX = display.canvasStepWidth;
      float stepY = display.canvasStepHeight;
      //x = x + stepSize * cos(radians(head));
      //y = y + stepSize * sin(radians(head));

      int edgeType = checkEdge(x, y);
      if (edgeType < 0) {
        if (direction == 0) {
          x = x + stepX;
        }
        if (direction == 1) {
          x = x + stepX;
          y = y + stepY;
        }
        if (direction == 2) {
          y = y + stepY;
        }
        if (direction == 3) {
          x = x - stepX;
          y = y + stepY;
        }
        if (direction == 4) {
          x = x - stepX;
        }
        if (direction == 5) {
          x = x - stepX;
          y = y - stepY;
        }
        if (direction == 6) {
          y = y - stepY;
        }
        if (direction == 7) {
          x = x + stepX;
          y = y - stepY;
        }
      } else {
       
      }



      if (isPenDown) {
        c.strokeWeight(penSize + 4);
        //float r = red(penColor) - 100;
        //float g = green(penColor) - 100;
        //float b = blue(penColor) - 100;
        //stroke(r, g, b, 50);
        //stroke(10, 50);
        //line(pX, pY, x, y);

        //beginShape();
        //vertex(pX, pY);
        //vertex(x, y);
        //endShape();

        c.strokeWeight(penSize);
        c.stroke(penColor);
        c.strokeJoin(ROUND);    
        c.strokeCap(ROUND);
        //c.strokeCap(PROJECT);
        c.line(prevX, prevY, x, y);


        //c.beginShape();
        //c.vertex(prevX, prevY);
        //c.vertex(x, y);
        //c.endShape();
      }
    } 
    return this;
  }
  
  int checkEdge(float x, float y) {
    return -1;
  }
}