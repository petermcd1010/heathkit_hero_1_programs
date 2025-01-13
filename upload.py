# Heathkit Hero-1 software upload utility.

import serial
import sys
import traceback
from argparse import ArgumentParser
from time import sleep

parser = ArgumentParser()
parser.add_argument('-d', '--dev', dest='device', default='/dev/tty.usbserial-AB0M82BA', help='serial device to open')
parser.add_argument('-f', '--file', dest='file', help='S19 file to upload')

args = parser.parse_args()

print()
print('Heathkit Hero-1 Upload Utility.')
print();

print('Boot Hero-1 robot and type 3A on keypad to enter serial download mode.')
input('Press <enter> when ready')

of = serial.Serial(args.device, 9600, timeout=1, parity=serial.PARITY_EVEN, bytesize=7)

with open(args.file) as f:
  for line in f:
    print('Sending:', line)
    of.write(line.encode('ascii'))
    sleep(0.05)  # Sleep 50ms.

of.close()
print('Done')
