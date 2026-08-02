# Call C Fibonacci Function

This demo shows assembly code calling a recursive function implemented in C.
The `fibonacci()` function is compiled from C and linked with an assembly `main`.

## Contents

* `fibonacci.c`: Implements the recursive `fibonacci()` function
* `main.asm`: Assembly `main` that reads N, calls `fibonacci(N)`, and prints the result
* `Makefile`: Builds the `fibonacci` binary from both source files
* `README.md`: This file

## Build

```console
make
```

This creates the `fibonacci` binary.

## Run

```console
./fibonacci
```

Example interaction:

```text
Introduce N: 10
Fibonacci(10) = 89
```

## Understand

The assembly `main` uses a local variable on the stack to store N between the `scanf` call and the `fibonacci` call:

```nasm
sub rsp, 16         ; allocate space; N is at [rbp-16]

lea rdi, [prompt]
xor rax, rax
call printf

lea rdi, [scanf_format]
lea rsi, [rbp-16]   ; pass address of local N to scanf
xor rax, rax
call scanf

mov rdi, [rbp-16]   ; load N as argument to fibonacci
call fibonacci      ; rax = fibonacci(N)
```

The local variable is needed because `rax` (which would hold N if stored in a register) is clobbered by `call printf`.
