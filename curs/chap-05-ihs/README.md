# Chapter 5: The Hardware-Software Interface

When you write C code, the compiler quietly turns it into machine instructions that move data between registers, touch memory, and control how the program flows. What looks like a simple line of code becomes a small sequence of operations the processor actually understands. In the examples ahead, we'll peel back that layer. You'll compile small programs with `make`, look at the generated binary, and step through the instructions in GDB to see what's really happening.

The goal isn't to memorize assembly. It's to build a feel for how things work under the hood — how variables land on the stack, how conditions become jumps, and how loops are just comparisons followed by a jump back. Once you see it, the hardware stops feeling mysterious and starts feeling surprisingly logical.

---

## 1. Disassembly (`01-disass`)

This example contains two small C programs -- `one_var.c` and `many_vars.c` -- designed to be compiled and then disassembled. The code itself does almost nothing at runtime. That is the point: the interesting part is what the compiler *produces*, not what the program *does*.

### `one_var.c`

A single global variable `age` is initialized to 32. A function `f` assigns it the value 64. The `main` function returns 0 immediately. When you compile this and disassemble it (`objdump -d one_var` or by stepping through it in GDB), you observe how the compiler accesses a global variable. On x86-64, global variables live in the `.data` section. The compiler generates a `mov` instruction that writes to the variable's address using RIP-relative addressing -- a characteristic of the 64-bit ISA where memory operands are encoded relative to the current instruction pointer.

### `many_vars.c`

This program introduces several types of global data: an `unsigned int`, an `unsigned short`, a struct with mixed-size fields, an array of four integers, and a pointer. The functions `g` and `f` assign values to struct fields, modify array elements, and take the address of an array element. The function `alfa` returns a 64-bit constant.

The purpose here is to observe how the compiler handles different data sizes. Writing to an `unsigned short` field uses a 16-bit `mov`. Writing to an `unsigned char` uses an 8-bit `mov`. Struct field access compiles to base-plus-offset addressing. Array indexing uses scaled displacement. Pointer assignment stores an address. The function `alfa` returns a 64-bit value in `rax` -- on x86-64, the return value register is always `rax`, regardless of the data size.

Compile both programs with `make`, then disassemble or step through them in GDB to see how each C construct maps to specific x86-64 instructions.

---

## 2. Jumps (`02-jmp`)

This example demonstrates how the compiler translates control flow constructs into jump instructions. There are two programs: `jmp.c` and `je.c`.

### `jmp.c`

This program contains an unconditional `goto` that creates an infinite loop:

```c
start:
    i += 2;
    goto start;
    i += 6;
```

When compiled, the `goto` becomes a `jmp` instruction -- an unconditional transfer of control that moves the instruction pointer backward to the label. The statement `i += 6` is dead code; the compiler may warn about it or optimize it away entirely. Disassemble the binary and locate the `jmp` instruction. Note its target address and confirm that it jumps backward to the `add` instruction corresponding to `i += 2`.

### `je.c`

This program contains a conditional branch:

```c
if (i > 0)
    i += 1;
i += 2;
```

The compiler emits a comparison (`cmp`) followed by a conditional jump. The specific jump instruction depends on the condition and the signedness of the comparison. For `i > 0` where `i` is an `unsigned int`, the compiler might emit `je` (jump if equal, to skip the body when `i == 0`) or `jbe` (jump if below or equal). The key observation is the pattern: **compare, then conditionally jump past the body of the `if` statement**. The fall-through path executes the body; the jump path skips it.

Step through both programs in GDB and watch the instruction pointer. Pay attention to how `jmp` always transfers control, while `je` (or whichever conditional jump the compiler chose) only transfers control when the corresponding flag condition is met.

---

## 3. Flags (`03-flags`)

This is the first hand-written assembly example. The program `flags.asm` does not produce any output. Its sole purpose is to be stepped through in GDB while watching the RFLAGS register.

The x86 architecture uses a set of status flags that are updated as a side effect of arithmetic and logical instructions. The four flags you will observe in this example are:

