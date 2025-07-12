
#include <Arduino.h>

int count = 0;

void setup() {
  pinMode(2, OUTPUT); // A (LSB)
  pinMode(3, OUTPUT); // B
  pinMode(4, OUTPUT); // C
  pinMode(5, OUTPUT); // D (MSB)
}

void loop() {
  if (count > 9) {
    count = 0;
  }

  // Convert count to individual BCD bits
  int A = count % 2;                     // bit 0
  int B = (count / 2) % 2;               // bit 1
  int C = (count / 4) % 2;               // bit 2
  int D = (count / 8) % 2;               // bit 3

  // Output bits to 7447
  digitalWrite(2, A);  // A = LSB
  digitalWrite(3, B);
  digitalWrite(4, C);
  digitalWrite(5, D);  // D = MSB

  delay(1000); // 1 second delay
  count++;     // Increment counter
}

