import websockets.*;

WebsocketServer ws;
int bit, oldBit;

void setup() {
  size(200, 200);
  ws= new WebsocketServer(this, 8080, "/modehub");
  bit = 0;
}

void draw() {
  background(0);
  if (oldBit != bit) {
    try {
      ws.sendMessage(str(bit));
    } 
    catch (Exception e) {
    }
    oldBit = bit;
  }

  if (frameCount % 10 < 5) {
    bit = 1;
  } else {
    bit = 0;
  }
}

void webSocketServerEvent(String msg) {
  println(msg);
}