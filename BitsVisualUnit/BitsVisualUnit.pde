/*
  Bits Visual Unit
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

HubNetwork hubNetwork;
UDP udp;

BitsUnit bits;
SoundUnit sound;

void setup() {
  //fullScreen(P2D, SPAN);
  size(640, 720, P2D);
  //size(1920, 2160, P2D);
  
  //noCursor();

  background(0);
  //noSmooth();

  udp = new UDP(this, port);
  hubNetwork = new HubNetwork(udp);
  hubNetwork.setHubs(hubs);
  hubNetwork.setPort(hubPort);

  bits = new BitsUnit(width/2, height/2, 1);
  bits.setHubNetwork(hubNetwork);
  sound = new SoundUnit();
  sound.setHubNetwork(hubNetwork);
  
}

void draw() {
  fill(0, 10);
  rect(0, 0, width, height);
  bits.show();
  bits.moveTo(mouseX, mouseY);
  
  if (frameCount % 300 == 0) {
    sound.trigger();
  }
}

/**
 handle UDP data
 **/
void receive(byte[] data) {
  hubNetwork.receive(data);
}