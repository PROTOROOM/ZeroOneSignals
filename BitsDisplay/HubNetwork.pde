class HubNetwork {
  int[][] bits = {
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
  };
  int modeBitData, oldModeBitData;
  int[] blank8Bits = {0, 0, 0, 0, 0, 0, 0, 0};
  int[] hubData = {0, 0, 0, 0, 0, 0, 0, 0};

  UDP udp;
  WebsocketServer ws;
  String[] hubs;
  int port;


  HubNetwork(UDP aUDP) {
    udp = aUDP;
    udp.listen(true);
  }

  void setHubs(String[] aHubs) {
    hubs = aHubs;
  }

  void setPort(int aPort) {
    port = aPort;
  }

  void setModeHubServer(WebsocketServer aServer) {
    ws = aServer;
  }


  void receive(byte[] data) {
    if (data.length > 1) {
      //bits[data[0]-1] = blank8Bits;
      if (data[0] == 9) {
        modeBitData = data[1];
        sendDataToModeDisplay(modeBitData);
      } else {
        bits[data[0]-1] = toBits(data[1]);
        //hubData[data[0]-1] = data[1];
        hubData[data[0]-1] = toNum(bits[data[0]-1]);
      }
    }
  }

  void sendDataToModeDisplay(int data) {
    if (oldModeBitData != data) {
      //println("ws :" + str(data));

      try {
        ws.sendMessage(str(data));
      } 
      catch (Exception e) {
      }
      oldModeBitData = data;
    }
  }

  int[] toBits(byte b) {
    int[] bits = new int[8];
    for (int i=0; i<8; i++) {
      bits[7-i] = (b >> i) & 1;
    }

    return bits;
  }
  
  int toNum(int[] bits) {
    int result=0;
    for (int i=0; i<8; i++) {
      result = result + int(pow(2, i))*bits[i];
    }
    return result;
  }


  void printBits(int[] bits) {
    for (int i=0; i<bits.length; i++) {
      print(bits[i]);
    }
    println();
  }


  void toggleSimulation(int aHubID) {
    udp.send("tgsm", hubs[aHubID-1], port);
  }
}