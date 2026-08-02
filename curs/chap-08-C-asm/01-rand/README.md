# Call rand()

This demo calls the `rand()` function from the C standard library.
`rand()` receives no arguments and returns a pseudo-random integer.
The return value arrives in `rax` following the System V AMD64 ABI.

## Contents

* `main.asm`: Assembly `main` that calls `rand()` and prints the result
* `Makefile`: Builds the `rand` binary
* `README.md`: This file

## Build

```console
make
```

This creates the `rand` binary.

## Run

```console
./rand
```

The program has no output.

## Understand

`rand()` is a C library function with no arguments.
In the System V AMD64 ABI, a function with no arguments is called with no register setup — simply issue `call rand`.
The return value is an `int` in `eax` (zero-extended to `rax`):

```nasm
call rand               ; rax = random number
```

We ignore the return value in the program, we will use it later.
