// reads button, joystick, and potentiometer inputs
// and routes to serial

#define BUTTON_PIN 2
#define POT_PIN 36
int xyzPins[] = {39, 32, 33}; 

void setup() {
  Serial.begin(9600);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(xyzPins[2], INPUT_PULLUP);
}

void loop() {
  int buttonState = digitalRead(BUTTON_PIN);
  // range: [0, 4095]
  int potVal = analogRead(POT_PIN);      
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);

  Serial.printf("%d,%d,%d,%d,%d", buttonState, potVal, xVal, yVal, zVal);
  Serial.println();
  delay(100);
}
