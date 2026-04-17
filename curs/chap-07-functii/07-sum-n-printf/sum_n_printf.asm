; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    N dq 200
    format db "Sum is: %lu", 10, 0


section .text

extern printf
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

    ; Call sum_n to compute of first N natural numbers.
    mov rdi, [N]
    call sum_n

    ; Print sum.
    lea rdi, [format]
    mov rsi, rax
    call printf

    leave
    ret
