# Return Value from main

This demo shows that the return value of `main` is passed back to the OS via the `rax` register.
The `main` function places the value `42` into `rax` before executing `ret`.
The exit code of the process will be 42, which can be observed by checking `$?` in the shell.

## Contents

Directory contents are:

* `ret_main.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `ret_main` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `ret_main` binary executable (ELF).

## Run

To run the binary and observe its exit code, use:

```console
./ret_main
echo $?
```

Running the commands above prints:

```text
42
```

This shows that the value placed in `rax` by `main` becomes the process exit code.