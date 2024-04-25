%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp
    mov ecx, 0

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power
    PRINTF32 `merge ..ham!%d\n\x0`, ebx 
l1:
    mov ecx, eax
    and eax, 1
    cmp eax, 1 
    JE pr
    JMP nt
pr:
    PRINTF32 `%d\n\x0`, ebx 
nt:
    SHL ebx, 1
    SHR ecx, 1
    mov eax, ecx
    loop l1
    
    leave
    ret
