# Counter Function

This is an example of a function that increments a counter.
The called function (`counter`) increments the value of the `rcx` register and then returns.
The caller function (`main`) calls the `counter` function three times and then prints the counter in the `rcx` register.

## Contents

Directory contents are:

* `counter.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `counter` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `counter` binary executable (ELF).

## Run

To run the binary, use:

```console
./counter
```

Running the command above prints out the message:

```text
Counter is: 3
```

The message is the result of calling the `counter` function 3 times and incrementing the value of the `rcx` register 3 times.