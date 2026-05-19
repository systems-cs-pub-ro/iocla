# Chapter 11: Floating-Point Demos (x86-64)

This directory contains standalone demos for floating-point representation and floating-point computation in x86-64.
All assembly examples use NASM with ELF64 output and follow the System V AMD64 ABI.

---

## Directory Structure

Each demo is organized in its own subdirectory with individual Makefiles:

* `arrayfsum/` - Array summation with x64 assembly implementation
* `quad/` - Quadratic equation solver with real roots in x64 assembly
* `fpadd/` - Floating-point addition demo and printf in assembly
* `fpprint/` - Utility to inspect IEEE-754 bit fields for `float` and `double`
* `fp_representation/` - C demo of floating-point precision, associativity, and rounding artifacts
* `arrayfsum_inline/` - Inline assembly variant for array summation

---

## Build

To build a specific demo, enter its directory and run make:

```console
cd arrayfsum
make
```

To clean artifacts from a specific demo:

```console
cd arrayfsum
make clean
```

To build all demos at once, you can use a loop:

```console
for dir in arrayfsum quad fpadd fpprint fp_representation arrayfsum_inline; do
  make -C $dir
done
```

---

## Demos

### Demo: `arrayfsum` - Array Sum with Assembly

**Location:** `arrayfsum/`

**Files:** `arrayfsuma.asm`, `arrayfsumc.c`

The program reads 10 `double` values, calls `array_fsum`, and prints the total sum.

`array_fsum` follows the x64 calling convention:

* `rdi`: pointer to array
* `esi`: number of elements
* `xmm0`: return value (`double` sum)

The implementation iterates over the array and accumulates with `addsd`.

**Build and Run:**

```console
cd arrayfsum
make
./arrayfsumc
```

---

### Demo: `quad` - Quadratic Roots in Assembly

**Location:** `quad/`

**Files:** `quada.asm`, `quadc.c`

`quadc` reads coefficients `a`, `b`, `c` and calls:

```c
int quad_roots(double a, double b, double c, double *root1, double *root2);
```

The assembly function computes the discriminant:

$$
\Delta = b^2 - 4ac
$$

If $\Delta < 0$, it returns `0` (no real roots).
Otherwise, it computes and stores:

$$
\text{root1} = \frac{-b + \sqrt{\Delta}}{2a}
$$

$$
\text{root2} = \frac{-b - \sqrt{\Delta}}{2a}
$$

**Build and Run:**

```console
cd quad
make
./quadc
```

---

### Demo: `fpadd` - Floating-Point Addition

**Location:** `fpadd/`

**File:** `fpadd.asm`

Pure x64 assembly demo of floating-point addition and `printf` output.
Demonstrates SSE/SSE2 floating-point operations and calling conventions for `printf`.

This demo computes `2.0 + 2.0` using SSE2 (`movsd`/`addsd`) and prints the result with `printf`.
Because `printf` is variadic, the call sets `eax = 1` to indicate one vector argument (`xmm0`) is used.

**Build and Run:**

```console
cd fpadd
make
./fpadd
```

Expected output:

```text
result: 4.000000
```

---

### Demo: `fpprint` - IEEE-754 Bit Field Inspector

**Location:** `fpprint/`

**File:** `fpprint.c`

Utility to inspect IEEE-754 bit fields for `float` and `double` values.
Prints sign, exponent, and mantissa components.

This utility prints sign/exponent/mantissa fields for several `float` and `double` values, including infinities and NaN.
It is useful for visualizing binary representation details.

**Build and Run:**

```console
cd fpprint
make
./fpprint
```

---

### Demo: `fp_representation` - Floating-Point Precision

**Location:** `fp_representation/`

**File:** `fp_representation.c`

C demo illustrating floating-point precision, associativity issues, and rounding artifacts.
Compiled at two optimization levels:

* `fp-m64`: Compiled with `-m64` (no optimization)
* `fp-m64-O2`: Compiled with `-m64 -O2` (optimized)

Also generates Intel syntax assembly files:

* `fp-m64.s`: Assembly without optimization
* `fp-m64-O2.s`: Assembly with optimization

This program illustrates:

* decimal-to-binary approximation errors (e.g. `0.1`)
* non-associativity in floating-point arithmetic
* precision loss at large magnitudes

**Build and Run:**

```console
cd fp_representation
make
./fp-m64
./fp-m64-O2
```

---

### Demo: `arrayfsum_inline` - Inline Assembly Summation

**Location:** `arrayfsum_inline/`

**File:** `arrayfsum_inline.c`

Inline-assembly variant of array summation using x87 instructions from C.
Demonstrates how to pass C values into fixed registers and return a floating-point result
through inline-asm constraints.

This file is compiled to an object file (no standalone binary).

**Build:**

```console
cd arrayfsum_inline
make
```

---

## Notes

* All binaries are built in their respective directories
* Each demo has its own Makefile for independent building
* To clean artifacts, run `make clean` in each demo directory
* Assembly files use Intel syntax with NASM
* All code follows the System V AMD64 ABI calling convention