- **ZF (Zero Flag)**: Set to 1 when the result of an operation is zero.
- **SF (Sign Flag)**: Set to 1 when the result is negative (the most significant bit is 1).
- **CF (Carry Flag)**: Set to 1 when an unsigned overflow or underflow occurs.
- **OF (Overflow Flag)**: Set to 1 when a signed overflow occurs.

The program walks through a series of instructions that deliberately trigger specific flag combinations. For instance, `sub rax, rax` always produces zero, so ZF is set. `inc rax` makes the result nonzero, so ZF is cleared. `shr rax, 1` shifts a 1 out of the least significant bit, setting CF. `dec rax` on a zero value produces 0xFFFFFFFFFFFFFFFF, which is negative in two's complement, so SF is set.

Several flag combinations are left as exercises -- the comments indicate the desired state (e.g., `; OF = 1`) but do not provide the instruction. Your task is to find an instruction or instruction sequence that produces the indicated flag combination. This is an exercise in understanding how arithmetic operations affect flags, which is essential for understanding how conditional jumps work: every conditional jump tests one or more of these flags.

Load the program in GDB, set a breakpoint at `main`, and step through each instruction with `si` (step instruction). After each step, examine the flags register to verify that the flags match the comments.

---

## 4. Computing a Sum (`04-sum`)

This example is a complete x86-64 assembly program that computes the sum of integers from 0 to 100 and prints the result. It demonstrates the fundamental loop pattern in assembly: initialize, compare, branch, update, repeat.

```nasm
mov     eax, 0      ; eax is the loop counter
mov     edx, 0      ; edx is sum
begin:
cmp     eax, 100
ja      out
add     edx, eax
add     eax, 1
jmp     begin
out:
mov [sum], rdx
```

The loop counter lives in `eax`. The accumulator lives in `edx`. On each iteration, the program compares the counter against 100. If the counter exceeds 100, it jumps to `out` (using `ja`, jump if above -- an unsigned comparison). Otherwise, it adds the counter to the accumulator, increments the counter, and jumps back to `begin`.

After the loop, the result is stored in the `sum` variable (a `resq` reservation in the `.bss` section) and printed using the `PRINTF64` macro. The macro is defined in `utils/printf64.asm` and wraps a call to the C library's `printf`, saving and restoring all general-purpose registers and flags so that calling it does not interfere with the surrounding code.

The expected output is 5050 (the well-known formula $\frac{n(n+1)}{2}$ with $n = 100$).

---

## 5. Hello World (`05-hello-world`)

This is the classic first assembly program, but it serves a deeper purpose than printing a string. The program exercises register sub-addressing, basic arithmetic, and a Linux system call.

The first section of `main` loads a 16-bit constant into `AX`, then overwrites `AH` and `AL` independently. This demonstrates the x86 register aliasing model: `RAX` is the full 64-bit register, `EAX` is the lower 32 bits, `AX` is the lower 16, and `AH`/`AL` are the high and low bytes of `AX`. An `add al, ah` instruction performs 8-bit arithmetic, and you should observe how the result and the flags differ from what you might expect with 32-bit or 64-bit operands.

The second section loads `EAX` with the value `0x1234ABCD`. After this instruction, examine the full `RAX` register in GDB. On x86-64, writing to a 32-bit register (`EAX`) zero-extends the result into the upper 32 bits of `RAX`. This is worth verifying because 16-bit and 8-bit writes do *not* zero-extend -- they leave the upper bits unchanged.

The third section performs a Linux system call to write the string "Hello, world!" to standard output. On x86-64, system calls use the `syscall` instruction with the following convention: the system call number goes in `RAX`, and the first three arguments go in `RDI`, `RSI`, and `RDX`. The write system call is number 1: `RDI` holds the file descriptor (1 for stdout), `RSI` holds the address of the buffer, and `RDX` holds the number of bytes to write. This is a fundamentally different mechanism from calling a C library function -- you are asking the kernel directly to perform I/O.

---

## 6. Conditional Move (`06-cmov`)

