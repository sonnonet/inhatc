import serial

port = '/dev/ttyACM0'
brate = 9600
cmd = 'temp'

seri = serial.Serial(port, baudrate = brate, timeout = None)
print(seri.name)

seri.writelines(cmd)

a = 1
while a:
    if seri.in_waiting !=0 :
        content = seri.readline()
        print(content)
        a=0

