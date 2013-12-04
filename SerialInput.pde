/**
 * Serial Duplex 
 * by Tom Igoe. 
 * 
 * Sends a byte out the serial port when you type a key
 * listens for bytes received, and displays their value. 
 * This is just a quick application for testing serial data
 * in both directions. 
 */


import processing.serial.*;

Serial myPort;      // The serial port
int whichKey = -1;  // Variable to hold keystoke values
int inByte = -1;    // Incoming serial data
String sValues;
String vValues[];
int a1Values[];
String a2Values[];
int threshold = 400;
String myString;

int perStrand = 16;

int topRails = 5;
int bottomRails = 8;

int a1[];
int a2[];
int a3[];

int a[];//corrected
int b[];//corrected
int c[];//corrected
int d[];
int e[];
int f[];
int g[];

void setup() {
  size(1440, 900, P3D);
  // create a font with the third font available to the system:
  PFont myFont = createFont(PFont.list()[2], 14);
  textFont(myFont);

  // List all the available serial ports:
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // In Windows, this usually opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');

  int amount = 51;
  vValues = new String[amount];
  a1Values = new int[amount];

  a1 = new int[perStrand];
  a2 = new int[perStrand];
  a3 = new int[perStrand];
  a = new int[bottomRails];
  b = new int[bottomRails];
  c = new int[topRails];
  d = new int[topRails];
  e = new int[topRails];
  f = new int[topRails];
  g = new int[topRails];

  // Use a for() loop to quickly iterate
  // through all values in an array.
  for (int i=0; i < amount; i++) {         
    vValues[i] = "0";
    a1Values[i] = 0;
  }

  for (int i=0; i < perStrand; i++) { 
    a1[i] = 0;
    a2[i] = 0;
    a3[i] = 0;
  }

  for (int i = 0; i < bottomRails;i++) {
    a[i] = 0;
    b[i] = 0;
  }

  for (int i = 0; i < topRails;i++) {
    c[i] = 0;
    d[i] = 0;
    e[i] = 0;
    f[i] = 0;
    g[i] = 0;
  }
}




