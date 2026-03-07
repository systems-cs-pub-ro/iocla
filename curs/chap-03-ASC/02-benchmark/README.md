

# 02-benchmark: 16-bit multiply - C vs inline-ASM, 32 vs 64 bit

## Source Files

| File | Description |
|---|---|
| `mult16c.c` | Pure-C shift-and-add multiply algorithm |
| `mult16inline.c` | Inline x86-64 assembly multiply (64-bit, uses `%rdx`) |
| `mult16inline32.c` | Inline x86 assembly multiply (32-bit, uses `%edx`) |
| `mult16m.c` | Benchmark harness (main): reads repeat count, times `mult()` |

## Executables Produced

| Executable | Components | ABI |
|---|---|---|
| `c32.out` | mult16m + mult16c | `-m32` |
| `asm32.out` | mult16m + mult16inline32 | `-m32` |
| `c64.out` | mult16m + mult16c | `-m64` |
| `asm64.out` | mult16m + mult16inline | `-m64` |

---

## Build

Build all four executables at once:

```bash
make
```

You should see gcc invocations for each of the 8 object files followed by 4 link
steps. The Makefile prints the flags being used via `$(warning ...)` before every
compile step so you can verify the `-m32` / `-m64` switch.

Clean all generated files:

```bash
make clean
```

---

## Demo 01 - Inspect the source files

### 1. Pure-C algorithm (shift-and-add)

```bash
less mult16c.c
```

Key points:
- 16 iterations, one per bit of `value2`
- Each iteration: if LSB of `value2` is set, add `value1` to `product`
- `value1 <<= 1` shifts the multiplicand left (multiply by 2 each step)
- `value2 >>= 1` exposes the next bit of the multiplier

### 2. 64-bit inline-ASM algorithm

```bash
less mult16inline.c
```

Key points:
- `BSF` (Bit Scan Forward) finds the lowest set bit index into `ECX`
- `MOVSLQ` sign-extends 32-bit `value1` into 64-bit `RDX`
- `SHLQ` shifts `RDX` left by `ECX` positions
- `ADDQ` accumulates into `product`
- `BTC` (Bit Test and Complement) clears that bit in `value2`
- Loop until `value2 == 0` (`BSF` sets `ZF` when source is 0)

### 3. 32-bit inline-ASM algorithm

```bash
less mult16inline32.c
```

Same logic as above but:
- `MOVL` instead of `MOVSLQ` (no sign-extension needed in 32-bit mode)
- `SHLL` / `ADDL` instead of `SHLQ` / `ADDQ`
- `EDX` instead of `RDX` (32-bit register)

### 4. Benchmark harness

```bash
less mult16m.c
```

Key points:
- Reads repeat count `n` from stdin
- Runs `n x 1,000,000` calls to `mult()`
- Uses `clock()` / `CLOCKS_PER_SEC` to measure CPU time
- `mult()` is declared `extern` so the linker resolves it to whichever
  object file is linked in (`c*.o` or `inline*.o`)

---

## Demo 02 - Run the benchmarks and compare timings

Run each binary with a repeat count of 1000 (= 10^9 total calls).
Use the shell built-in `time` to measure wall-clock time.

**32-bit binaries:**

```bash
time { echo 1000 | ./c32.out ; }
time { echo 1000 | ./asm32.out ; }
```

**64-bit binaries:**

```bash
time { echo 1000 | ./c64.out ; }
time { echo 1000 | ./asm64.out ; }
```

Expected observations:
- The inline-ASM version (BSF/BTC loop) skips zero bits entirely, so it is
  typically faster when `value2` is sparse (few set bits).
- `value2=4096` has exactly 1 set bit, so the ASM loop runs only once per call
  while the C loop always runs 16 iterations.
- 64-bit binaries may show slightly different timings than 32-bit due to ABI
  differences (register widths, calling conventions).

---

## Demo 03 - GDB walkthrough (32-bit binary)

Debug the 32-bit inline-ASM binary to observe the registers:

```bash
gdb ./asm32.out
```

Inside GDB:

```
(gdb) b mult              # set breakpoint at the start of mult()
(gdb) r                   # run; type a small repeat count, e.g. 1
(gdb) disassemble         # view the compiler-generated + inline ASM
(gdb) info registers      # inspect eax, ecx, edx, etc.
(gdb) n                   # step one source line
(gdb) si                  # step one machine instruction
(gdb) p product           # print the current value of product
(gdb) p value1            # print value1 (should be 1000)
(gdb) p value2            # print value2 (should be 4096 = 0x1000)
(gdb) q                   # quit
```

---

## Demo 04 - GDB walkthrough (64-bit binary)

Debug the 64-bit inline-ASM binary to observe 64-bit registers:

```bash
gdb ./asm64.out
```

Inside GDB:

```
(gdb) b mult              # set breakpoint at the start of mult()
(gdb) r                   # run; type a small repeat count, e.g. 1
(gdb) disassemble         # note movslq / shlq / addq instructions
(gdb) info registers      # inspect rax, rcx, rdx, etc. (64-bit)
(gdb) n                   # step one source line
(gdb) si                  # step one machine instruction
(gdb) p product           # print the current value of product
(gdb) p/x value2          # print value2 in hex (0x1000 = bit 12 set)
(gdb) q                   # quit
```

---

## Demo 05 - Inspect the generated assembly

Dump the compiled machine code for the multiply function.

**32-bit:**

```bash
objdump -d -M intel c32.out   | grep -A 30 "<mult>"
objdump -d -M intel asm32.out | grep -A 30 "<mult>"
```

**64-bit:**

```bash
objdump -d -M intel c64.out   | grep -A 30 "<mult>"
objdump -d -M intel asm64.out | grep -A 30 "<mult>"
```

Points to compare:
- The C version emits a `SHL`/`ADD` loop with a fixed 16-iteration counter;
  the compiler may auto-vectorise or unroll with `-O2`.
- The ASM version emits `BSF`/`BTC` with a variable-length loop.
- In the 64-bit dump, look for `MOVSLQ` (sign-extend 32 to 64) which is absent
  from the 32-bit dump.

---

## Quick Reference

| Command | Description |
|---|---|
| `make` | Build all four executables |
| `make clean` | Remove all `.o` and `.out` files |
| `less Makefile` | Review compiler flags and rules |
| `file c32.out asm32.out c64.out asm64.out` | Confirm ELF 32/64-bit headers |
