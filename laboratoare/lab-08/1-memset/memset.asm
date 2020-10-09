%include "../utils/printf32.asm"

%DEFINE LENGTH 20

section .data
    string db "Nunc tristique ante maximus, dictum nunc in, ultricies dui.", 0
    char db 'a'

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: set al to the char to memset with;

    ; TODO: set edi to point to the destination string

    ; TODO: set ecx to the number of times stosb will be performed

    ; TODO: use a stosb loop to store to string; use no more than 1 instruction

    ; print the string
    PRINTF32 `%s\n\x0`, string

    xor eax, eax
    leave
    ret
