# Iterative factorial (NASM x86-64)

This small example implements an iterative factorial routine in NASM targeting x86-64 (System V AMD64). It demonstrates a simple RBP-based frame, calling the function from `main`, and using `scanf`/`printf` to read and write values.

Files:
- `factorial.asm` — the NASM source
- `Makefile` — assemble and link

Build and run
```
make
printf "5\n" | ./factorial
```

Calling convention notes (System V AMD64 / Linux):

- Parameter passing registers (in order):
  1) RDI
  2) RSI
  3) RDX
  4) RCX
  5) R8
  6) R9

- Return value: RAX (and RDX:RAX for 128-bit integer results in some cases)

- Caller-saved (volatile) registers — caller must save these if it needs them preserved across a call:
  - RAX, RCX, RDX, RSI, RDI, R8, R9, R10, R11

- Callee-saved (non-volatile) registers — callee must preserve these (save/restore if it uses them):
  - RBX, RBP, R12, R13, R14, R15

This example uses an RBP frame for clarity. The factorial function saves RBP at entry and restores it before returning. It does not use other callee-saved registers, so none of those are pushed.

Edge cases and notes:
- The code treats inputs <= 1 as factorial == 1.
- No overflow checks are performed — factorial grows very fast and will overflow a 64-bit value for relatively small n.
