# Tail-Recursive Fibonacci

This demo implements the Fibonacci function using **tail recursion**.

A function call is *tail* when it is the very last operation the caller performs before returning —
there is nothing left to do after the call, so its result can be returned directly.
In assembly this means the `call`/`ret` pair can be replaced by a plain `jmp`,
eliminating the need to create a new stack frame on each iteration.
The function therefore runs in **O(1) stack space**, regardless of `N`.

## How tail recursion works here

The standard recursive definition `fib(N) = fib(N-1) + fib(N-2)` is **not** tail-recursive because
after both recursive calls return the caller must still perform an addition.

The tail-recursive form introduces two accumulators `a` and `b`:

```nasm
; fibonacci_tail(n, a, b):
;   if n == 0  ->  return a
;   else       ->  fibonacci_tail(n-1, b, a+b)   ; tail call -> jmp
```

Calling `fibonacci_tail(N, 1, 1)` produces the same result as the standard recursive definition,
with `a` tracking `fib(k)` and `b` tracking `fib(k+1)` as `k` counts down to zero.

The `fibonacci` wrapper sets the initial accumulators and itself tail-calls `fibonacci_tail`:

```nasm
fibonacci:
    mov rsi, 1          ; a = fib(0) = 1
    mov rdx, 1          ; b = fib(1) = 1
    jmp fibonacci_tail  ; tail call — no new stack frame
```

Inside `fibonacci_tail` the update step uses `lea` to compute `a+b` before either
accumulator register is overwritten:

```nasm
    dec rdi
    lea rax, [rsi + rdx]    ; rax = a + b  (new b)
    mov rsi, rdx            ; new a = old b
    mov rdx, rax            ; new b = old a + old b
    jmp fibonacci_tail
```

## Contents

Directory contents are:

* `fibonacci.asm`: Tail-recursive Fibonacci implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `fibonacci` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `fibonacci` binary executable (ELF).

## Run

To run the binary, use:

```console
./fibonacci
```

Example interaction:

```text
Introduce N: 10
Fibonnaci(N) is: 89
```

The result matches the recursive and iterative implementations in demos 17 and 18.
Unlike the recursive version in demo 17, this implementation does not grow the call stack:
every iteration reuses the same stack frame via `jmp`.
