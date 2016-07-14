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
//InputOutput red, green, blue;


// ####################### XXX ? 
// Text
String c;


// ########## Setup ########## 
void setup() {
  //fullScreen(P2D, SPAN);
  //size(640, 720, P2D);
  size(1920, 2160, P2D);
  noSmooth();
  background(0);

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

  // setup InputOutput Display  
  display = new Display(width, height, h);
}


void draw() {
  clearCanvasEdge();
  display.show();

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
  fill(0);
  float border = display.startX/4;
  rect(display.startX-border, 0, border+1, display.canvasHeight+border);
  rect(display.startX+display.dWidth-1, 0, border, display.canvasHeight+border);
}


void showText(String text) {
  textSize(20);
  fill(255);
  text(c, 10, 150);
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