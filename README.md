# Any way the wind blows . . .

### Module 2: Interactive Devices
This is an interactive hardware project that uses the ESP32 to read input from a joystick, potentiometer, and button. Sensor data is  sent to Processing, where it can be used to make this little guy move, grow, and blow away.

https://github.com/user-attachments/assets/7a2e6d52-85f3-496c-a2aa-873e249d582c

### Controls:
- Joystick x (left / right), y (up / down): displays character walking animation in corresponding AWSD directions
- Joystick z (press): character plants itself into the ground, locking movement
- Potentiometer: once planted, cranking the potentiometer in either direction will progress the animation frames, and the character will sprout and grow a dandelion upon their head
- Button press: the entire character is uprooted and drifts up, up, and away ~

All assets you see are hand-drawn by me! I designed this character and drew each of the walking, planting, and growing animations in Aseprite.


Requirements
---
**Software:**
- Arduino 2.3.10 (may support lower)
  - TFT_eSPI library by Bodmer
  - [ESP 32 library](https://docs.espressif.com/projects/arduino-esp32/en/latest/installing.html)
- TTGO T-Display driver [(CHXXX)](https://www.wch-ic.com/downloads/CH34XSER_MAC_ZIP.html)
- Processing 4

**Hardware:**
- LILYGO ESP32 TTGO T-Display, with headers soldered
- Breadboard
- Joystick
- Potentiometer
- Button switch
- Assorted wires in various lengths

Wiring
---
The circuit should be wired following these guidelines and the Fritzing diagram below:

- `G` connected to ground on both sides of the ESP32
- `3V` connected to the other power rail that is not ground
- Pushbutton straddling the middle of the breadboard
  - Wired to ground and to Pin `2`
- Side 1 of potentiometer wired to ground, side 2 wired to the 3V power rail (that is not ground)
  - Middle prong connected to Pin `36`
- Joystick:
  - `GND` to ground
  - `+5V` to 3V power rail
  - `VRX` to Pin `39`
  - `VRY` to Pin `32`
  - `SW` to Pin `33`

<img width="447" height="713" alt="fritzing_diagram" src="https://github.com/user-attachments/assets/d5273993-82d4-4348-b2cd-a0fd452b094d" />
<img width="498" height="553" alt="breadboard" src="https://github.com/user-attachments/assets/95f49447-1c12-4626-9cbe-057ea198a68c" />


Setup
---
1) ``git clone`` this repo and open the ``input_setup`` folder in Arduino
2) Compile and upload ``input_setup.ino`` to the ESP32. This will configure the sensor input data for use in Processing.
3) Open and run ``main.pde`` in Processing. This is the primary file for our program, with ``Animation.pde`` as a class file for the Animation object. The program will pop up in a separate window, and you'll also be able to see each of the inputs manipulated in real time on Processing's serial monitor:

    <img width="206" height="170" alt="serial" src="https://github.com/user-attachments/assets/4b6cb842-873d-4d20-9023-bc7e9c3592e0" />

Demo w/ hardware
---

https://github.com/user-attachments/assets/649adfd4-724f-46b1-94fd-c12252767401






