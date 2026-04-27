# C <-> ASM Interface Examples (x86-64, System V AMD64)

This folder contains 3 examples that mirror the style of `func-cdecl`, focused on calling between C and assembly.

## Files

- `asm_call_c_main.asm` + `asm_call_c_sum.c`
  - Assembly `main` defines the array in `.data`, calls a C function that sums the array, then prints the result.

- `c_call_asm_main.c` + `c_call_asm_sum.asm`
  - C `main` has a globally initialized array and calls an assembly function to compute the sum.

- `inline_asm.c`
  - Single C file that uses GCC inline assembly to sum an array.

## Build and run

```bash
make
./asm_call_c
./c_call_asm
./inline_asm
```

## Clean

```bash
make clean
```

---

## GCC Extended Inline Assembly

### Basic structure

```c
__asm__ volatile (
    "asm instructions"
    : outputs
    : inputs
    : clobbers
);
```

Each section is separated by `:`. Any section can be empty (just leave it blank or omit trailing colons).

---

### Why `volatile`?

Without `volatile`, GCC treats the asm block like a pure function: if it thinks the outputs are unused or the block can be hoisted/eliminated/reordered, it will do so.

`volatile` suppresses all of that:
- The block is **always emitted**, even if the output is unused.
- The block is **not moved** relative to other memory operations.
- Multiple identical blocks are **not merged** into one.

Use `volatile` whenever the asm has side effects beyond its declared outputs (e.g. it reads/writes memory, modifies flags, or does I/O). Omit it only for pure computational blocks where GCC optimizing away redundant calls is acceptable.

---

### Outputs

```c
: "=&r" (sum)
```

Each output is `"constraint" (c_variable)`. The variable receives the register value after the block.

| Modifier | Meaning |
|---|---|
| `=` | write-only - value on entry is discarded |
| `+` | read-write - value is read on entry and written on exit |
| `&` | early-clobber - this register is written before all inputs are consumed; GCC must not share it with any input |

---

### Inputs

```c
: "r" (arr), "r" (n)
```

Each input is `"constraint" (c_expression)`. GCC loads the value into the chosen location before the block. Inputs are numbered after outputs: if there is one output (`%0`), inputs start at `%1`, `%2`, ...

---

### Operand constraints

| Constraint | Location |
|---|---|
| `r` | any general-purpose register (GCC chooses) |
| `a` | `rax` / `eax` |
| `b` | `rbx` / `ebx` |
| `c` | `rcx` / `ecx` |
| `d` | `rdx` / `edx` |
| `S` | `rsi` / `esi` |
| `D` | `rdi` / `edi` |
| `m` | memory operand |
| `i` | immediate integer constant |

With `r`, GCC picks the register - use size modifiers in the asm string to get the right-width name:

| Modifier | Register size | Example (`%0` → `rsi`) |
|---|---|---|
| `%q0` | 64-bit | `rsi` |
| `%k0` | 32-bit | `esi` |
| `%w0` | 16-bit | `si` |
| `%b0` | 8-bit | `sil` |

With specific constraints (`a`, `c`, `S`, ...) you know the register name and can write it directly.

---

### Named operands

Instead of positional `%0`, `%1`, you can use names:

```c
__asm__ volatile (
    "add %k[sum], dword ptr [%q[arr] + r8 * 4]"
    : [sum] "=&r" (sum)
    : [arr] "r"   (arr), [n] "r" (n)
    : "r8", "cc", "memory"
);
```

---

### Clobbers

Declare every register and resource the asm modifies that is not an output:

| Clobber | Meaning |
|---|---|
| `"rax"`, `"r8"`, ... | asm modifies this register |
| `"cc"` | asm modifies RFLAGS (`add`, `sub`, `cmp`, `test`, `inc`, `dec`, ...) |
| `"memory"` | asm reads/writes memory GCC cannot see; acts as a compiler barrier - GCC flushes cached values and cannot reorder memory ops across the block |

Omitting a clobber is undefined behaviour: GCC may place a live value in that register and your asm will silently corrupt it.

---

### Numeric labels

Use numbers instead of named labels to avoid collisions when the same asm block is inlined multiple times:

```c
"test ecx, ecx\n\t"
"jle 2f\n\t"      // jump forward to label 2
"1:\n\t"          // loop top
"  ...\n\t"
"jl 1b\n\t"       // jump backward to label 1
"2:\n\t"          // exit
```

`f` = forward, `b` = backward. The same number can appear many times; the direction disambiguates which instance is the target.
