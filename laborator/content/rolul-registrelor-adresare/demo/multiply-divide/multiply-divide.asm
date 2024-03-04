%include "../../utils/printf32.asm"

section .text

extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 10
    mov ebx, 30
    mul ebx

    PRINTF32 `Result is: %d\n\x0`, eax
    xor edx, edx

    mov eax, 10
    mov ebx, 3
    div ebx

    PRINTF32 `Quotient is: %d\n\x0`, eax
    PRINTF32 `Remainder is: %d\n\x0`, edx

    leave
    ret

