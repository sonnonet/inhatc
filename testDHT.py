import serial

port = '/dev/ttyACM0'
brate = 9600

seri = serial.Serial(port, baudrate = brate, timeout = None)
print(seri.name)

seri.write('b\x0101')

a = 1
while a:
    if seri.in_waiting !=0 :
        content = seri.readline()
        print(content.decode())
        a=0

