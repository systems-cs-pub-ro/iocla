; SPDX-License-Identifier: BSD-3-Clause

BITS 64
extern printf
extern get_max

section .data
    arr: dd 19, 7, 129, 87, 54, 218, 67, 12, 19, 99
    len: equ $-arr

    print_format: db "max: %u", 13, 10, 0

section .text

global main

main:
    push rbp
    mov rbp, rsp

    ; Compute length in eax.
    ; Divide by 4 (we are using integer data type of 4 bytes) by
    ; using shr 2 (shift right with 2 bits).
    xor rax, rax
    mov eax, len
    shr eax, 2

    mov rsi, rax
    mov rdi, arr
    call get_max

    ; Print max.
    mov rsi, rax
    xor rdi, rdi
    mov rdi, print_format
    call printf

    leave
    ret
