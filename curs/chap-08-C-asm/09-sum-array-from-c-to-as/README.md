# Call Assembly Function to Add Array Elements

This demo is the reverse of `08-sum-array-from-as-to-c`: the `sum_array()` function is implemented in assembly and called from C.

## Contents

* `sum_array.asm`: Assembly implementation of `sum_array(array, length)`
* `sum_array.h`: Header file that declares the `sum_array()` function
* `main.c`: C `main` that calls `sum_array()` and prints the result
* `Makefile`: Builds the `sum_array` binary from all source files
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

The assembly `sum_array` receives the array pointer in `rdi` and the element count in `rsi`, then iterates backwards using the `loop` instruction:

```nasm
; unsigned long sum_array(unsigned long *a, size_t num_items)
sum_array:
    mov rbx, rdi        ; base pointer
    mov rcx, rsi        ; counter (num_items down to 1)
    xor rax, rax        ; accumulator
.again:
    add rax, [rbx + rcx*8 - 8]
    loopnz .again
    ret
```

The addressing mode `[rbx + rcx*8 - 8]` accesses elements from index `num_items-1` down to index 0 as `rcx` decrements.

`rbx` is a **callee-saved** register under the System V ABI, so saving and restoring it is required if this function is called from code that relies on `rbx`.
Here the function is a leaf (it calls nothing else) and its callers happen to not use `rbx`, so no explicit save/restore is needed — but in production code, non-leaf functions must save callee-saved registers they modify.
