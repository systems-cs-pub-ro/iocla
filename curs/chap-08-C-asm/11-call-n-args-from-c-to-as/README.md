# Call Assembly Functions with Multiple Arguments

This demo is the reverse of `10-call-n-args-from-as-to-c`: `sum2()` through `sum8()` are implemented in assembly and called from C.

## Contents

* `sums.asm`: Assembly implementations of `sum2()` through `sum8()`
* `sums.h`: Header file that declares all sum functions
* `main.c`: C `main` that calls each function and prints the results
* `Makefile`: Builds the `call_n_args` binary from all source files
* `README.md`: This file

## Build

```console
make
```

This creates the `call_n_args` binary.

## Run

```console
./call_n_args
```

Output:

```text
sum2(1,2) = 3
sum3(1,2,3) = 6
sum4(1,2,3,4) = 10
sum5(1,2,3,4,5) = 15
sum6(1,2,3,4,5,6) = 21
sum7(1,2,3,4,5,6,7) = 28
sum8(1,2,3,4,5,6,7,8) = 36
```

## Understand

In assembly, functions with 7 or more arguments read the extra arguments from the stack at `[rsp+8]`, `[rsp+16]`, and so on (the return address occupies `[rsp+0]`):

```nasm
; long sum8(a, b, c, d, e, f, g, h)
; rdi=a, rsi=b, rdx=c, rcx=d, r8=e, r9=f, [rsp+8]=g, [rsp+16]=h
sum8:
    mov rax, rdi
    add rax, rsi
    add rax, rdx
    add rax, rcx
    add rax, r8
    add rax, r9
    add rax, [rsp+8]    ; 7th argument
    add rax, [rsp+16]   ; 8th argument
    ret
```

The C compiler handles the argument layout automatically; the assembly must replicate it manually for the function to be callable from both C and assembly code.
