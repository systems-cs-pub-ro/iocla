# Sum of First N Numbers with Local Variable

This demo shows how to allocate and use a **local variable** on the stack instead of a global variable.
The `main` function allocates 16 bytes on the stack with `sub rsp, 16` (keeping 16-byte alignment) and uses `[rbp-16]` as the address for the local variable `N`.
The address of this local variable is passed to `scanf` to read user input directly into the stack frame.
This is the standard pattern for local variables in x86-64 assembly.

## Contents

Directory contents are:

* `sum_n_local.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `sum_n_local` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_n_local` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_n_local
```

Running the command above prints the prompt and waits for input:

```text
Introduce N: 10
Sum is: 55
```