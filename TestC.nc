#define RX_SIZE 6

module TestC
{
  uses interface Boot;
  uses interface Leds;

  uses interface StdControl as SerialControl;
  uses interface UartByte;
  uses interface UartStream;

  uses interface SplitControl as RadioControl;
  uses interface AMSend;
}

implementation
{
  typedef nx_struct beacon {
    nx_uint16_t id;
    nx_uint16_t seqNo;
    nx_uint16_t buf[RX_SIZE];
  } beacon_t;

  message_t sendMsg;
  beacon_t *beacon;

  uint8_t rxBuf[RX_SIZE];

  event void Boot.booted() {
    call Leds.led0Toggle();

    beacon = (beacon_t *)call AMSend.getPayload(&sendMsg, sizeof(beacon_t));
    beacon->id = TOS_NODE_ID;
    beacon->seqNo = 0;
    call RadioControl.start();
  }

  task void receiveTask();
  event void RadioControl.startDone(error_t error) {
    call SerialControl.start();

    post receiveTask();
  }

  event void RadioControl.stopDone(error_t error) {
  }

  task void receiveTask() {
    call Leds.led0Toggle();
    memset(rxBuf, 0x00, RX_SIZE);

    atomic {
      call UartStream.receive(rxBuf, RX_SIZE);
    }
  }

  async event void UartStream.sendDone(uint8_t* buf, uint16_t len,
    error_t error ) {
  }


  async event void UartStream.receivedByte(uint8_t byte) {
  }
  task void sendTask();
  async event void UartStream.receiveDone(uint8_t* buf, uint16_t len,
    error_t error) {
    post sendTask();
  }
  task void sendTask() {
    call Leds.led1Toggle();
    beacon->seqNo++;
    memcpy(&beacon->buf, rxBuf, RX_SIZE);

    call AMSend.send(AM_BROADCAST_ADDR, &sendMsg, sizeof(beacon_t));
  }
  event void AMSend.sendDone(message_t* msg, error_t error) {
    call Leds.led2Toggle();

    post receiveTask();
  }
}

