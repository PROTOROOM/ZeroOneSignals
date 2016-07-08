import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.sound.sampled.*;

class SoundUnit {
  HubNetwork hubNetwork;
  Minim minim;
  AudioSample wave;
  AudioOutput out;
  float[] sample1, sample2;
  float waveSampleRate;
  int sampleLength;

  SoundUnit() {
    sampleLength = 1024*64;
    sample1 = new float[sampleLength];
    sample2 = new float[sampleLength];
    waveSampleRate = 44100f;

    minim = new Minim(this);
  }

  void setHubNetwork(HubNetwork hn) {
    hubNetwork = hn;
  }

  void makeNewSample() {
    float f;
    for (int i=0; i<sampleLength; i++) {
      f = random(0, 255);
      sample1[i] = f/random(5, 100);
      f = f + random(-30, 30);
      sample2[i] = f/100;
    }

    AudioFormat format = new AudioFormat( waveSampleRate, // sample rate
      16, // sample size in bits
      2, // channels
      true, // signed
      true   // bigEndian
      );

    // finally, create the AudioSample
    wave = minim.createSample( sample1, sample2, // the samples
      format, // the format
      1024     // the output buffer size
      );
  }

  void trigger() {
    makeNewSample();
    wave.trigger();
  }
}