# Print argv[1] with Argument Count Check

This demo extends `14-print-argv0` by accessing `argv[1]` and adding a check on `argc`.
The program verifies that exactly 2 arguments were provided (program name + one argument).
If the count is wrong, it prints an error message and exits.
Otherwise it prints `argv[1]`, which is at `[rsi+8]` (second pointer in the `argv` array).
This demonstrates conditional branching and error handling in assembly.

## Contents

Directory contents are:

* `print_argv1.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `print_argv1` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `print_argv1` binary executable (ELF).

## Run

To run the binary with an argument, use:

```console
./print_argv1 hello
```

Running the command above prints:

```text
argv[1] is hello
```

Running without arguments prints an error:

```text
Incorrect number of arguments. Expected 2, got 1.
```