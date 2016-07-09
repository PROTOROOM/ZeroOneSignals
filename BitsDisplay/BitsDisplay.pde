/*
  BitsDisplay
 by PROTOROOM, SeungBum Kim <picxenk@gmail.com>
 */

import hypermedia.net.*;
import websockets.*;

// ########## Configurations ########## 
int port = 6000;
int hubPort = 8888;
int wsPort = 8080;
String hubBaseIP = "192.168.1.";
String[] hubs = {
  hubBaseIP+"171", 
  hubBaseIP+"172", 
  hubBaseIP+"173", 
  hubBaseIP+"174", 
  hubBaseIP+"175", 
  hubBaseIP+"176", 
  hubBaseIP+"177", 
  hubBaseIP+"178", 
};


// ########## Variables ##########
color bgColor;
color b1Color, b2Color;

int c=0;

ModeScreen blank, testScreen, basicBitsScreen, fullBitsScreen;
ModeScreen modeColorFall;

HubNetwork hubNetwork;
UDP udp;
WebsocketServer ws;

int TEST = -1;
int M0 = 0;
int M1 = 1;
int screenMode = M1;
int oldScreenMode;
boolean isRealScreenMode = true;

PShader blur;

void setup() {
  //fullScreen(P2D, SPAN);
  size(640, 720, P2D);
  //size(1920, 2160, P2D);

  noCursor();

  background(255);
  b1Color = color(50);
  b2Color = color(200);

  // network setup, HubNetwork handles UDP, Websocket.
  // 'void receive()' method is necessary, check below.
  udp = new UDP(this, port);
  ws = new WebsocketServer(this, wsPort, "/modehub");
  hubNetwork = new HubNetwork(udp);
  hubNetwork.setHubs(hubs);
  hubNetwork.setPort(hubPort);
  hubNetwork.setModeHubServer(ws);

  setupScreens();
  blur = loadShader("blur.glsl");
}

void setupScreens() {
  blank = new ModeScreen(width, height);
  testScreen = new TestModeScreen(width, height);
  basicBitsScreen = new BasicBitsScreen(width, height);
  basicBitsScreen.setHubNetwork(hubNetwork);
  fullBitsScreen = new FullBitsScreen(width, height);
  fullBitsScreen.setHubNetwork(hubNetwork);

  modeColorFall = new ColorFall(width, height);
  modeColorFall.setHubNetwork(hubNetwork);
}


void draw() {
  filter(blur);


  if (isRealScreenMode) {
    screenMode = hubNetwork.getCurrentMode();
  }
  clearScreenOnce();

  if (screenMode == TEST) {
    testScreen.show();
  }

  if (screenMode == M0) {

    basicBitsScreen.show();
    //fullBitsScreen.show();
    //fullBitsScreen.up();
  }

  if (screenMode == M1) {

    //if (frameCount % 3 == 0) {
    modeColorFall.show();
    //}
  }
}

void clearScreenOnce() {
  if (screenMode != oldScreenMode) {
    background(255);
    oldScreenMode = screenMode;
  }
}


void keyReleased() {
  // toggle simulation or real mode for hubs 1 ~ 8
  if (int('1') <= key && key <= int('9')) {
    int hubID = int(key) - int('0');
    hubNetwork.toggleSimulation(hubID);
  }

  if (key == 'q') screenMode = 0;
  if (key == 'w') screenMode = 1;
  if (key == 'e') screenMode = 2;
  if (key == 't') screenMode = TEST;
  if (key == 'r') {
    toggleRealScreenMode();
  }
}

void toggleRealScreenMode() {
  if (isRealScreenMode) {
    isRealScreenMode = false;
  } else {
    isRealScreenMode = true;
  }
}


/**
 handle UDP data
 **/
void receive(byte[] data) {
  hubNetwork.receive(data);
}


/**
 handle Websocket data
 **/
void webSocketServerEvent(String msg) {
  println(msg);
}