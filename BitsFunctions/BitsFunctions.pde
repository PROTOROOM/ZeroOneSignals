/* Bits Functions
 by SeungBum Kim, PROTOROOM
 */

import hypermedia.net.*;
import websockets.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.pdf.*;


// ########## Table Configurations ########## 
// to setup Scene, first change totalSceneNumber
int totalSceneNumber = 3;
int scene = 1;
// and find SETUP1, SETUP2 in Display Class
// TODO : make scene configuration file

int MODE01TIME = 30;
int MODE02TIME = 60;

color[] tableColors = {color(10, 30), color(30, 30), #333333, #666666, #999999, #aaaaaa, #cccccc, #efefef};
String t = "TABLE_";
String[] tableNames = {t+"A", t+"B", t+"C", t+"D", t+"E", t+"F", t+"G", t+"H"};

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

PFont codeFont, titleFont;
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



// ########## Setup ########## 
void setup() {
  //fullScreen(P2D, SPAN);
  //size(640, 720, P2D);
  size(1920, 2160, P2D);
  noSmooth();
  noCursor();
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
  codeFont = createFont("PixelMplus12-Regular.ttf", 20);
  titleFont = createFont("VarelaRound-Regular", 100);
  //textFont(codeFont);

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

      if (timePassed(MODE01TIME)) {
        scene++;

        if (scene > totalSceneNumber+1) {
          scene = 1;
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
    if (state == 0) {
      display.clean();
      display.setupInputOutputs(scene);
      if (timePassed(2)) state++;
    }
    if (state == 1) {
      display.show(scene);

      if (timePassed(MODE02TIME)) {
        scene++;

        if (scene > totalSceneNumber+1) {
          scene = 1;
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



  showModeStatus();
}

void saveCanvas() {
  String imageName;
  String hourString;
  
  int hour = hour();
  if (hour < 10) {
    hourString = '0' + str(hour);
  } else {
    hourString = str(hour);
  }
   
  imageName = "./img/"+str(year())+str(month())+str(day())+"_"+hourString+str(minute())+str(second())+".png";
  save(imageName);
}

void clearCanvasEdge() {
  noStroke();
  fill(bgColor);
  //fill(200);
  float border = display.startX/4;
  rect(display.startX-4*border, 0, border*4, display.canvasHeight+border*3);
  rect(display.startX+display.dWidth, 0, border*4, display.canvasHeight+border*3);
}

void clearDisplayOnceWhenModeSwitched() {
  if (displayMode != oldDisplayMode) {

    oldDisplayMode = displayMode;
    resetDisplays();

    state = 0;
    scene = 1;
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