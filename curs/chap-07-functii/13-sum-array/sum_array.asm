; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    num_array dq 10, 20, 30, 40, 50, 60, 70, 80
    len equ $-num_array
    printf_format db "Sum of items in array is: %lu", 10, 0


section .text

extern printf
global main


; Equivalent signature:
; unsigned long sum_array(unsigned long *a, size_t num_items);
sum_array:
    ; Initialize base register to 1st argument.
    mov rbx, rdi

    ; Initialize counter to 2nd argument.
    mov rcx, rsi

    ; Initialize accumulating register to 0.
    xor rax, rax

    ; Compute sum in accumulating register.
.again:
    add rax, [rbx + rcx * 8 - 8]
    loopnz .again

    ret


main:
    push rbp
    mov rbp, rsp

    ; Call sum_array(num_array, len / 8).
    ; rdi <- num_array
    ; rsi <- len / 8 (shift right 3 bits).
    mov rdi, num_array
    mov rsi, len
    shr rsi, 3
    call sum_array

    ; Print sum.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
