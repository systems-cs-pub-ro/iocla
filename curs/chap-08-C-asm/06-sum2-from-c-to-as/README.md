# Call Assembly Function

This demo shows C code calling a function implemented in assembly.
The `add()` function is written in NASM assembly and linked with a C `main`.

## Contents

* `add.asm`: Assembly implementation of `add()` that receives two numbers and returns their sum
* `main.c`: C `main` that calls `add()` (using the System V ABI) and prints the result
* `Makefile`: Builds the `sum2` binary from both source files
* `README.md`: This file

## Build

```console
make
```

This creates the `sum2` binary by assembling `add.asm` and compiling `main.c`, then linking both object files together.

## Run

```console
./sum2
```

Output:

```text
Sum is: 5
```

## Understand

`add.asm` exposes `add` as a global symbol with the correct calling convention:

```nasm
global add

; long add(long a, long b)
; a is in rdi, b is in rsi, return value in rax.
add:
    mov rax, rdi
    add rax, rsi
    ret
```

`main.c` declares the function inline and calls it like any other C function:

```c
long add(long a, long b);

long result = add(2, 3);   /* result = 5 */
```

The key constraint is that the assembly function must follow the System V AMD64 ABI exactly:
arguments in `rdi`, `rsi`, ... return value in `rax`.

See `07-sum2-from-c-to-as-header` for the recommended practice of using a header file instead of an inline declaration.
