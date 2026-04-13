# Sum of First N Natural Numbers (Function Argument)

This demo introduces passing an argument to a function.
The function `sum_n` takes a single argument `N` in the `rdi` register (following the System V AMD64 ABI) and computes the sum of the first `N` natural numbers, returning the result in `rax`.
The caller (`main`) loads a constant `N = 200` from the read-only data section into `rdi` before calling `sum_n`.

## Contents

Directory contents are:

* `sum_n.asm`: Implementation in NASM assembly for x86_64
* `printf64.asm`: Macro helper for calling `printf`
* `Makefile`: Makefile to build the assembly file into the `sum_n` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_n` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_n
```

Running the command above prints:

```text
Sum is: 20100
```

The sum of the first 200 natural numbers is 20100.