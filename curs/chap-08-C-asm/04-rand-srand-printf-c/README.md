# Call srand(), rand(), and printf() — C Version

This demo is the C equivalent of `03-rand-srand-printf`.
It produces identical behaviour to the hand-written assembly version.
By disassembling the binary you can compare the compiler-generated code with the hand-written assembly.

## Contents

* `main.c`: C source that calls `srand(time(NULL))`, `rand()`, and `printf()`
* `Makefile`: Builds the `rand_srand_printf` binary
* `README.md`: This file

## Build

```console
make
```

This creates the `rand_srand_printf` binary.

## Run

```console
./rand_srand_printf
```

Example output:

```text
Random number: 717584553
```

## Understand

The C source maps directly onto the assembly from `03-rand-srand-printf`:

```c
srand(time(NULL));
printf("Random number: %d\n", rand());
```

To compare the compiler-generated code with the hand-written assembly, disassemble the binary:

```console
objdump -d -M intel rand_srand_printf | grep -A 30 '<main>'
```

Key things to look for:
* How the compiler represents the `NULL` argument to `time()` — typically `xor edi, edi` (could also be `mov edi, 0`).
* The `xor eax, eax` (or `mov eax, 0`) before `call printf` to clear the floating-point argument count.
* Whether the compiler stores intermediate results in registers or on the stack.
