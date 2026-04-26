; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    result_msg db "Fibonacci(%lu) = %lu", 10, 0


section .text

extern fibonacci
extern printf
extern scanf
global main


main:
    push rbp
    mov rbp, rsp

    ; Allocate space for local variable N at [rbp-16].
    sub rsp, 16

    ; Print prompt.
    lea rdi, [prompt]
    xor rax, rax
    call printf

    ; Read N with scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    xor rax, rax
    call scanf

    ; Call fibonacci(N).
    mov rdi, [rbp-16]
    call fibonacci

    ; Print result.
    lea rdi, [result_msg]
    mov rsi, [rbp-16]
    mov rdx, rax
    xor rax, rax
    call printf

    xor rax, rax            ; return 0
    leave
    ret
