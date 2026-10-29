import processing.serial.*;

Serial myPort;
String val;

Animation frontW, backW, leftW, rightW, root, grow;
PImage front, bg;

int maxWidth = 700;
int maxHeight = 500;
int analogMax = 4095;

int xpos = (maxWidth / 2) - 150;
int ypos = (maxHeight / 2) - 210;

boolean planted = false;
boolean planting = false;
int plantFrame = 0;

int prev = 0;
boolean grew = false;
boolean growing = false;
int growFrame = 0;

boolean blowing = false;
float blowX, blowY, blowVel, blowAngle;

void setup()
{
  size(700, 500);
  pixelDensity(1);
  bg = loadImage("assets/bg.png");
  
  printArray(Serial.list());
  String portName = Serial.list()[2];
  println(portName);
  myPort = new Serial(this, portName, 9600);
  
  // create animations
  frontW = new Animation("assets/front_walk/front_walk_", 8);
  backW = new Animation("assets/back_walk/back_walk_", 8);
  leftW = new Animation("assets/left_walk/left_walk_", 8);
  rightW = new Animation("assets/right_walk/right_walk_", 8);
  root = new Animation("assets/root/root_", 4);
  grow = new Animation("assets/grow/grow_", 14);
  frameRate(16);
  
  front = loadImage("assets/front_walk/front_walk_1.png");
}


void draw()
{  
  println(myPort.available());
  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
  }
  
  // claude Sonnet 5.5
  if (blowing) {
    blowAway();
    return;
  }
  
  val = trim(val);
  if (val != null) {
    println(val);
    
    // inputs: [buttonState, potVal, xVal, yVal, zVal]
    int[] inputs = int(split(val, ','));
    
    if (inputs.length == 5) {
      int b = inputs[0];
      int p = inputs[1];
      int x = inputs[2];
      int y = inputs[3];
      int z = inputs[4];
      
      // joystick pressed, plant character
      if (z == 0 || planting) {
        if (plantFrame < 4) {
          planting = true;
          background(bg);
          root.display(xpos, ypos);
          plantFrame++;
        }
        else {
          planted = true;
          planting = false;
        }
      }
      
      // exists pot. input difference, grow plant
      else if (planted) {
        if ((p > prev + 50 || p < prev - 50) && !grew) {
          if (growFrame < 14) {
            growing = true;
            background(bg);
            grow.display(xpos, ypos);
            growFrame++;
          }
          else {
            grew = true;
            growing = false;
          }
     
          prev = p;
        }
        
        // button pressed, blow away
        if (grew && b == 0) {
          blowing = true;
          blowX = xpos;
          blowY = ypos;
          blowVel = 0;
          blowAngle = 0;
        }
      }
      
      else if (!planted) {
        // joystick origin: (1840-3, 1872-4)
        // show corresponding animation to direction moved
        // can only move along one axis at a time
        
        background(bg);
        
        if (x < 1835) {
          xpos = (xpos - 10 + maxWidth) % maxWidth;
          leftW.display(xpos, ypos);
        }
        else if (x > 1848) {
          xpos = (xpos + 10) % maxWidth;
          rightW.display(xpos, ypos);
        }
        else if (y < 1867) {
          ypos = (ypos - 10 + maxHeight) % maxHeight;
          backW.display(xpos, ypos);
        }
        else if (y > 1879) {
          ypos = (ypos + 10) % maxHeight;
          frontW.display(xpos, ypos);
        }
        else {
          // no input action, just display default
          image(front, xpos, ypos);
        }
      } 
    }
  }
}

// claude Sonnet 5.5
void blowAway() {
  background(bg);

  blowVel += 0.4;                              // wind picks up gradually
  blowX += blowVel;
  blowY += sin(frameCount * 0.3) * 2 - 0.5;    // flutter plus slight upward drift
  blowAngle += 0.02 + blowVel * 0.005;         // tumbles faster as it speeds up

  PImage img = grow.images[grow.imageCount - 1];
  pushMatrix();
  translate(blowX + img.width / 2, blowY + img.height / 2);
  rotate(blowAngle);
  image(img, -img.width / 2, -img.height / 2); // draw around center so it spins in place
  popMatrix();

  if (blowX > width + img.width) {             // fully off-screen: reset for another round
    blowing = false;
    planted = false;  planting = false;  plantFrame = 0;
    grew = false;     growing = false;   growFrame = 0;
    prev = 0;
    xpos = (maxWidth / 2) - 150;
    ypos = (maxHeight / 2) - 210;
  }
}
