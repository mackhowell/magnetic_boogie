// Particles are generated each cycle through draw(),
// A ParticleSystem object manages a variable size (ArrayList) list of particles.

import processing.serial.*;


//int[] fcolor;                                          // Fill color **** replaced by serialColors ****
//int particleNum;                                         // Number of Particlessss
int sensorNum = 0;
Serial myPort;
int serialCount = 0;                                     // A count of how many bytes we receive...
boolean firstContact = false;                            // Whether we've heard from señor arduino
boolean hasSwiped = false;
int howManyNumbers = 0;


ArrayList<ParticleSystem> systems;        
ArrayList<Integer> serialColors;                         // ***NEW ArrayList for all fcolors

void setup() {
  size(3840, 1024, OPENGL);
  background(0);
  systems = new ArrayList<ParticleSystem>();
  serialColors = new ArrayList<Integer>();  
  smooth();
  println(Serial.list());                                // Print list of serial ports...for debugging duh.
  myPort = new Serial(this, Serial.list()[4], 9600);
  //  myPort.bufferUntil('\n');
  frame.setLocation(-3840,0);
}

void draw() {
  fill(0, 20);
  rect(0, 0, 3840, 1024);
  //background(0, 0, 0, 30);
  for (ParticleSystem ps: systems) {
    ps.run(serialColors, serialColors.size());
  }
  if (hasSwiped == true && howManyNumbers == 1) {
    println("I'm in the if statement.");
    cardSwipe(serialColors);                  //*********was: (serialColors, particleNum);
    println("I'm out of cardswipe and turning hasSwiped to false");
    hasSwiped = false;
    println("hasSwiped = " + hasSwiped);
  }
}

void cardSwipe(ArrayList fcolortemp) {       //*********was: (ArrayList fcolortemp, int particleNumtemp)
  println("I'm in Card Swipe");
  PVector origin = new PVector(random(width), random(height));
  systems.add(new ParticleSystem(origin, fcolortemp));    //**********was: (something else)
  println("I've added a particle system " + origin.x + " " + origin.y);
}

//void cardSwipe(int fcolortemp) {       //*********was: (ArrayList fcolortemp, int particleNumtemp)
//  println("I'm in Card Swipe");
//  systems.add(new ParticleSystem(new PVector(random(width), random(height)), fcolortemp));    //**********was: (something else)
//  println("I've added a particle system");
//}

void serialEvent(Serial myPort) { 
  if (firstContact == false) {
    int inByte = myPort.read();
    //println(inByte + " this is the read and this is firstcontact " + firstContact);
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } 
  else {
    // read the serial buffer:


    String myString = myPort.readStringUntil('\n');
    if (myString != null) {

      //println("This is the value of myString: " + myString);
      // if you got any bytes other than the linefeed:
      myString = trim(myString);
      //println("This is the value of myString now after trim: " + myString);

      if (myString.equals(",")) {
        println("I'm getting in here");
        howManyNumbers = 0;
        serialColors = new ArrayList<Integer>();
      } 
      else {
        // split the string at the commas
        // and convert the sections into integers:
        int sensors = int(myString);

        // print out the values you got:
        //for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
        //print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
        //}
        //println("I've made it through the for loop");
        // add a linefeed after all the sensor values are printed:
        //println();
        //if (sensors.length > 1) {
        //println("I'm now in the if statement");
        //fcolor = sensors; ***** replaced by serialColors
        //    for (int i: sensors){

        serialColors.add(sensors);
        if (howManyNumbers == 0); 
        {
          hasSwiped = true;
        }
        howManyNumbers ++;
        //    }

        //println("I've changed fcolors array to sensors array");
        //particleNum = sensors.length;
        //println("This is the number for particlenum: " + particleNum);


        //println("I'm writing an A to the serial");
        // send a byte to ask for more data:
        myPort.write("A");
        //    println("I'm done writing an A");
        //    println("I'm about to turn hasSwiped to true");
      }
    }
  }
}

void keyPressed() {
 
  
  println("i'm in here");
  if (keyCode == DELETE) {
    systems.clear();
    println("ive cleared the particleSystem");
  }
}


//void keyPressed() {
//  println("i'm in here");
//  if (keyCode == DELETE) {
//    systems.clear();
//    println("ive cleared the particleSystem");
//  }
//}




