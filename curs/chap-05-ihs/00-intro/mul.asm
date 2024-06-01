section .data
    num1: dd 10
    num2: dd 40

    num3: dw 500
    num4: dw 3

    num5: dw 1

section .bss
    a: resb 4

section .text
    global main

main:

    mov al, [num1]
    mov bl, [num2]

    mul bl

    mov ax, [num3]
    xor dx, dx
    mov cx, [num5]
    div cx

    mov ax, [num3]
    mov cl, [num4]
    div cl

    ;mov ax, [num3]
    ;mov cl, [num5]
    ;div cl

    ret
