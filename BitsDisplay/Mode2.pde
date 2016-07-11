class SoundSprout extends BasicBitsScreen {
  SoundUnit sound;

  int stateTime;
  int scene;
  
  SoundSprout(float w, float h) {
    super(w, h);
    sound = new SoundUnit();
  }
  
  
  void setHubNetwork(HubNetwork hn) {
    hubNetwork = hn;
    sound.setHubNetwork(hubNetwork);    
  }

  void show() {
    sound.addBitsAndTrigger();
  }
}