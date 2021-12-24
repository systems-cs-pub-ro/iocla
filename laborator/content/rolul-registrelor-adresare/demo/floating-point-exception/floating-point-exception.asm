%include "../../utils/printf32.asm"

%define ARRAY_SIZE 10

section .text

extern printf
global main

main:
    push ebp
    mov ebp, esp
    xor eax, eax
    xor ebx, ebx

    mov ax, 22891
    mov bl, 2
    div bl

    PRINTF32 `Result is: %hhd\n\0`, eax
    shr eax, 8
    PRINTF32 `Result is: %hhd\n\0`, eax

    leave
    ret

