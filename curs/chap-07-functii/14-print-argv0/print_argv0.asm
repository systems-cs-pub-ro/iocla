; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    printf_format db "argv[0] is %s", 10, 0


section .text

extern printf
global main


; int main(int argc, char **argv)
main:
    push rbp
    mov rbp, rsp

    ; argv is 2nd argument, stored in rsi.
    ; argv[0] is [rsi]
    mov rsi, [rsi]

    ; printf("argv[0] is %s\n", argv[0])
    ; rdi <- printf_format
    ; rsi <- argv[0]
    lea rdi, [printf_format]
    xor rax, rax            ; no vector register arguments
    call printf

    leave
    ret
