# Inline Assembly: cpuid

This demo calls the `cpuid` assembly instruction directly from C source code using GCC inline assembly syntax.
`cpuid` returns processor identification and feature information in registers `eax`, `ebx`, `ecx`, `edx`.

## Contents

* `main.c`: C source that calls `cpuid` via inline assembly and prints the result
* `Makefile`: Builds the `cpuid` binary
* `README.md`: This file

## Build

```console
make
```

This creates the `cpuid` binary.

## Run

```console
./cpuid
```

Example output on an Intel processor:

```text
cpuid leaf 0:
  eax = 0x00000023
  ebx = 0x756e6547
  ecx = 0x6c65746e
  edx = 0x49656e69
Vendor: GenuineIntel
```

## Understand

GCC inline assembly uses the `__asm__` keyword with constraints to describe inputs, outputs, and clobbered registers:

```c
__asm__ volatile (
    "cpuid"
    : "=a"(eax), "=b"(ebx), "=c"(ecx), "=d"(edx)
    : "a"(0)
);
```

* `"=a"(eax)` — output constraint: write `eax` register into C variable `eax`.
* `"a"(0)` — input constraint: load the value `0` into `eax` before the instruction.
* `volatile` — prevent the compiler from reordering or eliminating the instruction.

The leaf number in `eax` selects which information `cpuid` returns.
Leaf 0 returns the maximum supported leaf number in `eax` and the vendor string split across `ebx`, `edx`, `ecx` (in that order).
