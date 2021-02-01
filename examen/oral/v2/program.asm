extern fgets
extern printf
extern stdin
extern strlen
extern malloc
extern strncpy

section .data
    fmt_string: db "%s", 0xd, 0xa, 0
    fmt_decimal: db "%d", 0xd, 0xa, 0

section .bss
    arr resd 1
    len resb 1

section .text
global main

do_something:
    push ebp
    mov ebp, esp

    xor eax, eax
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
looping:
    add al, byte [ebx + ecx - 1]
    dec ecx
    jnz looping

    leave
    ret

main:
    enter 32, 0
    mov dword[ebp-8], 0xdeadbeef
    push dword [stdin]
    push 128
    lea eax, [ebp - 32]
    push eax
    call fgets
    add esp, 12

    lea eax, [ebp - 32]
    push eax
    call strlen
    add esp, 4
    dec eax
    mov byte [ebp + 1*eax - 32], 0
    mov byte[len], al

    push eax
    call malloc
    add esp, 4
    mov dword[arr], eax
    xor eax, eax
    mov al, byte[len]
    push eax
    lea eax, [ebp - 32]
    push eax
    push dword[arr]
    call strncpy
    add esp, 8

    push dword[arr]
    call do_something
    add esp, 8

    push eax
    push fmt_decimal
    call printf
    add esp, 8

    push dword[arr]
    push fmt_string
    call printf
    add esp, 8
    xor eax, eax
    leave
    ret
