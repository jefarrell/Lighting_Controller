import oscP5.*;
import netP5.*;
import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;

OscP5 oscP5;  // send messages 
NetAddress myRemoteLocation;  // where we send to
DeviceRegistry registry;


class TestObserver implements Observer {
  public boolean hasStrips = false;
  public void update(Observable registry, Object updatedDevice) {
    println("Registry changed!");
    if (updatedDevice != null) {
      println("Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
}

TestObserver testObserver;

void setup() {
  size(640, 640, P3D);
  oscP5 = new OscP5(this, 5001);
  myRemoteLocation = new NetAddress("127.0.0.1", 5001);
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  prepareExitHandler();
}


void draw() {
}

// TEST MOCKUP IS 288 PIXELS // 
void oscEvent(OscMessage theOscMessage) {
  // Get first value == this is the ID from python
  int incomingVal = theOscMessage.get(0).intValue();
  println("/////////////////");
  println("/////////////////");
  println(" OSC MESSAGE :: " + incomingVal);
  println("/////////////////");
  println("/////////////////");


  if (testObserver.hasStrips) {
    registry.startPushing();
    List<Strip> strips = registry.getStrips();

    for (Strip strip : strips) {
     
      color white = #ffffff;
      int stripLength = strip.getLength();
      
      //// Reset all lights to off & establish brightness ////
      DeviceRegistry.setOverallBrightnessScale(1);
      for (int i=0; i < stripLength; i++) {
        strip.setPixel(#000000, i);
      }

      switch(incomingVal) {
      case 1:  // (" //////~~~~~~///////    Fourth Floor      //////~~~~~~///////"); 
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, incomingVal);
          strip.setPixel(white, theOscMessage.get(i).intValue());
          println("OSC MESSAGE :: " + theOscMessage.get(i).intValue());
        }
        break;

      case 2:  // (" //////~~~~~~///////    Third Floor      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, incomingVal);
          strip.setPixel(white, theOscMessage.get(i).intValue()); 
          println("OSC MESSAGE :: " + theOscMessage.get(i).intValue());
        }
        break;

      case 3:  // (" //////~~~~~~///////    ALL ON      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(white, i);
          delay(5);
        }
        break;

      case 4:  // (" //////~~~~~~///////    ALL OFF      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, i);
        }
        break;

      case 5:  // (" //////~~~~~~///////    Second Floor      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, incomingVal);
          strip.setPixel(white, theOscMessage.get(i).intValue());
          println("OSC MESSAGE :: " + theOscMessage.get(i).intValue());
        }
        break;

      case 6:  // (" //////~~~~~~///////    First Floor      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, incomingVal);
          strip.setPixel(white, theOscMessage.get(i).intValue());
          println("OSC MESSAGE :: " + theOscMessage.get(i).intValue());
        }
        break;

      case 7:  // (" //////~~~~~~///////    Fifth Floor      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, incomingVal);
          strip.setPixel(white, theOscMessage.get(i).intValue());
          println("OSC MESSAGE :: " + theOscMessage.get(i).intValue());
        }
        break;

      case 8:  // (" //////~~~~~~///////    North Wing      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          strip.setPixel(#000000, incomingVal);
          strip.setPixel(white, theOscMessage.get(i).intValue());
          println("OSC MESSAGE :: " + theOscMessage.get(i).intValue());
        }
        break;

      case 9:  // (" //////~~~~~~///////    Half Intense      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          DeviceRegistry.setOverallBrightnessScale(0.4);
          strip.setPixel(white, i);
          // delay(5);  // delay makes cascade between pixels
        }
        break;

      case 10:  // (" //////~~~~~~///////    Dim Intense      //////~~~~~~///////");
        for (int i=0; i < stripLength; i++) {
          DeviceRegistry.setOverallBrightnessScale(0.09);
          strip.setPixel(white, i);
          delay(5);
        }
        break;
      }
    }
  }
}



private void prepareExitHandler () {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run () {
      System.out.println("Shutdown hook running");
      List<Strip> strips = registry.getStrips();
      for (Strip strip : strips) {
        for (int i=0; i<strip.getLength(); i++)
        strip.setPixel(#000000, i);
      }
      for (int i=0; i<100000; i++)
      Thread.yield();
    }
  }
  ));
}