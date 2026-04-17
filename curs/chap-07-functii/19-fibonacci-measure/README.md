# Measuring Fibonacci: Iterative vs Recursive

This demo measures the CPU cycle count needed to compute Fibonacci using both the iterative and recursive implementations, using the `rdtsc` (Read Time-Stamp Counter) instruction.

The program:

1. Reads `N` from the user
1. Serializes execution with `cpuid`, reads the TSC, calls `fibonacci_iterative(N)`, reads the TSC again, and prints the cycle difference
1. Repeats the measurement for `fibonacci_recursive(N)`

The `cpuid` instruction is used before `rdtsc` to prevent out-of-order execution from skewing the measurement.
For large `N`, the recursive version is significantly slower due to exponential call overhead (unless memoization is used).

## Contents

Directory contents are:

* `fibonacci.asm`: Both iterative and recursive implementations with TSC measurement in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `fibonacci` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `fibonacci` binary executable (ELF).

## Run

To run the binary, use:

```console
./fibonacci
```

Example interaction:

```text
Introduce N: 30
Iterative cycles: 312
Recursive cycles: 4521834
```

The recursive version requires exponentially more cycles than the iterative version.