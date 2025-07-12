#include <Arduino.h>

const int D =2;
const int C = 3;
const int B =4;
const int A = 5;
int cstate = 9;

void setup() {
    pinMode(D, OUTPUT); // A (LSB)
    pinMode(C, OUTPUT); // B
    pinMode(B, OUTPUT); // C
    pinMode(A, OUTPUT); // D (MSB)

}

void loop() {

   int z = cstate/8;
   int y = (cstate/4)%2;
   int x = (cstate/2)%2;
   int w = cstate%2;

   int a = !w;
   int b = (x&&w)||(y&&!x&&!w);
   int c = (x&&y)||(y&&w)||(z&&!x&&!w);
   int d = (!z&&!y&&!x&&!w)||(x&&z);
 
   // Output bits to 7447                          
   digitalWrite(D, d);  // A = LSB
   digitalWrite(C, c);
   digitalWrite(B, b);
   digitalWrite(A, a);  // D = MSB

   delay(1000); // 1 second delay
   cstate--;
   if (cstate<0){
   cstate = 9;
}
}
