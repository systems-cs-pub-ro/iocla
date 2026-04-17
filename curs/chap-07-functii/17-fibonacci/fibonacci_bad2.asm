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


fibonacci:
    cmp rdi, 2
    jge .continue

    ; If N is 0 or 1, return 1.
    mov rax, 1
    jmp .out

.continue:
    ; If N >= 2, compute fibonacci(N-1) + fibonacci(N-2).

    ; fibonacci(N-1): Save rdi value and result on stack.
    dec rdi
    push rdi
    call fibonacci
    push rax

    ; fibonacci(N-2)
    pop rdi
    dec rdi
    call fibonacci

    ; Add two results together
    pop rdx
    add rax, rdx

.out:
    ret


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

    ; Call fibonaci(N).
    mov rdi, [rbp-16]
    call fibonacci

    ; Print fibonacci.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
