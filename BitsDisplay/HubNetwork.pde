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
  int bitOnTime, bitOffTime;
  int currentMode;
  //int modeDecisionCount, modeBitCount;
  //int m0, m1, m2;
  int[] blank8Bits = {0, 0, 0, 0, 0, 0, 0, 0};
  int[] hubData = {0, 0, 0, 0, 0, 0, 0, 0};

  UDP udp;
  WebsocketServer ws;
  String[] hubs;
  int port;


  HubNetwork(UDP aUDP) {
    udp = aUDP;
    udp.listen(true);

    bitOnTime = 0;
    bitOffTime = 0;
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

      if (oldModeBitData < data) {
        bitOnTime = millis();
      } else {
        bitOffTime = millis();
      }
      try {
        ws.sendMessage(str(data));
      } 
      catch (Exception e) {
      }
      oldModeBitData = data;
    } else {
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


  int getCurrentMode() {
    //print(currentMode);
    //print(" ");
    //print(bitOnTime);
    //print(" ");
    //println(bitOffTime);


    int gapOnOff = abs(bitOffTime - bitOnTime);
    if ((millis() - bitOffTime) > max(1000*2, gapOnOff)) {
      currentMode = 0;
    } 

    if (oldModeBitData != 0) {
      currentMode = oldModeBitData;
    }

    return currentMode;
  }


  // XXX old implementation. not so good.. 
  //int getCurrentModeXXX() {
  //  int currentMode = -1;
  //  modeDecisionCount = 200;

  //  if (modeBitData == 1) {
  //    //m0 = max(50, m0 - 20);
  //    m1 = min(modeDecisionCount, m1 + 2);
  //  }
  //  if (modeBitData == 2) {
  //    //m0 = max(50, m0 - 20);
  //    m2 = min(modeDecisionCount, m2 + 2);
  //  }
  //  if (modeBitData == 0) {
  //    m0 = min(modeDecisionCount, m0 + 2);
  //  }

  //  m0 = max(0, m0 - 1);
  //  m1 = max(0, m1 - 1);
  //  m2 = max(0, m2 - 1);

  //  print(m0);
  //  print("-");
  //  print(m1);
  //  print("-");
  //  println(m2);

  //  if (m1 > m2) {
  //    currentMode = 1;
  //  } else if (m2 > m1) {
  //    currentMode = 2;
  //  } else {
  //    currentMode = 0;
  //  }

  //  return currentMode;
  //}
}