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
InputOutput red, green, blue;


// ####################### XXX ? 
// Text
String c;


// ########## Setup ########## 
void setup() {
  size(640, 720, P2D);
  noSmooth();
  background(255);

  // setup Hub Network.
  udp = new UDP(this, port);
  hubNet = new HubNetwork(udp);
  h = hubNet;
  hubNet.setHubs(hubs);
  hubNet.setPort(hubPort);

  // setup font.
  font = createFont("chifont.ttf", 20);
  textFont(font);

  // setup sound.
  minim = new Minim(this);
  //out = minim.getLineOut();
  OUT = minim.getLineOut();

  // setup InputOutput Object.
  red = new InputOutput("赤", width/2, height/2).red(1);
  green = new InputOutput("緑", width/2, height/2).green(1);
  blue = new InputOutput("青", width/2, height/2).blue(1);

  red.setHubConf(h, 1);
  green.setHubConf(h, 2);
  blue.setHubConf(h, 3);

  //red.setSound(out);
}

void draw() {

  //io.penDown(1).go(1).turnRight(1);

  //if (h.dataChanged(0))
  //red.penDown(h.bits[0][0]).go(h.bits[0][1]).turnRight(h.bits[0][2]).turnRight(h.bits[0][3]);
  if (h.dataChanged(0)) {
    //c = red.penDown(h.bits[0][0]).up(h.bits[0][1]).right(h.bits[0][2]).left(h.bits[0][3]).down(h.bits[0][4]).getCodeString();
    red.penDown(h.bits[0][0]).up(h.bits[0][1]).blue(h.bits[0][2]).left(h.bits[0][3]).red(h.bits[0][4]).down(h.bits[0][5]).right(h.bits[0][6]);
    //showText(c);
  }

  if (h.dataChanged(1))
    green.penDown(h.bits[1][0]).turnRight(h.bits[1][1]).go(h.bits[1][2]).turnLeft(h.bits[1][3]).play(h.bits[1][3]);

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