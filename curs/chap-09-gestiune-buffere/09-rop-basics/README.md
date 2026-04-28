# 09-rop-basics — Introduction to 64-bit ROP

## Why this demo exists

In **32-bit** stack overflows you could call any function with arbitrary
arguments by placing them on the stack right after the forged return address:

```
[padding] [func_addr] [fake_ret] [arg1] [arg2]
```

In **64-bit** the first six arguments go in registers (RDI, RSI, RDX, …),
not on the stack.  A plain return-address redirect sets the program counter
but leaves RDI/RSI unchanged — the arguments are wrong.

The solution is **Return-Oriented Programming (ROP)**: chain together short
instruction sequences ending in `ret` (called *gadgets*) to set registers
before jumping to the target function.

## The vulnerable program

`rop_target.c` has three "win" functions and one vulnerable function:

```
rop_target()  →  fgets(buf, 256, stdin) into char buf[64]  (overflow!)
```

**offset_to_ret = 72** (64-byte buffer + 8-byte saved RBP)

## Step-by-step

### 0. Build

```bash
make
```

### 1. Find addresses

```bash
nm rop_target | grep win        # addresses of win_noarg, win_onearg, win_twoarg
nm rop_target | grep rop_target # address of the vulnerable function (for reference)
```

### 2. Find ROP gadgets

```bash
# With ROPgadget:
ROPgadget --binary rop_target | grep "pop rdi"
ROPgadget --binary rop_target | grep "pop rsi"

# With objdump (manual gadget hunting):
objdump -d -Mintel rop_target | grep -B3 "ret$" | grep "pop"
```

Common gadgets emitted by GCC in `-no-pie` binaries:
- `pop rdi; ret` — appears in PLT stubs
- `pop rsi; pop r15; ret` — appears in `__libc_csu_init`

### 3. Run the goals

```bash
# Goal 1 — simple redirect, no arguments
python3 payload_goal1.py | ./rop_target

# Goal 2 — one argument via pop rdi; ret
python3 payload_goal2.py | ./rop_target

# Goal 3 — two arguments via pop rdi; ret + pop rsi; ret
python3 payload_goal3.py | ./rop_target
```

### 4. What to change in each script

Edit the `PLACEHOLDER` values at the top of each Python script:
- `pop_rdi_ret` / `pop_rsi_ret` — from `ROPgadget` output
- `win_*_addr` — from `nm rop_target`

## ROP chain visualisation (Goal 3)

```
 Stack (high → low after overflow, rsp moving upward on ret):
 ┌─────────────────────────┐
 │  72 × 'A'  (padding)    │  ← fills buf[64] + saved RBP
 ├─────────────────────────┤
 │  pop rdi; ret  (addr)   │  ← return address overwritten; CPU executes gadget
 ├─────────────────────────┤
 │  0xCAFE                 │  ← popped into RDI
 ├─────────────────────────┤
 │  pop rsi; ret  (addr)   │  ← gadget ret jumps here
 ├─────────────────────────┤
 │  0xBABE                 │  ← popped into RSI
 ├─────────────────────────┤
 │  win_twoarg  (addr)     │  ← final ret jumps here; RDI=0xCAFE, RSI=0xBABE
 └─────────────────────────┘
```
