# SmartRadar
This project demonstrates a basic radar system using an ESP32 microcontroller and Processing for real-time visualization. The ESP32 collects distance data and transmits it via serial communication, which is then rendered graphically using a radar sweep interface in Processing.

## Features

- Real-time radar sweep visualization
- Serial communication between ESP32 and PC
- Distance-based detection representation
- Easy to adapt for IR, Ultrasonic, or mmWave sensors

##  Components Used

- ESP32 Dev Board
- Sensor (Ultrasonic/IR/Custom distance sensor)
- Processing (Java-based IDE for graphical display)
- USB Cable (For serial data transfer)

## File Structure

- `ESP-RADAR.ino`: Arduino code that reads distance data and sends angle + distance via Serial.
- `PROCESSING.pde`: Processing code that visualizes the radar sweep and plots obstacles.

##  How It Works

1. The ESP32 scans the environment using a sensor (typically a servo + ultrasonic setup).
2. For each angle, it measures the distance and sends the data in the format:  
<angle>,<distance>
3. The Processing sketch reads the serial data and visualizes it with a rotating radar arm.
4. Detected objects are plotted as points on the radar display.

## Setup Instructions

### ESP32
1. Open `ESP-RADAR.ino` in the Arduino IDE.
2. Select your ESP32 board and correct COM port.
3. Upload the sketch.

### Processing
1. Open `PROCESSING.pde` in the Processing IDE.
2. Make sure the serial port index in the code matches your ESP32's port.
3. Run the sketch to view the radar interface.

## 📸 Preview
![image](https://github.com/user-attachments/assets/b8b777a8-39a0-4969-890e-ae54cbabe347)




## 🧠 Future Improvements

- Add noise filtering and smoothing
- Use wireless communication (like ESP-NOW or WiFi)
- Integrate with real mmWave sensors for more accuracy

