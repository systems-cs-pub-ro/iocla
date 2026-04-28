# 11-binary — 64-bit NASM assembly exercise

## Goal

Implement the three functions in `diggers.asm` (or figure out the right
arguments to pass from `test.c`) so that the program prints:

```
Eureka!
ret: 6699
It has finally happened!
```

## Files

| File | Role |
|------|------|
| `test.c` | C driver that calls `alpha()`, `beta()`, `omega()` |
| `diggers.asm` | **Your 64-bit NASM implementation** |
| `Makefile` | Assembles `diggers.asm` with `nasm -f elf64`, links with `test.o` |

## 64-bit calling convention (System V AMD64 ABI)

| Arg position | Register |
|---|---|
| 1st | RDI / EDI |
| 2nd | RSI / ESI |
| 3rd | RDX / EDX |
| Return value | RAX / EAX |

## Tasks

1. **`alpha(unsigned int a)`** — call it with the right `a` to print `"Eureka!"`
   - Disassemble with `objdump -d -Mintel diggers.o | grep -A20 "alpha"`
   - Find the `cmp` instruction to see what value is expected.

2. **`beta(unsigned int b)`** — call it with the right `b` to return `6699`
   - Same approach: look for the `cmp` inside `beta`.

3. **`omega(unsigned int c)`** — call it with the right `c` to print `"It has finally happened!"`
   - `omega` calls `getppid()` internally.
   - Pass the parent PID at runtime: use `getppid()` in `test.c`.

## Build and run

```bash
make
./test
```

