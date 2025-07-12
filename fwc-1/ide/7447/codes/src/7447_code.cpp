#include <Arduino.h>

void setup() {
	  //put your setup code here, to run once:
	  pinMode(2, OUTPUT);
	  pinMode(3, OUTPUT);
	  pinMode(4, OUTPUT);
	  pinMode(5, OUTPUT);
	  pinMode(6, OUTPUT);
	  pinMode(7, OUTPUT);
	  pinMode(8, OUTPUT);
	  pinMode(9, INPUT);
	  pinMode(10, INPUT);
	  pinMode(11, INPUT);
	  pinMode(12, INPUT);
}

void loop() {
	  // put your main code here, to run repeatedly:
	int D = digitalRead(9);
	int C = digitalRead(10);
	int B = digitalRead(11);
	int A = digitalRead(12);

	int a = (B&&!C&&!D) || (!A&&!B&&!C&&D);
	int b = (B&&!C&&D) || (B&&C&&!D);
	int c = (!B&&C&&!D);
	int d = (A&&D) || (B&&C&&D) || (!B&&!C&&D) || (B&&!C&&!D);
	int e = D || (B&&!C);
	int f = (C&&D) || (!A&&!B&&D) || (!A&&!B&&C);
	int g = (!A&&!B&&!C) || (B&&C&&D);

	digitalWrite(2, a);
	digitalWrite(3, b);
	digitalWrite(4, c);
	digitalWrite(5, d);
	digitalWrite(6, e);
	digitalWrite(7, f);
	digitalWrite(8, g);

}
		      
