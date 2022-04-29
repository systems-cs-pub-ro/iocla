%include "../utils/printf32.asm"

section .text

extern printf
global main
main:
    ; numbers are placed in these two registers
    mov eax, 1
    mov ebx, 4 

    cmp eax, ebx
    jg finish

    push eax
    push ebx
    pop eax
    pop ebx

finish:
    PRINTF32 `Max value is: %d\n\x0`, eax ; print maximum value

    ret