void draw() {

  rerouteWires();
  background(0);
  // text("Last Received: " + inByte, 10, 130);
  // text("Whole String: " + vValues, 10, 100);
  //if(vValues.length > 0){
  // println(vValues.length);
  // }

  /*
//old
   for (int i = 0;i<perStrand;i++) {
   
   //Handrail A  
   fill(255, 200);
   rect(i*55, 25, 50, a1[i]);
   
   fill(255);
   text(a1[i], i*55, 10);
   
   //Handrail B
   fill(255, 200);
   rect(i*55, 325, 50, a2[i]);
   
   fill(255);
   text(a2[i], i*55, 310);
   
   //Handrail C
   fill(255, 200);
   rect(i*55, 525, 50, a3[i]);
   
   fill(255);
   text(a3[i], i*55, 510);
   }
   */

  //--------------------------------
  //Rail Variables:
  float rectWidth = width/8;
  int rectHeight = height/6;
  int rectDistFromBottom = height-rectHeight;

pushMatrix();
translate(0, 0, 0);
  //Rail A sensor
  for (int i = 0;i<bottomRails;i++) {

    float valueMapped = map(a[i], 0, 1000, 0, 255);
    fill(255, 0, 0, valueMapped);
    stroke(255);
    rect(i*rectWidth, rectDistFromBottom, rectWidth-4, valueMapped);

    fill(255);
    text(" Sensor: " + i + " value: " + a[i], i*rectWidth, rectDistFromBottom+12);
  }


  //Rail B sensor
  rectDistFromBottom -= rectHeight;
  for (int i = 0;i<bottomRails;i++) {

    float valueMapped = map(b[i], 0, 1000, 0, 255);
    fill(255, 0, 0, valueMapped);
    stroke(255);
    rect(i*rectWidth, rectDistFromBottom, rectWidth-4, valueMapped);

    fill(255);
    text(" Sensor: " + i + " value: " + b[i], i*rectWidth, rectDistFromBottom+12);
  }

  //Rail C sensor
  rectDistFromBottom -= rectHeight;
  for (int i = 0;i<topRails;i++) {

    float valueMapped = map(c[i], 0, 1000, 0, 255);
    fill(255, 0, 0, valueMapped);
    stroke(255);
    rect(i*rectWidth, rectDistFromBottom, rectWidth-4, valueMapped);

    fill(255);
    text(" Sensor: " + i + " value: " + c[i], i*rectWidth, rectDistFromBottom+12);
  }
  
    //Rail D sensor
  rectDistFromBottom -= rectHeight;
  for (int i = 0;i<topRails;i++) {

    float valueMapped = map(d[i], 0, 1000, 0, 255);
    fill(255, 0, 0, valueMapped);
    stroke(255);
    rect(i*rectWidth, rectDistFromBottom, rectWidth-4, valueMapped);

    fill(255);
    text(" Sensor: " + i + " value: " + d[i], i*rectWidth, rectDistFromBottom+12);
  }
  
    //Rail E sensor
  rectDistFromBottom -= rectHeight;
  for (int i = 0;i<topRails;i++) {

    float valueMapped = map(e[i], 0, 1000, 0, 255);
    fill(255, 0, 0, valueMapped);
    stroke(255);
    rect(i*rectWidth, rectDistFromBottom, rectWidth-4, valueMapped);

    fill(255);
    text(" Sensor: " + i + " value: " + e[i], i*rectWidth, rectDistFromBottom+12);
  }
  
    //Rail F sensor
  rectDistFromBottom -= rectHeight;
  for (int i = 0;i<topRails;i++) {

    float valueMapped = map(f[i], 0, 1000, 0, 255);
    fill(255, 0, 0, valueMapped);
    stroke(255);
    rect(i*rectWidth, rectDistFromBottom, rectWidth-4, valueMapped);

    fill(255);
    text(" Sensor: " + i + " value: " + f[i], i*rectWidth, rectDistFromBottom+12);
  }
  popMatrix();
}

void rerouteWires() {
  for (int i = 0; i<bottomRails;i++) {
    a[i] = a1[i];
  }
  for (int i = bottomRails; i<bottomRails*2;i++) {
    b[i-bottomRails] = a1[i];
  }
  c[0] = a2[1];
  c[1] = a2[0];
  c[2] = a2[3];
  c[3] = a2[2];
  c[4] = a2[7];

  d[0] = a2[9];
  d[1] = a2[8];
  d[2] = a2[12];
  d[3] = a2[10];
  d[4] = a2[14];

  e[0] = a3[1];
  e[1] = a3[0];
  e[2] = a3[4];
  e[3] = a3[3];
  e[4] = a3[6];

  f[0] = a3[9];
  f[1] = a3[8];
  f[2] = a3[12];
  f[3] = a3[10];
  f[4] = a3[14];
}



void serialEvent(Serial p) { 
  myString = p.readString(); 


  //while (p.available () > 0) {
  //myString = p.readStringUntil('\n');
  if (myString != null) {
    //println(myString);
    String[] tempArray = split(myString, '\t');
    if (tempArray[0].equals("Array 1") && tempArray.length > perStrand) {
      for (int i = 0;i<perStrand;i++) {
        a1[i] = int(tempArray[i+1]);
      }
    }
    if (tempArray[0].equals("Array 2")&& tempArray.length > perStrand) {
      for (int i = 0;i<perStrand;i++) {
        a2[i] = int(tempArray[i+1]);
      }
    }
    if (tempArray[0].equals("Array 3") && tempArray.length > perStrand) {
      for (int i = 0;i<perStrand;i++) {
        a3[i] = int(tempArray[i+1]);
      }
    }
  }
  //}
}
/*
void serialEvent(Serial myPort) {
 inByte = myPort.read();
 if(inByte != '\n'){
 sValues += char(inByte);
 }else{
 //println(vValues);
 vValues = split(sValues, '\t');
 sValues = "";
 }
 }
 */
