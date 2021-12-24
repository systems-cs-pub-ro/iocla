section .data
global init

init: dd 3

section .bss
global non_init

non_init: resd 1

section .rodata
global ro

ro: dd 10

section .text

global main

main:
    push ebp
    mov ebp, esp

    leave
    ret
