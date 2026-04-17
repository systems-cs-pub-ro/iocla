# Product of Two Sums Using Local Variables

This demo shows the use of **multiple local variables** on the stack to preserve values across function calls.

The program:

1. Reads a first value of `N`, calls `sum_n(N)`, and stores the result in the local variable `sum1` at `[rbp-24]`
1. Reads a second value of `N`, calls `sum_n(N)`, and stores the result in the local variable `sum2` at `[rbp-32]`
1. Computes the product of `sum1` and `sum2` using the `mul` instruction
1. Prints the product

This illustrates why local variables are needed: without them the result from the first `sum_n` call would be overwritten by the second call.

## Contents

Directory contents are:

* `sum_n_product.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `sum_n_product` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_n_product` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_n_product
```

Example interaction:

```text
Introduce N: 10
Introduce N: 5
Product is: 825
```

`sum(1..10) = 55`, `sum(1..5) = 15`, and `55 * 15 = 825`.

## Calling Convention Note: `xor rax, rax` Before `printf` and `scanf`

The System V AMD64 ABI requires that, before calling a variadic function such as `printf` or `scanf`, the `rax` register must hold the number of vector (SSE/AVX) registers used to pass floating-point arguments.
When no floating-point arguments are passed, `rax` must be zero.
Failing to zero `rax` before such a call can cause the function to read uninitialised XMM registers, leading to undefined behaviour or a crash.

The correct pattern is:

```nasm
lea rdi, [format_string]
mov rsi, value
xor rax, rax            ; no vector register arguments
call printf
```

This convention applies to every `printf` and `scanf` call.
Starting from this demo all assembly files zero `rax` immediately before each `printf` and `scanf` call.