Conditional branches are expensive on modern processors. When the CPU encounters a conditional jump, it must predict which path will be taken (branch prediction). If the prediction is wrong, the pipeline is flushed and the processor stalls for several cycles while it fetches the correct instructions. For small, simple conditionals -- like updating a maximum value -- the penalty of a mispredicted branch can be avoided entirely by using a **conditional move** (`cmov`).

This example implements the same function in two ways: `update_max_jmp` uses a traditional compare-and-branch pattern, and `update_max_cmov` uses the `cmovg` instruction.

### The branch version (`update_max_jmp`)

```nasm
mov edx, edi            ; load the argument (x86-64 passes first int arg in edi)
cmp edx, [rel max]      ; compare argument with current max
jg update_max           ; if greater, jump to update
mov eax, 0              ; not greater: return 0
jmp return
update_max:
mov [rel max], edx      ; store new max
mov eax, 1              ; return 1
```

This is straightforward: compare, branch on the result, execute one of two paths. The problem is that if the branch direction is unpredictable (e.g., the input data is random), the pipeline stalls frequently.

### The conditional move version (`update_max_cmov`)

```nasm
mov ecx, [rel max]      ; load current max
mov eax, 0              ; assume not greater (return value = 0)
cmp edi, ecx            ; compare argument with max
cmovg ecx, edi          ; if greater, move the argument into ecx
mov [rel max], ecx      ; store (possibly updated) max
setg al                 ; set return value to 1 if the comparison was "greater"
```

The `cmovg` instruction conditionally moves a value only if the preceding comparison set the flags to indicate "greater." If the condition is false, the register is left unchanged. There is no branch, no prediction, and no pipeline stall. The `setg` instruction sets the low byte of `eax` to 1 or 0 depending on the same condition, producing the return value.

The C test harness (`test_update_max.c`) calls `update_max_cmov` with a series of values and prints whenever a new maximum is found. You can switch the call to `update_max_jmp` to verify that both implementations produce identical results.

---

## 7. Data Sections (`07-data`)

This example compares how data is laid out in memory when defined in C versus when defined directly in assembly. There are two programs -- `data_c.c` and `data_asm.asm` -- that define the same three variables: an initialized integer (`init = 3`), an uninitialized integer (`non_init`), and a read-only constant (`ro = 10`).

### The C version (`data_c.c`)

```c
int non_init;
int init = 3;
const int ro = 10;
```

When compiled, the compiler places `init` in the `.data` section (read-write, initialized data), `non_init` in the `.bss` section (read-write, zero-initialized data that occupies no space in the binary), and `ro` in the `.rodata` section (read-only data). You can verify this with `objdump -t data_c` or `readelf -s data_c`.

### The assembly version (`data_asm.asm`)

```nasm
section .data
init: dd 3

section .bss
non_init: resd 1

section .rodata
ro: dd 10
```

The assembly version makes the section placement explicit. `dd` defines a 32-bit (double word) initialized value. `resd` reserves space for one 32-bit value without initialization (the `.bss` section guarantees it will be zero at program start). The `.rodata` section holds the constant.

Compile both and compare their symbol tables and section layouts. The binary structure should be nearly identical: the compiler and the assembler produce the same ELF sections for the same kinds of data. The takeaway is that sections are not a C concept or an assembly concept -- they are an ELF (Executable and Linkable Format) concept that both languages target.

Use `objdump -h` to list the sections, `objdump -t` to see where each symbol is placed, and `readelf -S` to examine section attributes (read, write, execute permissions). Attempting to write to a `.rodata` variable at runtime will cause a segmentation fault -- the operating system enforces the section's read-only permission through page table entries.

---

## 8. Debugging with GDB

GDB is the tool you will use throughout this chapter (and throughout this course) to inspect processor state, step through instructions, and verify that your mental model of execution matches what actually happens. This section covers the essential commands for working with assembly-level programs.

### 8.1 Starting and controlling execution

Build any of the examples with `make`, then launch GDB:

```bash
gdb ./hello
```

Set a breakpoint at `main` and run the program:

```
(gdb) break main
(gdb) run
```

