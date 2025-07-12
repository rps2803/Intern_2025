/*
#include <Arduino.h>

//Declaring all variables as integers
int Z=0,Y=0,X=1,W=1;
int D,C,B,A;

void disp_7447(int D, int C, int B, int A)
{
  digitalWrite(2, A); //LSB
  digitalWrite(3, B); 
  digitalWrite(4, C); 
  digitalWrite(5, D); //MSB

}

void setup() {
    pinMode(2, OUTPUT);  
    pinMode(3, OUTPUT);
    pinMode(4, OUTPUT);
    pinMode(5, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  A=!W;
  B=(W&&!X&&!Z) || (!W&&X);
  C=(W&&X&&!Y) || (!X&&Y) || (!W&&Y);
  D = (W&&X&&Y)||(!W&&Z);
  
disp_7447(D,C,B,A);  
}

*/
