# Recursive Fibonacci — Correct and Incorrect Implementations

This demo presents three versions of a recursive Fibonacci function, illustrating common mistakes when preserving registers across recursive calls.

The three files are:

* `fibonacci_bad1.asm` — **Broken**: `rdi` is not saved before the first recursive call.
  `rdi` is a caller-saved register, so after the call returns it contains whatever the callee left there.
  The second `dec rdi` then decrements that clobbered value instead of the original `N-1`, producing wrong results.
* `fibonacci_bad2.asm` — **Broken**: tries to fix `bad1` by saving `rdi` on the stack before the first call, but pops in the wrong order — it pops the saved `rdi` into `rdi` before reading the first result from `rax`, corrupting the second argument and causing a stack imbalance that leads to a segfault.
* `fibonacci_good3.asm` — **Correct**: saves `rdi` on the stack before the first call, pops it back after the call returns (restoring the original `N-1`), then saves `rax` and makes the second recursive call with the correct `rdi - 1`.

## Contents

Directory contents are:

* `fibonacci_bad1.asm`: First broken attempt
* `fibonacci_bad2.asm`: Second broken attempt
* `fibonacci_good3.asm`: Correct recursive implementation
* `Makefile`: Makefile to build all three binaries
* `README.md`: This file

## Build

To build the examples, use:

```console
make
```

This creates `fibonacci_bad1`, `fibonacci_bad2`, and `fibonacci_good3` binary executables.

## Run

Run the correct version:

```console
./fibonacci_good3
```

Example interaction:

```text
Introduce N: 10
Fibonnaci(N) is: 89
```

Compare with the buggy versions to observe incorrect output for the same input.