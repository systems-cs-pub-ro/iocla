; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    printf_format db "Sum is: %ld", 10, 0


section .text

extern add
extern printf
global main


main:
    push rbp
    mov rbp, rsp

    ; Call add(2, 3) using the System V ABI.
    ; 1st argument in rdi, 2nd argument in rsi.
    mov rdi, 2
    mov rsi, 3
    call add

    ; Print result.
    lea rdi, [printf_format]
    mov rsi, rax
    xor rax, rax            ; no vector register arguments
    call printf

    xor rax, rax            ; return 0
    leave
    ret
