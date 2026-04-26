# Call C Function

This demo shows assembly code calling a function implemented in C.
The `add()` function is compiled from C and linked with an assembly `main`.

## Contents

* `add.c`: Implements `add()` that receives two numbers and returns their sum
* `main.asm`: Assembly `main` that calls `add()` (using the System V ABI) and prints the result
* `Makefile`: Builds the `sum2` binary from both source files
* `README.md`: This file

## Build

```console
make
```

This creates the `sum2` binary by compiling `add.c` and assembling `main.asm`, then linking both object files together.

## Run

```console
./sum2
```

Output:

```text
Sum is: 5
```

## Understand

`main.asm` declares `add` as an external symbol and calls it following the System V ABI:

```nasm
extern add

; Call add(2, 3).
; 1st argument in rdi, 2nd argument in rsi.
mov rdi, 2
mov rsi, 3
call add        ; rax = 5

lea rdi, [printf_format]
mov rsi, rax    ; print the result
xor rax, rax
call printf
```

The linker resolves `add` to the compiled C object file `add.o`.
This is the standard mechanism for calling C library functions from assembly — the same technique used when calling `printf` or `scanf`.
