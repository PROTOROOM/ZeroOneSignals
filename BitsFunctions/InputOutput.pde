class InputOutput {
  float x, y;
  float head;
  boolean isPenDown;
  float penSize;
  color penColor;
  float stepSize;

  InputOutput(float posX, float posY) {
    x = posX;
    y = posY;
    head = 0;
    isPenDown = false;
    penSize = 2;
    penColor = color(0);
    stepSize = 5;
  }


  boolean isTrue(int in) {
    if (in == 1) return true;
    else return false;
  }

  InputOutput penDown(int in) {
    if (isTrue(in)) {
      isPenDown = true;
    } else {
      isPenDown = false;
    }
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



  InputOutput go(int in) {
    if (isTrue(in)) {
      float pX = x;
      float pY = y;
      x = x + stepSize * cos(radians(head));
      y = y + stepSize * sin(radians(head));

      if (isPenDown) {
        strokeWeight(penSize);
        stroke(penColor);
        line(pX, pY, x, y);
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

    return this;
  }

  InputOutput left(int in) {
    if (isTrue(in)) {
      head = 180;
      go(1);
    }

    return this;
  }

  InputOutput up(int in) {
    if (isTrue(in)) {
      head = 270;
      go(1);
    }

    return this;
  }

  InputOutput down(int in) {
    if (isTrue(in)) {
      head = 90;
      go(1);
    }

    return this;
  }




  InputOutput red(int in) {
    if (isTrue(in)) {
      penColor = color(255, 0, 0);
    } 

    return this;
  }

  InputOutput blue(int in) {
    if (isTrue(in)) {
      penColor = color(0, 0, 255);
    } 

    return this;
  }

  InputOutput green(int in) {
    if (isTrue(in)) {
      penColor = color(0, 255, 0);
    } 

    return this;
  }
}