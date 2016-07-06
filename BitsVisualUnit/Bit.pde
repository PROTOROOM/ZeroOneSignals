class Bit {
  float x, y, w;
  color onColor, offColor;
  
  Bit(float px, float py, float pw) {
    x = px;
    y = py;
    w = pw;
    onColor = color(200);
    offColor = color(20);
  }
  
  void setOnColor(color c) {
    onColor = c;
  }
  
  void setOffColor(color c) {
    offColor = c;
  }
  
  void on() {
    drawShape(onColor);
  }
  
  void off() {
    drawShape(offColor);
  }
  
  void drawShape(color c) {
    noStroke();
    fill(c);
    rect(x, y, w, w);
  }
}