# Inline Assembly: rdtsc

This demo calls the `rdtsc` (Read Time-Stamp Counter) assembly instruction directly from C source code using GCC inline assembly syntax.
`rdtsc` returns the 64-bit CPU cycle counter split across `edx` (high 32 bits) and `eax` (low 32 bits).

## Contents

* `main.c`: C source that calls `rdtsc` via inline assembly and prints the TSC value
* `Makefile`: Builds the `rdtsc` binary
* `README.md`: This file

## Build

```console
make
```

This creates the `rdtsc` binary.

## Run

```console
./rdtsc
```

Example output (the value depends on when the binary is run):

```text
TSC value: 511044251076362
```

## Understand

`rdtsc` places the high 32 bits of the counter in `edx` and the low 32 bits in `eax`.
The inline assembly reads both and combines them into a 64-bit C variable:

```c
uint32_t lo, hi;

__asm__ volatile (
    "rdtsc"
    : "=a"(lo), "=d"(hi)
);

uint64_t tsc = ((uint64_t)hi << 32) | lo;
```

* `"=a"(lo)` — output constraint: write `eax` into `lo`.
* `"=d"(hi)` — output constraint: write `edx` into `hi`.

The TSC increments at a fixed rate (the nominal CPU frequency on modern processors) and can be used to measure elapsed time between two readings.
See demo `16-inline-measure` for a measurement example.
