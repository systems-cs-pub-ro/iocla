# Call srand(), rand(), and printf()

This demo extends `02-rand-srand` by also calling `printf()` to print the generated number.
`printf()` is a variadic C function that takes at least two arguments: a format string pointer in `rdi` and the value to print in `rsi`.

## Contents

* `main.asm`: Assembly `main` that calls `srand()`, `rand()`, and `printf()`
* `Makefile`: Builds the `rand_srand_printf` binary
* `README.md`: This file

## Build

```console
make
```

This creates the `rand_srand_printf` binary.

## Run

```console
./rand_srand_printf
```

Example output:

```text
Random number: 717584553
```

## Understand

Calling `printf()` requires an extra step compared to regular functions.
The System V AMD64 ABI requires that `rax` holds the number of floating-point arguments passed in vector registers before calling any variadic function.
When no floating-point arguments are present, `rax` must be zero:

```nasm
lea rdi, [printf_format]  ; 1st argument: format string address
mov rsi, rax              ; 2nd argument: the random number
xor rax, rax              ; 0 floating-point register arguments
call printf
```

Omitting `xor rax, rax` can cause `printf` to read undefined XMM register contents, leading to crashes or incorrect output.
