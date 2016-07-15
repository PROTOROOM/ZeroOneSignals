/* Bits Functions
 by SeungBum Kim, PROTOROOM
 */

import hypermedia.net.*;
import websockets.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.pdf.*;


// ########## Table Configurations ########## 
color[] tableColors = {#ff3333, #66CCFF, #333333, #666666, #999999, #aaaaaa, #cccccc, #efefef};
String t = "TOP";
String[] tableNames = {t+"1", t+"2", t+"3", t+"4", t+"5", t+"6", t+"7", t+"8"};

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

// InputOutput Displays
Display display;
TestDisplay testDisplay;
HubBitsDisplay hubBitsDisplay;



// ####################### Variables 
// Text
String c;
color bgColor;

int oldDisplayMode = 0;
int displayMode = 0; // 0:begin, 1:drawing, 2:sound
boolean isRealDisplayMode = true;

int state, stateTime;
int scene;


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
  ws = new WebsocketServer(this, wsPort, "/modehub");
  hubNet = new HubNetwork(udp);
  h = hubNet;
  hubNet.setHubs(hubs);
  hubNet.setPort(hubPort);
  hubNet.setModeHubServer(ws);

  // setup font.
  //font = createFont("chifont.ttf", 20);
  font = createFont("PixelMplus12-Regular.ttf", 20);
  textFont(font);

  // setup sound.
  minim = new Minim(this);
  //out = minim.getLineOut();
  OUT = minim.getLineOut();

  // setup Displays  
  testDisplay = new TestDisplay();
  hubBitsDisplay = new HubBitsDisplay(width, height, h);
  display = new Display(width, height, h);

  //
  state = 0;
  stateTime = millis();
  scene = 0;
}


void draw() {
  clearCanvasEdge();
  clearDisplayOnceWhenModeSwitched();
  //print("Mode:"); // XXX
  //print(displayMode);
  //print(" State:");
  //println(state);

  if (isRealDisplayMode) {
    displayMode = hubNet.getCurrentMode();
  }

  if (displayMode == -1) {
    testDisplay.show();
  }

  // ############################################
  if (displayMode == 0) {
    hubBitsDisplay.show();
  }

  // #############################################
  if (displayMode == 1) {
    if (state == 0) {
      display.clean();
      display.setupInputOutputs(scene);
      if (timePassed(2)) state++;
    }
    if (state == 1) {
      display.show(scene);

      if (timePassed(10)) {
        scene++;

        if (scene > 1) {
          scene = 0;
        }

        state++;
      }
    }
    if (state == 2) {
      //display.saveCanvas(); // slow??
      saveCanvas();

      state = 0;
    }
  }

  // #############################################
  if (displayMode == 2) {
    display.show(displayMode);
  }



  showModeStatus();

  noStroke();
  fill(0);
  rect(0, 0, width, 200);
  String codeRed = "赤.penDown("+str(h.bits[0][0])+").上("+str(h.bits[0][1])+").右("+str(h.bits[0][2])+").左("+str(h.bits[0][3])+").下("+str(h.bits[0][4])+")";
  textSize(20);
  fill(255);
  text(codeRed, 10, 100);
}

void saveCanvas() {
  String image_name;
  image_name = "./img/"+str(year())+str(month())+str(day())+"_"+str(hour())+str(minute())+str(second())+".png";
  save(image_name);
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

    oldDisplayMode = displayMode;
    resetDisplays();

    state = 0;
    scene = 0;
  }
}


void resetDisplays() {
  //if (oldDisplayMode != 1) modeColorFall.reset(); XXX
  //if (oldDisplayMode > 0) display.needToClearBackground = true;
}

boolean timePassed(int s) {
  if (millis() - stateTime >= s*1000) {
    stateTime = millis();
    return true;
  } else {
    return false;
  }
}

void showText(String text) {
  textSize(20);
  fill(255);
  text(c, 10, 150);
}


void showModeStatus() {
  if (!isRealDisplayMode) {
    fill(100);
    text("Switching Mode by Hand "+displayMode, width/2, 100);
  }
}


void keyReleased() {
  // toggle simulation or real mode for hubs 1 ~ 8 : [FIXME] not work well
  //if (int('1') <= key && key <= int('9')) {
  //  int hubID = int(key) - int('0');
  //  hubNet.toggleSimulation(hubID);
  //}

  if (!isRealDisplayMode) {
    if (key == 'q') displayMode = 0;
    if (key == 'w') displayMode = 1;
    if (key == 'e') displayMode = 2;
    if (key == 't') displayMode = -1;
  }

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
  background(bgColor);
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