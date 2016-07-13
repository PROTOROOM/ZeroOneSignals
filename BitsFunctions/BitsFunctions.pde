/* Bits Functions
 by SeungBum Kim, PROTOROOM
 */

import hypermedia.net.*;
import websockets.*;

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

HubNetwork hubNet, h;
UDP udp;
PFont font;


InputOutput red, green, blue;


void setup() {
  size(640, 720, P2D);
  udp = new UDP(this, port);
  hubNet = new HubNetwork(udp);
  h = hubNet;
  hubNet.setHubs(hubs);
  hubNet.setPort(hubPort);

  font = createFont("chifont.ttf", 20);
  textFont(font);

  red = new InputOutput(width/2, height/2).red(1);
  green = new InputOutput(width/2, height/2).green(1);
  blue = new InputOutput(width/2, height/2).blue(1);
  noSmooth();
  background(255);
}

void draw() {

  //io.penDown(1).go(1).turnRight(1);

  //if (h.dataChanged(0))
  //red.penDown(h.bits[0][0]).go(h.bits[0][1]).turnRight(h.bits[0][2]).turnRight(h.bits[0][3]);
  if (h.dataChanged(0))
    red.penDown(h.bits[0][0]).up(h.bits[0][1]).right(h.bits[0][2]).left(h.bits[0][3]).down(h.bits[0][4]);

  if (h.dataChanged(1))
    green.penDown(h.bits[1][0]).turnRight(h.bits[1][1]).go(h.bits[1][2]).turnLeft(h.bits[1][3]);

  if (h.dataChanged(2))
    blue.penDown(h.bits[2][0]).turnRight(h.bits[2][1]).go(h.bits[2][2]).turnLeft(h.bits[2][3]);


  noStroke();
  fill(0);
  rect(0, 0, width, 200);
  String codeRed = "赤.penDown("+str(h.bits[0][0])+").上("+str(h.bits[0][1])+").右("+str(h.bits[0][2])+").左("+str(h.bits[0][3])+").下("+str(h.bits[0][4])+")";
  textSize(20);
  fill(255);
  text(codeRed, 10, 100);
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