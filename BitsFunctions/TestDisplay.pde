/**
 Screen for testing display size, color, etc...
 **/
class TestDisplay {
  float uw, uh;

  TestDisplay() {
    
    uw = width / 12;
    uh = height / 4;
  } 

  void show() {
    background(0, 0, 255);

    noStroke();

    fill(0, 255, 0);
    rect(uw, 0, uw*10, height);

    fill(255, 0, 0);
    rect(uw*2, 0, uw*8, height);

    fill(0);
    rect(uw*3, 0, uw*6, height);

    stroke(255);
    strokeWeight(2);
    line(width/2, 0, width/2, height);

    line(0, uh, width, uh);
    line(0, uh*2, width, uh*2);
    line(0, uh*3, width, uh*3);
  }
}