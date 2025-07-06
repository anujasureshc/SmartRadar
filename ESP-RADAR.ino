#include <Servo.h>

// Defines Trig and Echo pins of the Ultrasonic Sensor
const int trigPin = D3;  // GPIO5 (D1 on NodeMCU)
const int echoPin = D2;  // GPIO4 (D2 on NodeMCU)

// Define LED Pin (D7, GPIO13)
const int ledPin = D7;  // GPIO13 (D7 on NodeMCU)

// Variables for the duration and the distance
long duration;
int distance;

Servo myServo;  // Creates a servo object for controlling the servo motor

void setup() {
  pinMode(trigPin, OUTPUT);  // Sets the trigPin as an Output
  pinMode(echoPin, INPUT);   // Sets the echoPin as an Input
  pinMode(ledPin, OUTPUT);   // Sets the LED pin as an Output
  Serial.begin(9600);        // Initializes serial communication at 9600 baud
  myServo.attach(D6);       // Defines on which pin the servo motor is attached (GPIO0, D3 on NodeMCU)
}

void loop() {
  // Rotates the servo motor from 15 to 165 degrees
  for (int i = 15; i <= 165; i++) {  
    myServo.write(i);         // Moves the servo to the desired position
    delay(30);                // Wait for the servo to reach the position
    distance = calculateDistance();  // Calls a function to calculate the distance measured by the Ultrasonic sensor for each degree
   
    Serial.print(i);          // Sends the current degree into the Serial Port
    Serial.print(",");        // Sends a comma separator for processing later
    Serial.print(distance);   // Sends the distance value into the Serial Port
    Serial.print(".");        // Sends a period separator for indexing in Processing

    // Check if the distance is less than 10 cm
    if (distance < 10) {
      digitalWrite(ledPin, HIGH);  // Turn on the LED if the distance is less than 10 cm
    } else {
      digitalWrite(ledPin, LOW);   // Turn off the LED if the distance is greater than or equal to 10 cm
    }
  }

  // Repeats the previous lines from 165 to 15 degrees
  for (int i = 165; i > 15; i--) {  
    myServo.write(i);         // Moves the servo to the desired position
    delay(10);                // Wait for the servo to reach the position
    distance = calculateDistance();  // Calls a function to calculate the distance
   
    Serial.print(i);          // Sends the current degree into the Serial Port
    Serial.print(",");        // Sends a comma separator for processing later
    Serial.print(distance);   // Sends the distance value into the Serial Port
    Serial.print(".");        // Sends a period separator for indexing in Processing

    // Check if the distance is less than 10 cm
    if (distance < 10) {
      digitalWrite(ledPin, HIGH);  // Turn on the LED if the distance is less than 10 cm
    } else {
      digitalWrite(ledPin, LOW);   // Turn off the LED if the distance is greater than or equal to 10 cm
    }
  }
}

// Function for calculating the distance measured by the Ultrasonic sensor
int calculateDistance() {
  digitalWrite(trigPin, LOW);       // Ensure trigPin is low initially
  delayMicroseconds(2);             // Small delay to ensure a clean signal
 
  digitalWrite(trigPin, HIGH);      // Sets the trigPin on HIGH state for 10 microseconds
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);       // Sets trigPin back to LOW
 
  duration = pulseIn(echoPin, HIGH);  // Reads the echoPin, returns the sound wave travel time in microseconds
  distance = duration * 0.034 / 2;   // Calculates the distance in cm (speed of sound is 0.034 cm/µs)
 
  return distance;
}