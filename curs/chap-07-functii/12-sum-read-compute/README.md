# Refactoring: Read-and-Compute as a Separate Function

This demo refactors the read-input-then-compute pattern into a dedicated helper function `read_compute_sum`.
`read_compute_sum` handles the full sequence: print prompt, read `N`, compute and return `sum_n(N)`.
`main` simply calls `read_compute_sum` twice, stores the results in local variables, then computes and prints their product.

Key points demonstrated:

* A non-`main` function that uses the stack frame (`push rbp` / `mov rbp, rsp` / `leave` / `ret`)
* Allocating local variables within a helper function
* Composing functions (calling a function from a function)

## Contents

Directory contents are:

* `sum_read_compute.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `sum_read_compute` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `sum_read_compute` binary executable (ELF).

## Run

To run the binary, use:

```console
./sum_read_compute
```

Example interaction:

```text
Introduce N: 10
Introduce N: 5
Product is: 825
```