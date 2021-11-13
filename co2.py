#!/usr/bin/python3

import sys, serial, time

device = serial.Serial('/dev/ttyAMA0', 38400, timeout=5)

while(True):
    try:
        rcvBuf = bytearray()
        device.reset_input_buffer()
        rcvBuf = device.read_until(size=12)
        rcvBuf = rcvBuf.decode()

        temp = rcvBuf.find('p')
#        print(temp)
        a = rcvBuf[2:temp]
        b = int(a)
        print (str(b)+"ppm")
    except Exception as e:
        print("Exception read" + str(e))

    time.sleep(5)
