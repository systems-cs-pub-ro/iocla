# Sum of First N Numbers Using printf Directly

This demo shows calling the C standard library `printf` function directly from assembly, without the `printf64.asm` macro helper.
The function sets up arguments manually according to the System V AMD64 ABI:

* `rdi` receives the format string address
* `rsi` receives the integer value to print

This makes explicit what the `PRINTF64` macro hides, and demonstrates how to call any external C function from assembly.

## Contents

Directory contents are:

* `sum_n_printf.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `sum_n_printf` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_n_printf` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_n_printf
```

Running the command above prints:

```text
Sum is: 20100
```