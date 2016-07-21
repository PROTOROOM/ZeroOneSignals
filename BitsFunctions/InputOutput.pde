class InputOutput {
  float x, y;
  float cX, cY;
  int pX, pY;

  float head;
  int direction; // 0(right) - 7 clockwise  


  boolean isPenDown;
  float penSize, bigPenSize, defaultPenSize;
  color penColor;
  float stepSize;

  String name, showName;
  int commandIndex;
  boolean commandEnd;
  ArrayList<String> commands;


  // HubNetwork & index
  HubNetwork h;
  int hi;

  Display display;
  PGraphics c;

  //AudioOutput out;
  Oscil wave;


  //InputOutput(String aName, float posX, float posY) { // XXX change to grid postion system.
  InputOutput(Display d, String aName) {
    setDisplay(d);

    //pX = posX;
    //pY = posY;
    head = 0;
    isPenDown = false;
    penSize = 2;
    defaultPenSize = 2;
    bigPenSize = 5;
    penColor = color(0);
    stepSize = 10; // XXX now use canvasStep Width/Height

    name = aName;
    showName = str(name.charAt(name.length()-1));
    commandIndex = 0;
    commandEnd = false;
    commands = new ArrayList<String>();
    //hubIndex = id-1;
  }

  void setStartPosition(int posX, int posY) {
    x = posX*display.canvasStepWidth;
    y = posY*display.canvasStepHeight;
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
    if (isTrue(in) && commandEnd) {
      cX = display.startX + x;
      cY = display.startY + y;
      //float px = getXfromCanvasPosX(pX);
      //float py = getYfromCanvasPosY(pY);


      stroke(250);
      strokeWeight(2);
      fill(penColor);
      ellipse(cX, cY, penSize*4, penSize*4);

      textFont(titleFont);
      textAlign(CENTER, CENTER);
      textSize(penSize*3);

      color textColor = getTextColor(penColor);
      fill(textColor);
      text(showName, cX, cY-penSize/2);
    }
  }

  color getTextColor(color c) {
    color result;
    //if (brightness(c) > 250) {
    //  result = lerpColor(c, color(0), 0.1);
    //} else {
    //  result = lerpColor(c, color(255), 0.7);
    //}

    result = lerpColor(c, color(255), 0.7);
    return result;
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
    if (!commandEnd) {
      commands.add(command);
    }
  }

  void end() {
    commandEnd = true;
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

    addCommand("赤");
    return this;
  }

  InputOutput black(int in) {
    if (isTrue(in)) {
      penColor = color(#000000);
    } 

    addCommand("黒");
    return this;
  }

  InputOutput blue(int in) {
    if (isTrue(in)) {
      penColor = color(#66CCFF);
    } 

    addCommand("青");
    return this;
  }

  InputOutput green(int in) {
    if (isTrue(in)) {
      penColor = color(#66cc99);
    } 

    addCommand("緑");
    return this;
  }

  InputOutput yellow(int in) {
    if (isTrue(in)) {
      penColor = color(#ffcc00);
    } 

    addCommand("黄");
    return this;
  }

  InputOutput penDown(int in) {
    if (isTrue(in)) {
      isPenDown = true;
    } else {
      isPenDown = false;
    }

    addCommand("筆下");
    return this;
  }

  InputOutput penUp(int in) {
    if (isTrue(in)) {
      isPenDown = false;
    } else {
      isPenDown = true;
    }

    addCommand("筆昇");
    return this;
  }

  InputOutput bigPen(int in) {
    if (isTrue(in)) {
      penSize = bigPenSize;
    } else {
      penSize = defaultPenSize;
    }

    addCommand("大筆");
    return this;
  }

  void setBigPen(int aSize) {
    bigPenSize = aSize;
  }

  void setDefaultPen(int aSize) {
    defaultPenSize = aSize;
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

    addCommand("右上");
    return this;
  }
  InputOutput upLeft(int in) {
    if (isTrue(in)) {
      direction = 5;
      go(1);
    }

    addCommand("左上");
    return this;
  }
  InputOutput downRight(int in) {
    if (isTrue(in)) {
      direction = 1;
      go(1);
    }

    addCommand("右下");
    return this;
  }
  InputOutput downLeft(int in) {
    if (isTrue(in)) {
      direction = 3;
      go(1);
    }

    addCommand("左下");
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
        if (edgeType == 4) {
          prevX = display.canvasCol*display.canvasStepWidth;
          x = prevX - stepX;
          if (direction == 3) {
            y = y + stepY;
          }
          if (direction == 4) {
          }
          if (direction == 5) {
            y = y - stepY;
          }
        }

        if (edgeType == 0) {
          prevX = 0;
          x = prevX + stepX;
          if (direction == 1) {
            y = y + stepY;
          }
          if (direction == 7) {
            y = y - stepY;
          }
        }

        if (edgeType == 2) {
          prevY = 0;
          y = prevY + stepY;
          if (direction == 1) {
            x = x + stepX;
          }
          if (direction == 3) {
            x = x - stepX;
          }
        }

        if (edgeType == 6) {
          prevY = display.canvasRow*display.canvasStepHeight;
          y = prevY - stepY;
          if (direction == 5) {
            x = x - stepX;
          }
          if (direction == 7) {
            x = x + stepX;
          }
        }

        // I think they are rare case;
        if (edgeType == 1) {
          y = y - stepY;
          //if (direction == 0) { // ?? 
          //  prevX = 0;
          //  x = prevX + stepX;
          //}
          //if (direction == 1) {
          //  prevX = 0;
          //  x = prevX + stepX;
          //  y = 0 + stepY;
          //}
          //if (direction == 2) { // ??
          //  y = 0 + stepY;
          //}
          //if (direction == 3) {
          //  x = x - stepX;
          //  y = 0 - stepY;
          //}
          //if (direction == 7) {
          //  prevX = 0;
          //  x = prevX + stepX;
          //  y = y - stepY;
          //}
        }

        if (edgeType == 3) {
          y = y - stepY;
        }
        if (edgeType == 5) {
          y = y + stepY;
        }
        if (edgeType == 7) {
          y = y + stepY;
        }
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
    int posX = int(x / display.canvasStepWidth);
    int posY = int(y / display.canvasStepHeight);
    //print(posX);print("-");println(posY);

    if (1 <= posY || posY <= display.canvasRow-1) {
      if (posX >= display.canvasCol) return 0;
      if (posX <= 0) return 4;
    }
    if (1 <= posX || posX <= display.canvasCol-1) {
      if (posY >= display.canvasRow) return 2;
      if (posY <= 0) return 6;
    }
    if (display.canvasCol <= posX && display.canvasRow <= posY) return 1;
    if (posX <= 0 && display.canvasRow <= posY) return 3;
    if (posX <= 0  && posY <= 0) return 5;
    if (display.canvasCol <= posX  && posY <= 0) return 7;

    return -1;
  }
}