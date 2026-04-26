; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    num_array dq 10, 20, 30, 40, 50, 60, 70, 80
    len equ ($-num_array)/8         ; number of elements
    printf_format db "Sum of array elements is: %lu", 10, 0


section .text

extern sum_array
extern printf
global main


main:
    push rbp
    mov rbp, rsp

    ; Call sum_array(num_array, len) using the System V ABI.
    ; 1st argument (array pointer) in rdi.
    ; 2nd argument (number of elements) in rsi.
    mov rdi, num_array
    mov rsi, len
    call sum_array

    ; Print result.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    xor rax, rax            ; return 0
    leave
    ret
