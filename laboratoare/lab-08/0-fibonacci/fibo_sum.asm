%include "../utils/printf32.asm"

section .data
    N dd 9 ; compute the sum of the first N fibonacci numbers
    
section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp
    ; TODO: calculate the sum of first N fibonacci numbers
    ;       (f(0) = 0, f(1) = 1)
    xor eax, eax     ;store the sum in eax
    
    ; use loop instruction 

    PRINTF32 `Sum first %d\n\x0`, [N]
    PRINTF32 `fibo is %d\n\x0`, eax
    xor eax, eax
    leave
    ret