# Call Assembly Fibonacci Function

This demo is the reverse of `12-fibonacci-from-as-to-c`: the `fibonacci()` function is implemented in assembly and called from C.

## Contents

* `fibonacci.asm`: Assembly implementation of the recursive `fibonacci()` function
* `fibonacci.h`: Header file that declares `fibonacci()`
* `main.c`: C `main` that reads N, calls `fibonacci(N)`, and prints the result
* `Makefile`: Builds the `fibonacci` binary from all source files
* `README.md`: This file

## Build

```console
make
```

This creates the `fibonacci` binary.

## Run

```console
./fibonacci
```

Example interaction:

```text
Introduce N: 10
Fibonacci(10) = 89
```

## Understand

The assembly `fibonacci` uses push/pop to preserve `rdi` (N) and `rax` (intermediate result) across recursive calls:

```nasm
fibonacci:
    cmp rdi, 2
    jge .continue

    mov rax, 1          ; base case
    jmp .out

.continue:
    dec rdi
    push rdi            ; save N-1 before first recursive call
    call fibonacci      ; rax = fibonacci(N-1)
    pop rdi             ; restore rdi = N-1

    push rax            ; save fibonacci(N-1)
    dec rdi             ; rdi = N-2
    call fibonacci      ; rax = fibonacci(N-2)

    pop rdx             ; rdx = fibonacci(N-1)
    add rax, rdx        ; rax = fibonacci(N)
.out:
    ret
```

The order of `pop rdi` (before `push rax`) is critical: it must happen before the second `dec rdi` so that `rdi` contains the correct `N-1` value to decrement to `N-2`.
