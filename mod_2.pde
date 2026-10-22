import processing.serial.*;

Serial myPort;
String val;

Animation frontW, backW, leftW, rightW;

int maxWidth = 700;
int maxHeight = 500;
int analogMax = 4095;

int xpos = maxWidth / 2;
int ypos = maxHeight / 2;

void setup()
{
  size(700, 500);
  background(152, 179, 125);
  
  printArray(Serial.list());
  String portName = Serial.list()[8];
  println(portName);
  myPort = new Serial(this, portName, 9600);
  
  // create animations
  frontW = new Animation("front_walk/front_walk_");
  backW = new Animation("back_walk/back_walk_");
  leftW = new Animation("left_walk/left_walk_");
  rightW = new Animation("right_walk/right_walk_");
  frameRate(16);
}


void draw()
{
  println(myPort.available());
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
  }
  val = trim(val);
  
  if (val != null) {
    println(val);
    
    // inputs: [buttonState, potVal, xVal, yVal, zVal]
    int[] inputs = int(split(val, ','));
    
    if (inputs.length == 5) {
      int b = inputs[0];    // 0 = pressed, 1 = open
      int p = inputs[1];
      int x = inputs[2];
      int y = inputs[3];
      int z = inputs[4];
      
      // joystick origin: (1840-3, 1872-4)
      // show corresponding animation to direction moved
      // can only move along one axis at a time
      
      if (x < 1835) {
        background(152, 179, 125);
        xpos -= 10;
        leftW.display(xpos % maxWidth, ypos);
      }
      else if (x > 1848) {
        background(152, 179, 125);
        xpos += 10;
        rightW.display(xpos % maxWidth, ypos);
      }
      else if (y < 1867) {
        background(152, 179, 125);
        ypos -= 10;
        backW.display(xpos, ypos % maxHeight);
      }
      else if (y > 1879) {
        background(152, 179, 125);
        ypos += 10;
        frontW.display(xpos, ypos % maxHeight);
      }
    }
  }
}
