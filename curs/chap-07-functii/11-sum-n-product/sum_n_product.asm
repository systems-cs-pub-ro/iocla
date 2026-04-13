; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    printf_format db "Product is: %lu", 10, 0


section .text

extern printf
extern scanf
global main


sum_n:
    ; Initialize counter to 1st argument.
    mov rcx, rdi

    ; Initialize accumulating register to 0.
    xor rax, rax

    ; Compute sum in accumulating register.
.again:
    add rax, rcx
    loopnz .again

    ret


main:
    push rbp
    mov rbp, rsp

    ; Allocate space on the stack. Keep stack 16 bytes-aligned.
    ; Allocate space for:
    ; - N (unsigned long, 8 bytes): address is [rbp-16]
    ; - sum1 (unsigned long, 8 bytes): address is [rbp-24]
    ; - sum2 (unsigned long, 8 bytes): address is [rbp-32]
    sub rsp, 32

    ; Print prompt.
    lea rdi, [prompt]
    xor rax, rax            ; no vector register arguments
    call printf

    ; Read N using scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    xor rax, rax            ; no vector register arguments
    call scanf

    ; Call sum_n to compute first sum of first N natural numbers.
    mov rdi, [rbp-16]
    call sum_n

    ; Store result in sum1 variable (at rbp-24).
    mov [rbp-24], rax

    ; Print prompt.
    lea rdi, [prompt]
    xor rax, rax            ; no vector register arguments
    call printf

    ; Read N (2nd time) using scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    xor rax, rax            ; no vector register arguments
    call scanf

    ; Call sum_n to compute second sum of first N natural numbers.
    mov rdi, [rbp-16]
    call sum_n

    ; Store result in sum2 variable (at rbp-32).
    mov [rbp-32], rax

    ; Compute product of two sums (sum1: [rbp-24], sum2: [rbp-32]).
    ; Result is in rdx:rax.
    mov rax, [rbp-24]
    mul qword [rbp-32]

    ; Print product. We only print rax.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
