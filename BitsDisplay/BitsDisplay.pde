/*
  BitsDisplay
 by PROTOROOM, SeungBum Kim <picxenk@gmail.com>
 */

import hypermedia.net.*;


// ########## Configurations ########## 
int port = 6000;
int hubPort = 8888;
String[] hubs = {
  "192.168.0.171", 
  "192.168.0.172", 
  "192.168.0.173", 
  "192.168.0.174", 
  "192.168.0.175", 
  "192.168.0.176", 
  "192.168.0.177", 
  "192.168.0.178", 
};


// ########## Variables ##########
color bgColor;
color b1Color, b2Color;

int c=0;

ModeScreen blank, testScreen, basicBitsScreen;
ModeScreen modeColorFall;
HubNetwork hubNetwork;
UDP udp;

int TEST = -1;
int M0 = 0;
int M1 = 1;
int screenMode = M1;


void setup() {
  size(640, 720, P2D);

  background(0);
  b1Color = color(50);
  b2Color = color(200);

  udp = new UDP(this, port);
  hubNetwork = new HubNetwork(udp);
  hubNetwork.setHubs(hubs);
  hubNetwork.setPort(hubPort);

  setupScreens();
}

void setupScreens() {
  blank = new ModeScreen(width, height);
  testScreen = new TestModeScreen(width, height);
  basicBitsScreen = new BasicBitsScreen(width, height);
  basicBitsScreen.setHubNetwork(hubNetwork);
  
  modeColorFall = new ColorFall(width, height);
  modeColorFall.setHubNetwork(hubNetwork);
}


void draw() {
  if (screenMode == TEST) {
    testScreen.show();
  }

  if (screenMode == M0) {
    basicBitsScreen.show();
  }
  
  if (screenMode == M1) {
    modeColorFall.show();
  }
}


void keyReleased() {
  // toggle simulation or real mode for hubs 1 ~ 8
  if (int('1') <= key && key <= int('9')) {
    int hubID = int(key) - int('0');
    hubNetwork.toggleSimulation(hubID);
  }
}


/**
  handle UDP data
**/
void receive(byte[] data) {
  hubNetwork.receive(data);
}