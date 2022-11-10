module TestC
{
  uses {
    interface Boot;
    interface Leds;
    interface Timer<TMilli> as MilliTimer;

    interface SplitControl as RadioControl;
    interface AMSend as RadioSend;

    interface Read<uint16_t> as Temp;
    interface Read<uint16_t> as Humi;
	interface Read<uint16_t> as Illu;

	interface Battery;
  }
}

implementation
{
  message_t testMsgBffr;
  test_data_msg_t *testMsg;

  uint32_t seqNo;
  uint8_t step;


  task void startTimer();
  event void Boot.booted() {
    testMsg = (test_data_msg_t *)call RadioSend.getPayload(
      &testMsgBffr, sizeof(test_data_msg_t));
    testMsg->srcID = TOS_NODE_ID;

    seqNo = 0;

	post startTimer();
  }

  task void startTimer() {
    call MilliTimer.startPeriodic(TEST_PERIOD);
  }

  task void radioOn();
  event void MilliTimer.fired() {
	post radioOn();
  }

  void startDone();
  task void radioOn() {
    if (call RadioControl.start() != SUCCESS) startDone();
  }

  event void RadioControl.startDone(error_t error) {
    startDone();
  }

  task void readTask();
  void startDone() {
    step = 0;
    post readTask();
    call Leds.led0Toggle();
  }

  void sendDone();
  task void sendTask() {
    testMsg->seqNo = seqNo++;
	testMsg->type = 2; //THL type 2

    if (call RadioSend.send(AM_BROADCAST_ADDR, &testMsgBffr,
      sizeof(test_data_msg_t)) != SUCCESS) sendDone();
    call Leds.led2Toggle();
  }

  event void RadioSend.sendDone(message_t* msg, error_t error) {
	sendDone();
  }

  task void radioOff();
  void sendDone() {
    call Leds.led0Off();
    call Leds.led1Off();
    call Leds.led2Off();
	post radioOff();
  }

  void stopDone();
  task void radioOff() {
    if (call RadioControl.stop() != SUCCESS) stopDone();
  }

  event void RadioControl.stopDone(error_t error) {
    stopDone();
  }

  void stopDone() {
  }

  task void readTask() {
    switch(step) {
      case 0:
        call Temp.read(); break;
      case 1:
        call Humi.read(); break;
	  case 2:
	    call Illu.read(); break;
      default:
	    testMsg->battery = call Battery.getVoltage();
        post sendTask();
        break;
    }
    step += 1;
  }

  event void Temp.readDone(error_t error, uint16_t val) {
    //if (error != SUCCESS) call Leds.led0On();
    testMsg->Temp = error == SUCCESS ? val : 0xFFFA;
    post readTask();
  }
  event void Humi.readDone(error_t error, uint16_t val) {
    //if (error != SUCCESS) call Leds.led1On();
    testMsg->Humi = error == SUCCESS ? val : 0xFFFB;
    post readTask();
  }
  event void Illu.readDone(error_t error, uint16_t val){
  	testMsg->Illu = error == SUCCESS ? val : 0xFFFC;
	post readTask();
  }
}
