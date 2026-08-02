# Call srand() and rand()

This demo calls three C standard library functions that together produce a seeded pseudo-random number:

* `time(NULL)` — takes a `NULL` pointer argument, returns the current Unix epoch time in `rax`.
* `srand(seed)` — takes one integer argument (the seed) in `rdi`, returns `void`.
* `rand()` — takes no arguments, returns a pseudo-random integer in `rax`.

## Contents

* `main.asm`: Assembly `main` that chains `time()` → `srand()` → `rand()` and prints the result
* `Makefile`: Builds the `rand_srand` binary
* `README.md`: This file

## Build

```console
make
```

This creates the `rand_srand` binary.

## Run

```console
./rand_srand
```

The program has no output.

## Understand

The three functions demonstrate different calling patterns under the System V AMD64 ABI.

```nasm
; time(NULL) — argument is NULL (0); return value used as srand seed.
xor rdi, rdi        ; NULL pointer in rdi (1st argument)
call time           ; rax = current epoch time

; srand(seed) — seed in rdi, returns void.
mov rdi, rax        ; pass time() result as seed
call srand

; rand() — no arguments, random number in rax.
call rand
```

Argument 1 goes in `rdi`, argument 2 in `rsi`, and so on.
The return value is always in `rax`.
Because `srand()` returns `void`, `rax` after `call srand` is undefined — `rand()` is called immediately after with no register setup needed.
