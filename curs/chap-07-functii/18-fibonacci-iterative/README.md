# Iterative Fibonacci

This demo implements the Fibonacci function **iteratively** (without recursion).
Instead of calling itself, `fibonacci_iterative` maintains two accumulators (`rax` and `rdx`) and a loop counter (`rcx`), computing each successive Fibonacci number by swapping and adding, starting from `fib(1) = fib(2) = 1`.

The iterative approach:

* Avoids the overhead of recursive `call`/`ret` pairs
* Does not risk stack overflow for large `N`
* Is straightforward to implement with `xchg` and `add`

## Contents

Directory contents are:

* `fibonacci.asm`: Iterative Fibonacci implementation in NASM assembly for x86_64
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
Introduce N: 10
Fibonnaci(N) is: 89
```