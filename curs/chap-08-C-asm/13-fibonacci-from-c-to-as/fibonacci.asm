; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .text

global fibonacci


; unsigned long fibonacci(unsigned long N)
; Returns 1 for N < 2, fibonacci(N-1) + fibonacci(N-2) otherwise.
; Argument N is in rdi.  Return value in rax.
fibonacci:
    cmp rdi, 2
    jge .continue

    ; Base case: N < 2 → return 1.
    mov rax, 1
    jmp .out

.continue:
    ; Save N-1 on the stack and compute fibonacci(N-1).
    dec rdi
    push rdi
    call fibonacci
    pop rdi                 ; restore rdi = N-1

    ; Save fibonacci(N-1) and compute fibonacci(N-2).
    push rax
    dec rdi
    call fibonacci

    ; rax = fibonacci(N-2); add saved fibonacci(N-1).
    pop rdx
    add rax, rdx

.out:
    ret
