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

// external libraries
HubNetwork hubNet, h;
UDP udp;
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

  // setup font.
  font = createFont("chifont.ttf", 20);
  textFont(font);

  // setup InputOutput Display


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



  //if (h.dataChanged(1))
  //  green.penDown(h.bits[1][0]).turnRight(h.bits[1][1]).go(h.bits[1][2]).turnLeft(h.bits[1][3]).play(h.bits[1][3]);

  //if (h.dataChanged(2))
  //  blue.penDown(h.bits[2][0]).turnRight(h.bits[2][1]).go(h.bits[2][2]).turnLeft(h.bits[2][3]);


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