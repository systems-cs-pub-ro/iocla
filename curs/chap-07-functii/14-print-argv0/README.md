# Print argv[0] — Command-Line Arguments

This demo shows how to access command-line arguments passed to `main`.
In the x86-64 System V ABI, `main` receives:

* `rdi`: `argc` (number of arguments)
* `rsi`: `argv` (pointer to array of string pointers)

`argv[0]` is the program name and its address is stored at `[rsi]`.
The demo dereferences `rsi` to get the pointer to the program name string and prints it with `printf`.

## Contents

Directory contents are:

* `print_argv0.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `print_argv0` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `print_argv0` binary executable (ELF).

## Run

To run the binary, use:

```console
./print_argv0
```

Running the command above prints the path used to invoke the binary, for example:

```text
argv[0] is ./print_argv0
```

The exact string depends on how the binary is invoked.
When run as `./print_argv0` the output shows `./print_argv0`; when run with a full path the full path is shown.