# Measuring Functions via a Higher-Order measure_function

This demo refactors the measurement logic from `19-fibonacci-measure` into a reusable `measure_function` helper.

`measure_function` takes two arguments:

* `rdi`: a function pointer (the function to measure)
* `rsi`: the argument to pass to that function

It reads the TSC before and after calling the function via `call rbx` (indirect call through a register), and returns the cycle count difference in `rax`.
`main` calls `measure_function(fibonacci_iterative, N)` and `measure_function(fibonacci_recursive, N)` to compare performance.

This demonstrates:

* Indirect function calls through a register (`call rbx`)
* Passing function pointers as arguments in x86-64 assembly

## Contents

Directory contents are:

* `fibonacci.asm`: Iterative, recursive, and measure_function implementations in NASM assembly for x86_64
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
Iterative cycles: 298
Recursive cycles: 4398621
```