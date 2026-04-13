# Sum of First 100 Natural Numbers

This demo shows a function that computes the sum of the first 100 natural numbers and stores the result in a global variable.
The function `sum_100` uses the `loopnz` instruction to iterate from 100 down to 1, accumulating the sum in `rax`, and then stores the result in the global `sum` variable.
The caller (`main`) calls `sum_100` and then prints the result by reading the global `sum` variable.

## Contents

Directory contents are:

* `sum_100.asm`: Implementation in NASM assembly for x86_64
* `printf64.asm`: Macro helper for calling `printf`
* `Makefile`: Makefile to build the assembly file into the `sum_100` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_100` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_100
```

Running the command above prints out the message:

```text
Sum is: 5050
```

The sum of the first 100 natural numbers is 5050.