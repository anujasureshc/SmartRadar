import processing.serial.*;  // Imports library for serial communication
import java.awt.event.KeyEvent;  // Imports library for reading the data from the serial port
import java.io.IOException;

Serial myPort;  // Defines object Serial

// Defines variables
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
  size(1200, 700);  // Set the window size
  smooth();
 
  // Set the correct serial port (make sure it matches your ESP8266's serial port)
  myPort = new Serial(this, "COM12", 9600);  // Starts the serial communication
  myPort.bufferUntil('.');  // Reads the data from the Serial Port up to the character '.'
}

void draw() {
  fill(98, 245, 31);

  // Simulate motion blur and slow fade of the moving line
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height - height * 0.065);

  fill(98, 245, 31);  // Green color
  drawRadar();  // Draw the radar
  drawLine();   // Draw the line
  drawObject(); // Draw the object
  drawText();   // Draw text information on the screen
}

void serialEvent(Serial myPort) {
  // Reads the data from the Serial Port up to the character '.' and puts it into the String variable "data"
  data = myPort.readStringUntil('.');  
  if (data != null) {
    data = data.trim();  // Remove any extra spaces or newline characters

    // Find the index of the comma separating angle and distance
    index1 = data.indexOf(",");  

    if (index1 != -1) {
      angle = data.substring(0, index1); // Extract angle data
      distance = data.substring(index1 + 1); // Extract distance data
     
      // Convert string variables into integers
      iAngle = int(angle);
      iDistance = int(distance);
    }
  }
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);  // Move starting coordinates to the center
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);

  // Draw arc lines
  arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
  arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
  arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
  arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);

  // Draw angle lines
  line(-width / 2, 0, width / 2, 0);
  line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
  line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
  line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
  line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
  line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
  line((-width / 2) * cos(radians(30)), 0, width / 2, 0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);  // Move the starting coordinates to the center
  strokeWeight(9);
  stroke(255, 10, 10);  // Red color

  // Convert the distance from centimeters to pixels
  pixsDistance = iDistance * ((height - height * 0.1666) * 0.025);  

  // Limit the range to 40 cm
  if (iDistance < 40) {
    // Draw the object based on the angle and the distance
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)),
         (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);  // Green color
  translate(width / 2, height - height * 0.074);  // Move starting coordinates to the center

  // Draw the line based on the angle
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
 
  // Check if the object is within range
  if (iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }

  fill(0, 0, 0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);  // Background for text

  fill(98, 245, 31);
  textSize(25);
 
  // Draw labels for distances
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);

  // Draw information text
  textSize(40);
  text("SMART RADAR", width - width * 0.875, height - height * 0.0277);
  text("Angle: " + iAngle + " °", width - width * 0.48, height - height * 0.0277);
  text("Distance: ", width - width * 0.26, height - height * 0.0277);
 
  if (iDistance < 40) {
    text("                " + iDistance + " cm", width - width * 0.225, height - height * 0.0277);
  }

  textSize(25);
  fill(98, 245, 60);
  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();

  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();

  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();

  translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();

  translate((width - width * 0.5104) + width / 2 * cos(radians(150)), (height - height * 0.0574) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);

  popMatrix();
}
