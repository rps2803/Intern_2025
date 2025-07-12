/*//Code by GVV Sharma
//April 24, 2022
//https://www.gnu.org/licenses/gpl-3.0.en.html
//
#include <Arduino.h>


void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(2, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {





  digitalWrite(2, HIGH);   // turn the LED on (HIGH is the voltage leve
delay(500);
  digitalWrite(2, LOW);   // turn the LED on (HIGH is the voltage leve

delay(500);

}
*/

/*
//OTA setup
//----------------------Skeleton Code--------------------//
#include <WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>

//    Can be client or even host   //
#ifndef STASSID
#define STASSID "GalaxyM14" // Add your network credentials
#define STAPSK  "prasanna2801"
#endif

const char* ssid = STASSID;
const char* password = STAPSK;


void OTAsetup() {
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  while (WiFi.waitForConnectResult() != WL_CONNECTED) {
    delay(5000);
    ESP.restart();
  
}
  ArduinoOTA.begin();
}

void OTAloop() {
  ArduinoOTA.handle();
}

//-------------------------------------------------------//

void setup(){
  OTAsetup();

  //-------------------//
  // Custom setup code //
  //-------------------//
}

void loop() {
  OTAloop();
  delay(10);  // If no custom loop code ensure to have a delay in loop
  //-------------------//
  // Custom loop code  //
  //-------------------//
}
*/




