/* Bits Functions
 by SeungBum Kim, PROTOROOM
 */

import hypermedia.net.*;
import websockets.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

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

// external libraries
HubNetwork hubNet, h;
UDP udp;
WebsocketServer ws;

PFont font;
Minim minim;
AudioOutput OUT;

// InputOutput
Display display;
TestDisplay testDisplay;
HubBitsDisplay hubBitsDisplay;
//InputOutput red, green, blue;


// ####################### Variables 
// Text
String c;
color bgColor;

int oldDisplayMode = 0;
int displayMode = 0; // 0:begin, 1:drawing, 2:sound
boolean isRealDisplayMode = true;


// ########## Setup ########## 
void setup() {
  //fullScreen(P2D, SPAN);
  //size(640, 720, P2D);
  size(1920, 2160, P2D);
  noSmooth();
  bgColor = color(0);
  background(bgColor);

  // setup Hub Network.
  udp = new UDP(this, port);
  hubNet = new HubNetwork(udp);
  h = hubNet;
  hubNet.setHubs(hubs);
  hubNet.setPort(hubPort);
  hubNet.setModeHubServer(ws);

  // setup font.
  font = createFont("chifont.ttf", 20);
  textFont(font);

  // setup sound.
  minim = new Minim(this);
  //out = minim.getLineOut();
  OUT = minim.getLineOut();

  // setup Displays  
  testDisplay = new TestDisplay();
  hubBitsDisplay = new HubBitsDisplay(width, height, h);
  display = new Display(width, height, h);
}


void draw() {
  clearCanvasEdge();
  if (displayMode == -1) {
    testDisplay.show();
  }

  if (displayMode == 0) {
    hubBitsDisplay.show();
  }

  if (displayMode == 1) {
    display.show();
  }

  //noStroke();
  //fill(0);
  //rect(0, 0, width, 200);
  //String codeRed = "赤.penDown("+str(h.bits[0][0])+").上("+str(h.bits[0][1])+").右("+str(h.bits[0][2])+").左("+str(h.bits[0][3])+").下("+str(h.bits[0][4])+")";
  //textSize(20);
  //fill(255);
  //text(codeRed, 10, 100);
}


void clearCanvasEdge() {
  noStroke();
  fill(bgColor);
  float border = display.startX/4;
  rect(display.startX-border, 0, border, display.canvasHeight+border);
  rect(display.startX+display.dWidth, 0, border, display.canvasHeight+border);
}

void clearDisplayOnceWhenModeSwitched() {
  if (displayMode != oldDisplayMode) {
    background(bgColor);
    oldDisplayMode = displayMode;
    resetDisplays();
  }
}


void resetDisplays() {
  //if (oldDisplayMode != 1) modeColorFall.reset(); XXX
}


void showText(String text) {
  textSize(20);
  fill(255);
  text(c, 10, 150);
}


void keyReleased() {
  // toggle simulation or real mode for hubs 1 ~ 8 : [FIXME] not work well
  //if (int('1') <= key && key <= int('9')) {
  //  int hubID = int(key) - int('0');
  //  hubNet.toggleSimulation(hubID);
  //}

  if (key == 'q') displayMode = 0;
  if (key == 'w') displayMode = 1;
  if (key == 'e') displayMode = 2;
  if (key == 't') displayMode = -1;
  if (key == 'r') {
    background(bgColor);
    toggleRealDisplayMode();
  }
}


void toggleRealDisplayMode() {
  if (isRealDisplayMode) {
    isRealDisplayMode = false;
  } else {
    isRealDisplayMode = true;
  }
}


/**
 handle UDP data
 **/
void receive(byte[] data) {
  hubNet.receive(data);
}


/**
 handle Websocket data
 **/
void webSocketServerEvent(String msg) {
  println(msg);
}