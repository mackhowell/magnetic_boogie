//void serialEvent(Serial myPort) { 
//

//    // read the serial buffer:
//    String myString = myPort.readStringUntil('\n');
//    // if you got any bytes other than the linefeed:
//    myString = trim(myString);
//
//    // split the string at the commas
//    // and convert the sections into integers:
//    int sensors[] = int(split(myString, ','));
//
//    // print out the values you got:
//    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
//      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
//    }
//    // add a linefeed after all the sensor values are printed:
//    println();
//    if (sensors.length > 1) {
//      fcolor = (int) map(sensors[0], 0, 1023, 0, width);
////    particleNum = map(sensors[1], 0, 1023, 0, height);
//    }
//    // send a byte to ask for more data:
//    myPort.write("A");
//  }
//}




