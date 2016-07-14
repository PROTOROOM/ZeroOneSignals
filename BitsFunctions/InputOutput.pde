class InputOutput {
  float x, y;
  float cX, cY;
  float head;
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


  InputOutput(String aName, float posX, float posY) {
    x = posX;
    y = posY;
    head = 0;
    isPenDown = false;
    penSize = 2;
    penColor = color(0);
    stepSize = 10;

    name = aName;
    commandIndex = 0;
    //hubIndex = id-1;
  }
  
  void show(int in) {
    if (isTrue(in)) {
      cX = display.startX + x;
      cY = display.startY + y;
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
  InputOutput go(int in) {
    if (isTrue(in)) {
      float pX = x;
      float pY = y;
      x = x + stepSize * cos(radians(head));
      y = y + stepSize * sin(radians(head));

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
        c.line(pX, pY, x, y);

        
        //beginShape();
        //vertex(pX, pY);
        //vertex(x, y);
        //endShape();
      }
    } 
    return this;
  }


  InputOutput turnRight(int in) {
    if (isTrue(in)) {
      head = head + 90;
    }

    return this;
  }

  InputOutput turnLeft(int in) {
    if (isTrue(in)) {
      head = head - 90;
    }

    return this;
  }

  InputOutput right(int in) {
    if (isTrue(in)) {
      head = 0;
      go(1);
    }

    addCommand("右");
    return this;
  }

  InputOutput left(int in) {
    if (isTrue(in)) {
      head = 180;
      go(1);
    }

    addCommand("左");
    return this;
  }

  InputOutput up(int in) {
    if (isTrue(in)) {
      head = 270;
      go(1);
    }
    addCommand("上");
    return this;
  }

  InputOutput down(int in) {
    if (isTrue(in)) {
      head = 90;
      go(1);
    }

    addCommand("下");
    return this;
  }
}