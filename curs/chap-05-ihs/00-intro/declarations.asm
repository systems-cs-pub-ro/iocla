section .data
    var1: db 9
    var2: dw 10
    var3: dd 11
    arr1: db 8, 9, 10
    arr2: dw 8, 9, 10
    arr3: dd 0xAABBCCDD, 0x11223344, 0x55667788
    str: db "Hello World",0

section .bss
    a: resb 4

section .rodata
    b: dd 9

section .text
    global main

main:
    xor eax, eax
    mov al, [var1]
    mov ah, [var1]
    mov ax, [var2]
    mov eax, [var3]

    xor ebx, ebx
    mov bl, [arr1]
    mov bh, [arr1 + 1]
    mov bl, [arr1 + 2]

    mov bx, [arr2]
    mov bx, [arr2 + 2]
    mov bx, [arr2 + 3]

    mov ebx, [arr3 + 4]

    mov cl, [str]
    mov ecx, [str]

    mov eax, [a]
    mov ebx, [b]

    mov ax, [var1]
    mov ax, [var1 + 1]
    mov eax, [var1]
    mov eax, [arr3 + 2]

    mov dword[a], 0xaabbccdd
     ;mov [b], ebx
     mov dword[a], 20

    ret
