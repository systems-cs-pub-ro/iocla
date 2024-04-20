%include "printf32.asm"

section .data
    N dd 9 ; compute the sum of the first N fibonacci numbers
    sum_print_format db "Sum first %d fibonacci numbers is %d", 10, 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: calculate the sum of first N fibonacci numbers
    ;       (f(0) = 0, f(1) = 1)
    xor eax, eax     ;store the sum in eax
    xor ebx, ebx ; f(0) = 0 ebx=>termenul n-2
    mov edx, 1 ; f(1) = 1 edx=>termenul n-1
    mov ecx, dword [N] ; contorul in ecx

    test ecx, ecx
    jz end_for

for_loop:
    add eax, ebx ; actualizam suma
    add ebx, edx ; edx = termenul curent
    xchg ebx, edx

    loop for_loop

end_for:

    push eax
    push dword [N]
    push sum_print_format
    call printf
    add esp, 12

    xor eax, eax
    leave
    ret
