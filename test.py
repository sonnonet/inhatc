#!/sur/bin/python3
import pyfirmata as pf
import time

board = pf.Arduino('/dev/ttyACM0')
pin9 = board.get_pin('d:9:o')
pin9.write(1)
time.sleep(3)
pin9.write(0)
time.sleep(0.05)
