# Call C Function to Add Array Elements

This demo shows assembly code calling a C function that processes an array.
Passing an array in C means passing a pointer to the first element and the element count as separate arguments.

## Contents

* `sum_array.c`: Implements `sum_array(array, length)` that returns the sum of the array elements
* `main.asm`: Assembly `main` that calls `sum_array()` and prints the result
* `Makefile`: Builds the `sum_array` binary from both source files
* `README.md`: This file

## Build

```console
make
```

This creates the `sum_array` binary.

## Run

```console
./sum_array
```

Output:

```text
Sum of array elements is: 360
```

## Understand

An array argument is passed as two values following the System V ABI:

```nasm
; Call sum_array(num_array, len).
; rdi = pointer to first element (1st argument)
; rsi = number of elements (2nd argument)
mov rdi, num_array      ; base address of the array
mov rsi, len            ; number of elements (computed at assembly time)
call sum_array          ; rax = sum of all elements
```

The array data is defined in the `.rodata` section and its length is computed at assembly time using the `$` (current address) trick:

```nasm
num_array dq 10, 20, 30, 40, 50, 60, 70, 80
len equ ($-num_array)/8     ; number of 8-byte elements
```

On the C side, `sum_array` receives a pointer and a count — it has no way of knowing the array size on its own.
