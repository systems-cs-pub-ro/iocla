section .data
values:      dd 7, -2, 10, 5, 4
values_len:  equ ($ - values) / 4
fmt_print:   db "asm_call_c sum = %d", 10, 0

section .text
global main
extern sum_array_c
extern printf

main:
    push rbp
    mov rbp, rsp

    lea rdi, [rel values]
    mov esi, values_len
    call sum_array_c

    mov esi, eax
    lea rdi, [rel fmt_print]
    xor eax, eax
    call printf

    xor eax, eax
    leave
    ret
