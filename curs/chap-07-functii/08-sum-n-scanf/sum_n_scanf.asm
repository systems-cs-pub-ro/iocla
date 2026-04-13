; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    printf_format db "Sum is: %lu", 10, 0


section .bss

    N resq 1


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

    ; Print prompt.
    lea rdi, [prompt]
    call printf

    ; Read N using scanf.
    lea rdi, [scanf_format]
    lea rsi, [N]
    call scanf

    ; Call sum_n to compute of first N natural numbers.
    mov rdi, [N]
    call sum_n

    ; Print sum.
    lea rdi, [printf_format]
    mov rsi, rax
    call printf

    leave
    ret
