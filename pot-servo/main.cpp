#include <Arduino.h>
#include <Servo.h>

Servo myServo;

int potPin = A0;
int potValue = 0;
int angle = 0;

void setup() {
  Serial.begin(115200);
  myServo.attach(6);
}

void loop() {
  potValue = analogRead(potPin);
  angle = map(potValue, 0, 1023, 0, 180);
  myServo.write(angle);


  Serial.print("Potentiometer: ");
  Serial.print(potValue);
  Serial.print(" -> Servo angle: ");
  Serial.println(angle);

  delay(200);
}
