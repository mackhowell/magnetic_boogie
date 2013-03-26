//void SerialEvent(Serial myPort) {
//  // read a byte from the serial port:
//
//  // if this is the first byte received, and it's an A,
//  // clear the serial buffer and note that you've
//  // had first contact from the microcontroller. 
//  // Otherwise, add the incoming byte to the array:
//  if (firstContact == false) {
//    byte inByte = myPort.read();
//    if (inByte == 'A') { 
//      myPort.clear();          // clear the serial port buffer
//      firstContact = true;     // you've had first contact from the microcontroller
//      myPort.write('A');       // ask for more
//    }
//  } 
//  else {
//    //read the serial buffer
//    String myString = myPort.readStringUntil('\n');
//    if (myString != null) {
//      myString = trim(myString);
//      int bytes[] = int(split(myString, ','));
//
//      //print out the values i'm getting from the reader
//      for (vehicleNum; vehicleNum < bytes.length; vehicleNum++) {
//        print('BYTES ' + vehicleNum + ":" + bytes[vehicleNum] + '\t');
//      }
//    }
//    // Add the latest byte from the serial port to array:
//    bytes[serialCount] = inByte;
//    serialCount++;
//
//    // If we have 1 bytes:
//    if (serialCount > 0 ) {
//      fcolor = bytes[0];
//    }
//    // print the values (for debugging purposes only):
//    println(fcolor + '\t' serialCount);
//
//    // Send a capital A to request new sensor readings:
//    myPort.write('A');
//    // Reset serialCount:
//    serialCount = 0;
//  }
//}

