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
  
  - LED Simple 2
  ```
  int led = 9;
  int val = 0;

  void setup() {

    Serial.begin(9600);

    Serial.println("input 0~255");

    pinMode(led, OUTPUT);

  }

  void loop() {

    if (Serial.available()) {

      val = Serial.parseInt();

      Serial.println(val);

      analogWrite(led, val);

    }
  
    delay(50);
  }
  ```
  
  
