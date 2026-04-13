# Sum of First N Numbers with scanf Input

This demo introduces reading user input at runtime with `scanf` from assembly.

The program:

1. Prints a prompt using `printf`
1. Reads `N` from standard input using `scanf` into a global variable
1. Calls `sum_n(N)` to compute the sum
1. Prints the result with `printf`

This demonstrates calling a variadic C function (`scanf`) with an address argument (`lea rsi, [N]`).

## Contents

Directory contents are:

* `sum_n_scanf.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `sum_n_scanf` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_n_scanf` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_n_scanf
```

Running the command above prints the prompt and waits for input:

```text
Introduce N: 10
Sum is: 55
```