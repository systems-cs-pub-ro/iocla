extern printf

section .rodata

    fmt_str: db "Sum is: %u", 10, 0

section .text

global main


sum:
    push ebp
    mov ebp, esp

    ; ecx <- last number, passed as argument
    mov ecx, [ebp+8]
    ; eax is sum
    xor eax, eax
again:
    add eax, ecx
    loop again

    leave
    ret


main:
    push ebp
    mov ebp, esp

    ; sum(100);
    push dword 10
    call sum
    add esp, 4

    ; printf("Sum is: %u\n", sum);
    push eax
    push fmt_str
    call printf
    add esp, 8

    leave
    ret
