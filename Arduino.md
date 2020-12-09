# 아두이노 

## 아두이노 제어 코드
  
  - LED Simple
  ```
  int led = 8;
  int val = 0;

  void setup() {

  pinMode(led, OUTPUT);

  }


  void loop() {

  digitalWrite(led, HIGH);

  delay(1000);

  digitalWrite(led, LOW);

  delay(1000);

  }
  ```
  
  - DHT11 라즈베리파이 연동 (Command)
  ```
  #include <DHT11.h>

  int pinNum = 7;
  DHT11 dht11(pinNum);

  String input = "";
  String cmd = "temp";
  String response = "";


  void setup() {
    Serial.begin(9600);
    Serial.println("Starting Program....");
  }

  void loop() {
  
    float temp, humi;
    if(Serial.available()){
    input = Serial.readStringUntil('\n');

   }
   

  if(Serial.available() == 0 && input == cmd)
  { 
    dht11.read(humi,temp); 
    Serial.print("Temperature: ");
    Serial.print(temp);
    Serial.print("humidity: ");
    Serial.print(humi);
    Serial.println();
    input = "";
  }

   delay(1000);
  }
  ```
  
  