The program stops at the first instruction of `main`. From here, you have two stepping commands:

- `si` (step instruction): Execute one machine instruction. If the instruction is a `call`, step *into* the called function.
- `ni` (next instruction): Execute one machine instruction. If the instruction is a `call`, execute the entire function and stop after it returns.

Use `si` when you want to trace into function calls. Use `ni` when you want to skip over library calls like `printf` that you are not interested in.

To continue execution until the next breakpoint (or until the program exits):

```
(gdb) continue
```

To restart the program from the beginning without leaving GDB:

```
(gdb) run
```

### 8.2 Examining registers

Print all general-purpose registers:

```
(gdb) info registers
```

Print a specific register:

```
(gdb) print $rax
```

By default, GDB prints values in decimal. To print in hexadecimal:

```
(gdb) print/x $rax
```

The format specifiers you will use most often:

| Specifier | Format          | Example output     |
|-----------|-----------------|--------------------|
| `/x`      | Hexadecimal     | `0x1234abcd`       |
| `/d`      | Signed decimal  | `-1`               |
| `/u`      | Unsigned decimal| `4294967295`       |
| `/t`      | Binary          | `11111111...`      |
| `/o`      | Octal           | `037777777777`     |

These specifiers work with `print`, `x` (examine memory), and `display`.

### 8.3 Converting between bases

GDB's `print` command is a general expression evaluator. You can use it as a base converter by combining a literal in one base with a format specifier for another:

Decimal to hexadecimal:

```
(gdb) print/x 255
$1 = 0xff
```

Hexadecimal to decimal:

```
(gdb) print/d 0xff
$2 = 255
```

Hexadecimal to binary:

```
(gdb) print/t 0xff
$3 = 11111111
```

Binary to decimal (GDB does not support binary literals directly, but you can use shifts and adds, or simply use Python integration):

```
(gdb) python print(0b11111111)
255
```

Decimal to binary:

```
(gdb) print/t 5050
$4 = 1001110111010
```

This is useful throughout the flags example in particular: you can print the RFLAGS register in binary and read individual flag bits directly.

### 8.4 Examining memory

The `x` command examines memory at a given address. Its syntax is `x/NFU address`, where:

- **N** is the number of units to display.
- **F** is the format (same specifiers as `print`: `x`, `d`, `t`, etc.).
- **U** is the unit size: `b` (byte), `h` (halfword, 2 bytes), `w` (word, 4 bytes), `g` (giant, 8 bytes).

For example, to examine 4 words in hexadecimal starting at the address of a global variable:

```
(gdb) x/4xw &v
0x404040 <v>:   0x0000000a  0x00000014  0x0000001e  0x00000028
```

To examine a string in memory:

```
(gdb) x/s &msg
0x402000:   "Hello, world!\n"
```

### 8.5 Displaying the RFLAGS register

After each `si` step, you probably want to see how the flags changed. You can set up a persistent display:

```
(gdb) display/t $eflags
```

This prints the flags register in binary after every step. Alternatively, print it on demand:

```
(gdb) print $eflags
$5 = [ CF ZF PF ]
```

GDB helpfully prints the names of the flags that are currently set. This is especially useful when working through the `03-flags` example.

### 8.6 Setting register and variable values

You can modify register values at runtime to experiment:

```
(gdb) set $rax = 0xdeadbeef
(gdb) set $rip = main
```

The first command loads a value into `RAX`. The second resets the instruction pointer to the beginning of `main`, effectively restarting the function. You can also write to memory:

```
(gdb) set {int}0x404040 = 42
```

This writes the integer 42 to the memory address `0x404040`. Use this to test how your program behaves with different inputs without recompiling.

### 8.7 Disassembling

To see the disassembly of the current function:

```
(gdb) disassemble
```

To disassemble a specific function:

```
(gdb) disassemble f
```

If GDB shows AT&T syntax and you prefer Intel syntax (which matches NASM), add this to your `~/.gdbinit`:

```
set disassembly-flavor intel
```

Along with `set history save on` (to preserve command history across sessions), this is one of the first things you should configure.
