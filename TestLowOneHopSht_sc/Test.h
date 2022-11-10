#ifndef TEST_H
#define TEST_H

#include "message.h"

enum {
  TEST_PERIOD = 10240LU,
};


enum {
  DFLT_VAL = 0x11,
};

enum {
  TEST_DATA_LENGTH = TOSH_DATA_LENGTH - 6,
};


enum {
  AM_TEST_DATA_MSG = 0xA4,
};


typedef nx_struct test_data_msg {
  nx_am_addr_t srcID;
  nx_uint32_t seqNo;
  nx_uint16_t type;
  nx_uint16_t Temp;
  nx_uint16_t Humi;
  nx_uint16_t Illu;
  nx_uint16_t battery;
  //nx_uint8_t testData[TEST_DATA_LENGTH];
} test_data_msg_t;

#endif // TEST_H
