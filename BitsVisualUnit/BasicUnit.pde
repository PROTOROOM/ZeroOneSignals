class BitsUnit {
  HubNetwork hubNetwork;
  float x, y, rad;
  float vx, vy;
  float bw;
  int hubID;

  Bit[] bits = new Bit[8];


  BitsUnit(float px, float py, int id) {
    hubNetwork = null;
    x = px;
    y = py;
    vx = random(-5, 5);
    vy = random(-5, 5);
    rad = 0;
    hubID = id;
    
    bw = 10;

    float gap = 1;
    for (int i=0; i<bits.length; i++) {
      bits[i] = new Bit(0+i*(bw+gap), 0, bw);
    }
  }

  void setHubNetwork(HubNetwork hn) {
    hubNetwork = hn;
  }

  void show() {
    if (hubNetwork == null) {
      println("need hub network");
    }
    
    pushMatrix();
    translate(x, y);
    rotate(rad);
    for (int i=0; i<bits.length; i++) {
      if (hubNetwork.bits[hubID-1][i] == 1) {
        bits[i].on();
      } else {
        bits[i].off();
      }
    }
    
    popMatrix();
  }
  
  void moveTo(float px, float py) {
    x = px;
    y = py;
    rad = rad + 0.01;
  }
  
  void move() {
    x = x + vx;
    y = y + vy;
    bounce();
  }
  
  void bounce() {
    if (x <= 0 || width <= x) {
      vx = vx * -1;
      turn();
    }
    if (y <= 0 || height <= y) {
      vy = vy * -1;
      turn();
    }
  }
  
  void turn() {
    rad = rad + random(-1, 1);
  }
}