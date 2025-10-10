#include <Servo.h>
#include "DHT.h"

#define DHTPIN 2       // DHT11 sensor on pin 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);
Servo myservo;

int potPin = A0;
int val;

void setup() {
  Serial.begin(115200);
  myservo.attach(9);
  dht.begin();
}

void loop() {
  val = analogRead(potPin);
  int angle = map(val, 0, 1023, 0, 180);
  myservo.write(angle);

  float temp = dht.readTemperature();

  Serial.print("pot,");
  Serial.print(val);
  Serial.print(",servo,");
  Serial.print(angle);
  Serial.print(",temp,");
  Serial.println((int)temp);

  delay(100);
}