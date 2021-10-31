//This sketch is part of the Project EVA, a HackMIT '21 Suubmission form Tanishq Jaiswal and Ishan Goswami







#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

// Set these to run example.
#define FIREBASE_HOST "falldetection-7f362-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "d2OcIrm85iCr81CR2LLXTrwv2VvUau5j9JfXQyVR"
#define WIFI_SSID "Redmi K20 Pro"
#define WIFI_PASSWORD "epiphany"

Adafruit_MPU6050 mpu;


void setup() {
  Serial.begin(9600);
  pinMode(2,OUTPUT);

  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  while (!Serial) {
    delay(10); // will pause Zero, Leonardo, etc until serial console opens
  }

  // Try to initialize!
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }

  mpu.setAccelerometerRange(MPU6050_RANGE_16_G);
  mpu.setGyroRange(MPU6050_RANGE_250_DEG);
  mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
  Serial.println("");
  //delay(100);
}

int n = 0;
bool led = 0;

void loop() {
  // digitalWrite(2,HIGH);
  
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);

  /* Print out the values */

    if(a.acceleration.x>30 || a.acceleration.y>30 || a.acceleration.z>30)
  {
    Serial.println("");
    Serial.print("1");
    // set bool value
  Firebase.setBool("fall!", true);
  // handle error
  if (Firebase.failed()) {
      Serial.print("setting /truth failed:");
      Serial.println(Firebase.error());  
      return;
  }
    digitalWrite(2,HIGH);
    delay(500);
    digitalWrite(2,LOW );
    delay(500);
    
  }
  
  
 
  //Serial.println("");

  delay(10);
  // set value
  
  
  
  
}
