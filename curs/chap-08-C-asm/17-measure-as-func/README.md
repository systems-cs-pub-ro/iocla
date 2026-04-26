# rdtsc in Separate Assembly File

This demo factors the `rdtsc` measurement into a reusable `read_cycles()` function implemented in a separate assembly file.
It measures the CPU cycles consumed by a `fibonacci()` call and prints the result.

## Contents

* `read_cycles.asm`: Assembly implementation of `read_cycles()` that returns the current CPU cycle count
* `read_cycles.h`: Header file that declares `read_cycles()`
* `main.c`: C `main` that calls `read_cycles()` twice around `fibonacci()` to measure elapsed cycles
* `Makefile`: Builds the `measure` binary from all source files
* `README.md`: This file

## Build

```console
make
```

This creates the `measure` binary.

## Run

```console
./measure
```

Example interaction:

```text
Introduce N: 10
fibonacci(10) took 3596 cycles
```

## Understand

`read_cycles()` in assembly is straightforward — it reads `rdtsc`, combines `edx:eax` into a 64-bit `rax`, and returns:

```nasm
read_cycles:
    rdtsc               ; edx:eax = timestamp counter
    shl rdx, 32         ; shift high 32 bits up
    or rax, rdx         ; combine into 64-bit value
    ret                 ; return in rax
```

In `main.c` the function is called like any other C function:

```c
#include "read_cycles.h"

uint64_t start = read_cycles();
fibonacci(N);
uint64_t end   = read_cycles();

printf("fibonacci(%lu) took %lu cycles\n", N, end - start);
```

Factoring the measurement into a named function makes the intent clear and allows reuse across multiple measurement sites without duplicating the inline assembly.
