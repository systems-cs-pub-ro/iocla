; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    printf_format db "Fibonnaci(N) is: %lu", 10, 0


section .text

extern printf
extern scanf
global main


; unsigned long fibonacci_tail(unsigned long n, unsigned long a, unsigned long b)
;
; Arguments:
;   rdi = n   (remaining steps)
;   rsi = a   (current Fibonacci value:  fib at step k)
;   rdx = b   (next    Fibonacci value:  fib at step k+1)
;
; Returns fib(original n) in rax.
;
; Every recursive call is the last operation before returning, so it is
; replaced by a plain jmp instead of call/ret.  No additional stack frame
; is created on each iteration: the function runs in O(1) stack space.
fibonacci_tail:
    ; Base case: n == 0, return a.
    test rdi, rdi
    jz .done

    ; Tail call: fibonacci_tail(n-1, b, a+b).
    dec rdi
    lea rax, [rsi + rdx]    ; rax = a + b  (new b, computed before rsi changes)
    mov rsi, rdx            ; new a = old b
    mov rdx, rax            ; new b = old a + old b
    jmp fibonacci_tail

.done:
    mov rax, rsi            ; return a
    ret


; unsigned long fibonacci(unsigned long n)
;
; Public entry point.  Initialises the accumulators to fib(0)=1, fib(1)=1
; and tail-calls fibonacci_tail.  No stack frame is needed here either.
fibonacci:
    mov rsi, 1              ; a = fib(0) = 1
    mov rdx, 1              ; b = fib(1) = 1
    jmp fibonacci_tail      ; tail call — return address is the caller's


main:
    push rbp
    mov rbp, rsp

    ; Allocate space on the stack. Keep it 16 bytes-aligned.
    ; Allocate space for:
    ; - N (unsigned long, 8 bytes): address is [rbp-16].
    sub rsp, 16

    ; Print prompt.
    lea rdi, [prompt]
    xor rax, rax            ; no vector register arguments
    call printf

    ; Read N using scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    xor rax, rax            ; no vector register arguments
    call scanf

    ; Call fibonacci(N).
    mov rdi, [rbp-16]
    call fibonacci

    ; Print fibonacci.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
