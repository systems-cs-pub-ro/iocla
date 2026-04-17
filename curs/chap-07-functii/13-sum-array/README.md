# Sum of Elements in an Array

This demo shows a function that takes a **pointer and a count** as arguments and sums the elements of an array.

The function signature is:

```c
unsigned long sum_array(unsigned long *a, size_t num_items);
```

* `rdi` holds the array base address
* `rsi` holds the number of elements

The function accesses elements as `[rbx + rcx * 8 - 8]`, iterating from the last element down to the first using `loopnz`.
`main` passes a statically defined array and its length (computed at assembly time using the `$` symbol).

## Contents

Directory contents are:

* `sum_array.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `sum_array` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_array` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_array
```

Running the command above prints:

```text
Sum of items in array is: 360
```

The array contains `{10, 20, 30, 40, 50, 60, 70, 80}` and their sum is 360.