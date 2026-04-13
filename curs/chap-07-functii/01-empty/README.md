# Empty Function

This is an example of calling an empty function in assembly.
The called function (`empty`) only contains the `ret` instruction to return to the caller function (`main`).

## Contents

Directory contents are:

* `empty.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `empty` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `empty` binary executable (ELF).

## Run

To run the binary, use:

```console
./empty
```

As the example showed the `main` function calling an empty function and nothing more, nothing is being shown / printed.