# Sum of First 100 Numbers with Return Value

This demo improves on `03-sum-100` by returning the computed sum via `rax` instead of storing it in a global variable.
The function `sum_100` accumulates the sum in `rax` and returns directly.
The caller (`main`) uses the value in `rax` immediately after the call, without any global variable.
This illustrates the x86-64 calling convention where integer/pointer return values are passed back to the caller in the `rax` register.

## Contents

Directory contents are:

* `sum_100_ret.asm`: Implementation in NASM assembly for x86_64
* `printf64.asm`: Macro helper for calling `printf`
* `Makefile`: Makefile to build the assembly file into the `sum_100_ret` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_100_ret` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_100_ret
```

Running the command above prints:

```text
Sum is: 5050
```