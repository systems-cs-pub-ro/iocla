# Call C Functions with Multiple Arguments

This demo shows how to call C functions with 2 to 8 arguments from assembly.
The System V AMD64 ABI passes the first six integer arguments in registers; the seventh and beyond go on the stack.

## Contents

* `sums.c`: Implements `sum2()` through `sum8()`, each adding all of its arguments and returning the sum
* `main.asm`: Assembly `main` that calls each function and prints all results
* `Makefile`: Builds the `call_n_args` binary from both source files
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

The first six integer arguments map to registers in order:

| Argument | Register |
|----------|----------|
| 1st | `rdi` |
| 2nd | `rsi` |
| 3rd | `rdx` |
| 4th | `rcx` |
| 5th | `r8` |
| 6th | `r9` |
| 7th+ | stack |

For `sum7` the 7th argument is pushed before the call and the stack is cleaned up afterwards:

```nasm
push qword 7            ; 7th argument on the stack
mov rdi, 1
mov rsi, 2
mov rdx, 3
mov rcx, 4
mov r8,  5
mov r9,  6
call sum7
add rsp, 8              ; remove the stack argument
```

For `sum8` both the 7th and 8th arguments are pushed in **reverse order** (last argument first) so that argument 7 is at `[rsp+8]` and argument 8 is at `[rsp+16]` when the callee accesses them:

```nasm
push qword 8            ; 8th argument pushed first
push qword 7            ; 7th argument pushed second (closer to callee's stack top)
; ... load registers ...
call sum8
add rsp, 16             ; remove both stack arguments
```
