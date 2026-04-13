; SPDX-License-Identifier: BSD-3-Clause

section .note.GNU-stack noalloc noexec nowrite progbits


section .rodata

    printf_err_format db "Incorrect number of arguments. Expected 2, got %d.", 10, 0
    printf_dot_format db "argv[1] doesn't start with a . (dot)", 10, 0
    printf_format db "argv[1] is %s", 10, 0


section .text

extern printf
global main


; int main(int argc, char **argv)
main:
    push rbp
    mov rbp, rsp

    ; argc is 1st argument, stored in rdi.
    cmp rdi, 2
    jne .improper_num_args

    ; argv is 2nd argument, stored in rsi.
    ; argv[1] is [rsi+8]
    mov rsi, [rsi+8]

    cmp [rsi], byte '.'
    jne .not_dot

    ; printf("argv[1] is %s\n", argv[1])
    ; rdi <- printf_format
    ; rsi <- argv[1]
    lea rdi, [printf_format]
    xor rax, rax            ; no vector register arguments
    call printf

    jmp .end

.not_dot:
    lea rdi, [printf_dot_format]
    xor rax, rax            ; no vector register arguments
    call printf

    jmp .end

.improper_num_args:
    mov rsi, rdi
    lea rdi, [printf_err_format]
    xor rax, rax            ; no vector register arguments
    call printf

.end:
    leave
    ret
