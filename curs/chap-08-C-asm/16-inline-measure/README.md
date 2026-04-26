# Inline Assembly: Measure with rdtsc

This demo uses `rdtsc` called twice from inline assembly to measure the CPU cycles consumed by a `fibonacci()` function call.

## Contents

* `main.c`: C source with inline-assembly `rdtsc` wrapper and measurement of `fibonacci()`
* `Makefile`: Builds the `measure` binary
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
fibonacci(10) took 3266 cycles
```

## Understand

The measurement pattern reads the TSC before and after the function call and subtracts:

```c
static uint64_t read_tsc(void)
{
    uint32_t lo, hi;
    __asm__ volatile ("rdtsc" : "=a"(lo), "=d"(hi));
    return ((uint64_t)hi << 32) | lo;
}

uint64_t start = read_tsc();
fibonacci(N);
uint64_t end   = read_tsc();

printf("fibonacci(%lu) took %lu cycles\n", N, end - start);
```

The cycle count includes the function call overhead and all recursive calls inside `fibonacci`.
For small `N` (e.g. 10) the count is on the order of a few thousand cycles; for `N=30` the recursive version can take millions of cycles due to its exponential time complexity.

See demo `17-measure-as-func` for the same measurement using a reusable assembly `read_cycles()` function.
