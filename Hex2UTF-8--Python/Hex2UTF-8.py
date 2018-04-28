#!/bin/env python3
import sys
lens = len(sys.argv)
if(lens != 1):
    for i in range(1, len(sys.argv)):
        print(bytes.fromhex(sys.argv[i][2:]).decode('UTF-8'))
else:
    while True:
        str = input()
        print(bytes.fromhex(str[2:]).decode('UTF-8'))
