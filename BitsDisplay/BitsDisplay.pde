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

int c=0;

ModeScreen blank, testScreen, basicBitsScreen, fullBitsScreen;
ModeScreen modeReady, modeColorFall, modeSoundSprout;

HubNetwork hubNetwork;
UDP udp;
WebsocketServer ws;

int TEST = -1;
int M0 = 0;
int M1 = 1;
int M2 = 2;
int screenMode = M0;
int oldScreenMode;
boolean isRealScreenMode = true;

float startPosX, dWidth;

PShader blur;

void setup() {
  //fullScreen(P3D, SPAN);
  //size(640, 720, P3D);
  size(1920, 2160, P3D);
  colorMode(RGB, 255);

  noCursor();
  bgColor = color(255);
  background(bgColor);

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
  noSmooth();
}

void setupScreens() {
  startPosX = (width/3/12); 
  dWidth = width/3/12*10; 
  //float startPosX = 506 - 270;
  //float dWidth = 270*2; 

  blank = new ModeScreen(width, height);
  testScreen = new TestModeScreen(width, height);
  basicBitsScreen = new BasicBitsScreen(width, height);
  basicBitsScreen.setHubNetwork(hubNetwork);
  fullBitsScreen = new FullBitsScreen(width, height);
  fullBitsScreen.setHubNetwork(hubNetwork);

  modeReady = new NodeToHub(width, height);
  modeReady.setHubNetwork(hubNetwork);
  modeReady.setStartPosition(startPosX, 0);
  modeReady.setDisplayWidth(dWidth);

  modeColorFall = new ColorFall(width, height);
  modeColorFall.setHubNetwork(hubNetwork);
  modeColorFall.setDisplayWidth(dWidth);
  modeColorFall.setStartPosition(startPosX, 0);


  modeSoundSprout = new SoundSprout(width, height);
  modeSoundSprout.setHubNetwork(hubNetwork);
  modeSoundSprout.setDisplayWidth(dWidth);
  modeSoundSprout.setStartPosition(startPosX, 0);
}


void draw() {
  //filter(blur);
  //println(frameRate);


  if (isRealScreenMode) {
    screenMode = hubNetwork.getCurrentMode();
  }

  clearScreenOnceWhenModeSwitched();


  if (screenMode == TEST) {
    testScreen.show();
  }

  if (screenMode == M0) {
    modeReady.show();
    //println(char(hubNetwork.hubData[2] + hubNetwork.hubData[5]));
    //basicBitsScreen.show();
    //fullBitsScreen.show();
    //fullBitsScreen.up();
  }

  if (screenMode == M1) {
    //filter(blur);
    modeColorFall.show();
  }

  if (screenMode == M2) {
    modeSoundSprout.show();
  }

  showModeStatus();
}


void clearScreenOnceWhenModeSwitched() {
  if (screenMode != oldScreenMode) {
    background(bgColor);
    oldScreenMode = screenMode;
    resetModeScreens();
  }
}


void resetModeScreens() {
  if (oldScreenMode != M1) modeColorFall.reset();
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
    background(bgColor);
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


void showModeStatus() {
  if (!isRealScreenMode) {
    fill(100);
    text("Switching Mode by Hand "+screenMode, width/2, 100);
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