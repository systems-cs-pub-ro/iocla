# Sum of First N Numbers in C (Reference Implementation)

This is the equivalent C implementation of the assembly programs in `08-sum-n-scanf` and `09-sum-n-local`.
Comparing this C source with the assembly counterparts illustrates:

* How a C `for` loop maps to assembly loop constructs
* How local variables in C map to stack allocations in assembly
* How function arguments and return values are passed

This serves as a reference to understand what the compiler does behind the scenes.

## Contents

Directory contents are:

* `sum_n_scanf.c`: C implementation
* `Makefile`: Makefile to build the C file into the `sum_n_scanf` binary executable (ELF)
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