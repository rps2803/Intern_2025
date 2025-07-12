/*
//Code by GVV Sharma
//April 29, 2022
//https://www.gnu.org/licenses/gpl-3.0.en.html
//
//Seven segment diplay OTA
//
//----------------------Skeleton Code--------------------//
#include <WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>

//    Can be client or even host   //
#ifndef STASSID
#define STASSID "GalaxyM14"  // Replace with your network credentials
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
void sevenseg(int a,int b,int c,int d,int e,int f,int g);

void setup(){
  OTAsetup();

  //-------------------//
  // Custom setup code //
  //-------------------//
    pinMode(12, OUTPUT);  
    pinMode(13, OUTPUT);
    pinMode(14, OUTPUT);
    pinMode(15, OUTPUT);
    pinMode(16, OUTPUT);
    pinMode(17, OUTPUT);
    pinMode(18, OUTPUT);            

}

void loop() {
  OTAloop();
  delay(10);  // If no custom loop code ensure to have a delay in loop
  //-------------------//
  // Custom loop code  //
  //-------------------//
  //
//  digitalWrite(12, 0); 
//  digitalWrite(13, 1); 
//  digitalWrite(14, 0); 
//  digitalWrite(15, 0); 
//  digitalWrite(16, 0); 
//  digitalWrite(17, 0);     
//  digitalWrite(18, 0); 
sevenseg(1,0,0,1,1,1,1);  
}



//Function to drive the display
void sevenseg(int a,int b,int c,int d,int e,int f,int g)
{
  digitalWrite(12, a); 
  digitalWrite(13, b); 
  digitalWrite(14, c); 
  digitalWrite(15, d); 
  digitalWrite(16, e); 
  digitalWrite(17, f);     
  digitalWrite(18, g); 
}
*/


//ASSIGNMENT
#include <WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>

//    Can be client or even host   //
#ifndef STASSID
#define STASSID "GalaxyM14"  // Replace with your network credentials
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
  pinMode(12 , OUTPUT);
  pinMode(13 , OUTPUT);
  pinMode (14, OUTPUT);
  
}
bool q1 =false,  q2 = false;
void loop() {
  OTAloop();
  delay(10);  // If no custom loop code ensure to have a delay in loop

  
  digitalWrite(14, HIGH);

  
  bool j1 = q1 || q2;
  bool k1 = !q1 || !q2;
  bool j2 = !q1 || q2;
  bool k2 = q1 || !q2;
  

  bool q1n = (j1&!q1)||(!k1&q1);
  bool q2n = (j2&!q2) || (!k2&q2);
  q1 = q1n;
  q2 = q2n;
  delay(500);

  digitalWrite(12, q1);
  digitalWrite(13, q2);

  digitalWrite(14, LOW);
  delay(500);
  }
